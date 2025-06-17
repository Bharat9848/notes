# GFS
## Usecases
1. applications with large number of small files.
2. applications with small number of big files.

## Requirement
1. custom consistency model: Non POSIX compliant(require random access and strong consistency model)
2. availability
3. Durability
4. High throughput: low latency write with append usecases.
5. Scalability - handle large amount of clients
6. Data store - Create/update/delete files or directories atomically.
7. Data reterival
8. Easy to operate: multi tenent and provide data safety
9. Open file: client can open file for read or write while other client can also be writing on it.
10. File/directory snapshots

## Architecture
- GFS client
  - Client ask for chunkIds and location of all chunkservers for a file.
  - client connect with chunkserver for data.
  - client buffers a complete chunk while application reads it.
  - Client to chunkserver communication is called data flow. While client to manager flow is called control flow.

- GFS Manager
  - assign chunkservers to chunkIds included replicas.
  - stores mapping of file and list of chunkId with their chunk server names.
  - For performance put all metadata in memory.
  - metadata is backed up using operation log for recovery.
  - data replication and rebalancing
  - Garbage collection of deleted data
  - operation lock for data consistency
  - stores location of chunkserver
  - namespace management and access control.
  - choose write replica for write.
  - migration among chunkservers: to rebalance the load and disk usage or health check failure.
  - Handle chunkserver health management which includes how much space is left.
  - failure and recovery: Manager save its metadata in form of operation log which provides the sequencing of operation using logical clock. These logs are persisted on node. The manager does not store the current location of chunks persistently. Rather it rebuilds that information on restart from the chunkservers via heartbeat messages.

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
   - write consistency ?
   - write atomicity and concurrency ?

- File snapshot


## Mechanism
- Replication
- Re-replication
- Garbage collection
- Snapshots:
- Stale data detection and fixing
- Data storage: File is stored in form of fixed size chunks. Chunks are given 64-bit globally unique id.
- Namespace
- concurrency: leases and mutation order, Atomic record, namespace management and locking

## Drawbacks
- single control plane
- scale up to petabytes(10^6 GB)
