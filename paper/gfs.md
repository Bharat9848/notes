# GFS
## Usecases
1. applications with large number of small files.
2. applications with small number of big files.
3. data should be written in chunks of fixed lengths. It can also be writen with checksum.

## Requirement
1. custom consistency model: Non POSIX compliant(require random access and strong consistency model)
2. availability
3. Durability
4. High throughput: low latency write with append usecases.
5. Scalability: handle large amount of clients
6. Data store - Create/update/delete files or directories atomically.
7. Data reterival
8. Easy to operate: multi tenent and provide data safety
9. Open file: client can open file for read or write while other client can also be writing on it.
10. File/directory snapshots

## Schema and terms
- `metadata` is fileMeta `(filePath, fileChunkSeqId, chunkHandle, chunkVersion, chunkServerIP)` which is file-to-chunk mapping and chunk-to-location mapping and lease information which decide which chunkserver is primary. 

## Architecture
- GFS client
  - Client asks Manager for chunkIds and location of all chunkservers for a file.
  - client connect with chunkserver for data.
  - client buffers a complete chunk while application reads it.
  - Client to chunkserver communication is called data flow. While client to manager flow is called control flow.
  - Manager returns next few sequential chunkhandle along with queried chunk to optimize manager to client communication. It optimizes the read query.


- GFS Manager
  - **Placement strategy**  assign chunkIds to chunkservers spawned on possibly on different racks. In case of multiple chunkserver failure, then the chunk is re-replicated on higher priority. 
  - stores mapping of file and list of chunkId with their chunk server names.
  - For performance It put all metadata in memory.
  - manages data replication and rebalancing
  - triggers garbage collection of deleted data
  - provides operation lock for data consistency
  - stores location of chunkserver
  - manages namespace management and access control.
  - choose write replica for write.
  - migration among chunkservers: to rebalance the load and disk usage or health check failure.
  - Handle chunkserver health management which includes how much space is left.
  - **failure and recovery**: Manager save its metadata in form of operation log which provides the sequencing of operation using logical clock. These logs are persisted on node. In case of temporay failures Manager restore the state from checkpoints and reapply any pending operation from the operation log. In case of permanent failure the new manager comes at different node form the checkpoint and operation log stored at remote location.
  - **Shadow manager**: reads the operation log of primary and applies to itself. Shadow manager lags behind the primary. It can serve the read queries in case usecase allow stale data tolerance.
  - **Manager state** 
   1. It have `soft-state` which is rebuild after restart and it is not part of data which is stored persistently. Manager soft state is chunkId-to-chunk location mapping as it will be returned by chunkservers in their heartbeat messages.
   2. persisted metadata is backed up using checkpointing and operation log for recovery. It is synced to a remote location via synchronus replication. 

- GFS Chunkserver
  - maintain an index for chunk-handle to block disk location ?
  - Storage system
   - random read/write will incur high latency.
   - sequential read/write are fast.
   - chunks: Each file is broke into chunks of fixed size of 64MB. Each chunk is given a unique Id called `chunk handle`. Large chunk size is choosen to minimize the interaction between the chunkserver and client. Same is true for client and manager connection. 
   - For files with sizes lower than 64MB leads to fragmentation. 
      - We can use Lazy space allocation. It does this by postponing the physical space allocation for a chunk until enough data has accumulated.
      - increase the replication factor of small files to prevent chunkserver to become hotspot.
      - read from client peers instead of chunkserver 
   - write consistency - see data consistency below
   - write atomicity and concurrency: see data consistency section below


## Mechanism
- Replication: primary replica gives serial number to mutations.
- `defined` region
- `undefined` region
- Data consistency: Writing of data can be visualized in different dimensions. one dimension would be serial write vs concurrent writes. Other dimension would be random write vs append write.
 1. random write with serial order
    - retrying:
 2. random write with concurent writes
    - retrying:
 3. append write with serial order
    - retrying: it will lead to duplicate data and extra padding. Client should handles this by using checksum and monotonically increasing id to records.
 4. append write with concurrent writes 

- Data deletion: Since files are big in size. A garbage collection process looks for the file chunks which were marked deleted by the client. It scans the metadata from the manager and deletes the chunks.
- Snapshots: GFS snapshots are lazy in nature, it employs `copy-on-write` strategy to be performant. Snapshotting a file or directory creates new metadata enteries which are mapped to original source chunks. Once client starts to write on original chunks, Manager sends signal to copy data from original chunk handle to new chunk handles. It then updates the snapshot metadata to new chunk handles.

- Stale data detection and fixing:  `chunk version` is updated on new lease grant. Lease is given by the manager to the client in case of any modify operation. `Chunk version` is also communicated to client and it will be cached at client side. It will be stale after some time, thus client may sees the stale data time to time. In case any chunkserver fails due to node is down. Upon restart chunkserver will sync with manager and Manager checks the current version of chunk handle and mark some of them stale where new data operations have been done. Chunkserver will resync with healthy replica for stale chunkIds. Manager will not send 
stale chunkserver in its metadata response.

- Data corruption: checksum of chunks should match across replicas. 

- Data storage: 
  - File is stored in form of fixed size chunks. Chunks are given 64-bit globally unique id called `chunk handle`. 
  - Before writing to storage, manager take read lock for all the intermediate path directories and then it takes write lock for the file. Granular lock helps in performance of writes and reads.
  - Actual data is flowed linearly from the client to the chunkservers. This is part of `data flow` and it is independent of which is primary or secondary replicas. client sends the data to its nearest chunkserver which then sends the data to its nearest and so on. It helps in reducing network congestion.
  - write can be random in this case client first calculates the appropriate chunk sequence number. Then it will ask for chunkId of the sequenceId from the manager, if it does not have the information in its cache. Manager will reply with (chunkserver locations, chunkId and primary chunkserver). Client sends the data to all the chunkservers and ask primary to perform write operation which is followed by serialized execution on all other replica.
  - Write can be append operation. In case of append client asks the manager for the last chunkId location. After getting last chunkId location, client will ask chunkserver to append the data. 
    - In case if chunk is already full primary will reject the operation. client will ask manager to return allocate new chunk. 
    - In case if chunk is partially full. In this case after writing some of the data to last chunk. client asks for new chunk for the remaining data.
    - In case if chunk can accomodate the new data, chunkserver will return successful acknowledge to the client.  



- Namespace
- concurrency: leases and mutation order, Atomic record, namespace management and locking
## Evaluation
 1. Scalability: GFS is horizontally scalable to store petabyte of data by adding more chunkserver to the system. But it is limited due to single manager node. 

## Drawbacks
- single control plane
- scale up to petabytes(10^6 GB). Due to this scalability issue whenever an application breaches the limit, a new GFS cluster was being used. 
- scale upto million of files only
- not good for latency friendly applications because of chunkserver failures and Manager failure. 
- For applications with large number of small files, have metadata equals to the data. Managing the big metadata in manager memory is a risky and this increases the recovery latency.

# Colossus
## Requirements
- scale beyond exabyte (1000 petabyte)
- low latency: GFS was not good for latency friendly applications like online-gaming, video confrencing etc. To counter GFS drawback google launched colossus.
## Architecture
### Components
- client library
  - choose storage pattern either full replication vs Reed-solomon erasure encoding.
- Curator
  - manages metadata mapping for different clients.
  - multitanent and provides data isolation
  - horizontally scalable.
  - store data in bigTable datastore.
  - Metadata sharding must have been done using some version of consistent hashing
  - Partitions splitting and merging is done by bigtable.
- D-file server
- BigTable data storage
- Control plane  
