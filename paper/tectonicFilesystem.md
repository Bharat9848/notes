## Previous tech limitation
 - `haystack` system for storing warm data and `f4` system for storing cold data.
 - `haystack` was suffering from low IOPS but have a high storage
 - `f4` have unused IOPS but not enough storage.
 - Fedrated HDFS system was used to track data that have scale beyond terabyte to few petabyte. It adds operational complexity for maintaining different HDFS cluster and data mapping service on application side.
 - inefficient bin packing ??

## Requirement
- scale storage system that goes beyond multiple exabyte so it should be horizontally scalable.
- multitanent data with client isolation is absolute.
- System should be efficient in resource usage.
- configuration to client e.g. replication can be either full replication or reed-solomon based codes for fault-tolerance.

## Components
- Metadata store
  - leverages a scalable key-value store called `ZippyDB`
  - hosts file system logic.
  - hosts `Name layer`, `file layer` and `block layer`
  - consistent metdata operation
  - caching objects.
- chunk store
  - Stores data in form of chunks.
  - provides low level CRUD apis over chunks
  - Also provide APIs for listing and scanning of chunks
  - ReedSolomon(n,k) is applied on blocks for better durability.  	
- stateless background service
  - garbage collection
  - rebalancer: In case of hardware failures, increase disk capacity or rack drain, rebalancer process moves the data around and keep the metadata and data consistent.
  - disk inventory: helps in commissioning or decommisioning of disks.
  - block repair/scan: handles actual data movement of chunks in case of deletion or relocation. Keep data consistent in file and block metadata layer.
  - memory utilization
  - maintenance of storage nodes in cluster
  - handle rack drain
  - stat service: publish filesystem statistics from metadata and chunk related stats from store db.
- client library
  - perform I/O operation. 
  - fetches metadata from metadata store
  - do direct operations to chunk strore.
  - single write semantics
- **ZippyDB**
  - "The store is built on top of RocksDB. It is a compact representation of write requests streaming into the data shuttle so that we can provide a read facility as well. It is plugged into the data shuttle, and the data shuttle orders the number of the write request and pushes the data to the store, so the reader will read the same way the data was written. The data shuttle can plug in multiple stores using the store API." ??
  - uses `rockDB` storage engine
  - key-value store
  - `snapshot read`: When read and write happen simentaneously on a file a snapshot has been taken. Snapshot handler creates a snapshot of a file and propagate read client to read from snapshot. Next read client sees the file is locked and reach out to snapshot handler which further guides it to current snapshot.
  - Read and write partial data: read and combining data from different blocks and trying to get data from the same node.
  - write operation are CAS operation due to inconsistency in data due to partial reads.  

## Deep dives
1. How files are modified
-  Unlike GFS where unit of locking/modification is a file chunk, only one write is allowed on a file. when a file is opened for modification, a token is saved with metadata store and this token is matched with the writer token before allowing write operation.
2. How to find the right block of a given file using metadata.
  - Metadata is divided into 3 layers. Each layer is a stateless microservice sitting over ZippyDB. 
   1. Name layer: Maps directory to subdirectory and files. Data is sharded on the bases of directoryId.
   2. File layer: Maps a file to its block. Data is sharded on the bases of fileId
   3. Block layer: Maps a block to disk location. Data is sharded on the bases of block. It also maintains reverse mapping of disk to blocks which helps disk recovery or recopying in case of disk related issues.
   4. Use disk_id and block_id to get chunkInfo of a files block.
3. How to increase read performance
  1. Sealed objects: Clients are allowed to cache sealed directory, subdirectories and files. It allows faster reads as client can cache them locally. Any new file addition in current sealed directory would require either unsealing of directory in current cluster or new addition is sent to different cluster.  
4. Data integrity
  1. read-modify-write cycle is used to do changes on metadata and file on a single object in a directory
  2. Moving directory from directory A to directory B requires delinking from old parent and adding new linking to new parent.
  3. Moving file from directory A to directory B do copying of file to new directory and then delete the old one.

5. How tectonic file system provides fairness, performance isolation to multi tenent.
  1. quotas of storage are reserved for tenents.
  2. **Traffic groups**: Tenent can group their application based on similarity of applications latency and iops requirements. It helps in resource sharing.
  3. Tectonic classify each tenents traffic groups in three broad categories. Then tectonic FS ensures that the current system can fulfills the system needs based on category. Also check if application needs are within what is allowed at a tenent level.
  4. Policing mechanism to control tenent to use their share exclusively.
  5. "Rough": "
    The gold class is for high-latency requests.
    The silver class is for normal-latency requests.
    The bronze class is for background services.
The fair share of ephemeral resources is achieved using the following three steps:

    Each tenant allocates the required ephemeral resources based on TrafficGroup and TrafficClasses.
    All the spare ephemeral resources in each tenant are made available to be used by tenants cluster-wide, according to the TrafficClass.
    All the unused ephemeral resources (allocated or unallocated) within a tenant are shared with the TrafficGroup within the tenant of a high TrafficClass.

This gives every tenant an equal or fair opportunity to utilize ephemeral resources within a cluster.

Any TrafficGroup that has completed their majority work has spare ephemeral resource. There are two ways to share these resources with lower TrafficClass’s TrafficGroup:

    Within the tenant (high priority)
    To another tenant

In this way, the same set of ephemeral resources that a single TrafficGroup once used can serve other TrafficGroups to meet their requirements.

Let’s learn more about how we manage to share ephemeral resources globally (at the cluster level and mostly across tenants) and locally (at the storage nodes level and mostly within a tenant).
Sharing resources globally

We got a general idea of how to achieve a fair share of ephemeral resources within and among tenants. To do this, we use the rate limiter, which implements the modified leaky bucket algorithm. The modified leaky bucket algorithm tracks the demand for each tracked resource in each tenant and TrafficGroup over the most recent brief period of time using high-performance, near-realtime distributed counters.

All this is done using the following steps:

    Whenever a request comes, it requests for the incremented bucket counter.
    Before entertaining the request, the client library has to look for spare capacity.
        First, it will look for the spare capacity within the same TrafficGroup.
        Secondly, it will look for the spare capacity in a different TrafficGroup within the same tenant.
        Lastly, it will look for the spare capacity in the different tenants with the same TrafficClass priority.
    If the spare capacity is found, the request will be sent to the backend. Otherwise, it can be either delayed or rejected based on its timeout.

This rate limiter avoids potentially wasted requests since failed requests put back pressure on the client.
Sharing resources locally

Global fair sharing of resources was not the only issue. We also have to avoid the local hotspots for storage and metadata nodes. The monitoring of the resources quota is done by using a weighted round-robin (WRR) scheduler for skipping specific TrafficGroup to avoid excessive use of a resource quota. In a cluster, the storage nodes must take precautionary measures to abstain from high-latency requests, such as data warehouse requests, and from using all the resources when the small IO request, such as blob storage requests, are in progress. If Gold TrafficClass requests on storage nodes are obstructed by lower-priority requests, Gold TrafficClass requests are allowed to have delays in their latency targets.

The following three optimizations are used by storage nodes to ensure low latency for the requests of the Gold TrafficClass:

    In WRR, we have used greedy optimization allowing low-latency requests to give up their turn for the high TrafficClass if the request can be completed after the completion of the high TrafficClass. We do this so that they won’t be stuck behind a low-priority request.
    We can apply a limit for every disk to nn number of non-Gold requests to be active. WRR will block all the incoming non-Gold requests from scheduling unless any of the Gold request or active non-Gold request is completed. This allows the blob storage requests to be entertained simultaneously with warehouse requests.
    We have given disks enough liberty to rearrange the IO requests in hand. For example, our system may serve an upcoming non-Gold request earlier than an existing Gold request. If the Gold request has been pending for a specific time period, we stop scheduling the non-Gold requests to a disk.

By combining these three techniques, we can effectively manage the latency profile of a relatively large number of blob storage requests compared to warehouse requests.
    "

6. How to prevent data corruption while reading and writing data from a common source.
  1. Data corruption can be happened within single tenant application or across tenants. To restrict a read/write operation to access only data for which it is authorized, we can implement a lightweight access control. Each tenant will have access control mapping to resources at a application level at a desired granular level. 
  2. Access control implementation
    - We can implement access control through a access token. These access token encrypted the resource and access operation allowed in access token. Consumer can decode them.
    - Access control check should not be a separate call. It can be piggyback on existing APIs. 
    - Access control decrypting and verification should not take more than tens of milliseconds.
  3. Access token are implemented at each layer. Each layer generate access token for next layer.  

7. Performance optimization for small write
  - Partial blocks are appended and then partial block is replicated to other nodes. 
  - Quorum based partial block write is acknowledged to client.
  - read-after-write is made available to writer.
  - writer which created the block is allowed to append ???
  - updated block size and updated checksum is written to block metadata after the append operation.
  - Unlike full blocks, partial blocks are not RS-encoded for better durability. But once partial block is full then it is sealed and RS-encoded. 


8. Performance optimization for big write
  - writes are full block based, hence they are space and latency friendly. 
  - Reads on the block is not allowed till it is written fully.
  - Write uses Reed-solomon encoding of RS(15,9)(It gives error correction upto (15-9)/2).
  - RS enconding helps in decreasing write latency while increasing overall network performance and IO. Because of less data is being written. 
  - **Hedge-based quorum write**: application sent reservation requests first, after getting successful reply from the nodes(no of quorum), actual writes are send to replied nodes. This help in increasing performance of tail latency. As it prevents last min failure due to inadequate capacity.



## ZippyDb architecure
1. Store
  - deployed per shard.
  - store the actual data.
  - "The store is built on top of RocksDB. It is a compact representation of write requests streaming into the data shuttle so that we can provide a read facility as well. It is plugged into the data shuttle, and the data shuttle orders the number of the write request and pushes the data to the store, so the reader will read the same way the data was written. The data shuttle can plug in multiple stores using the store API." ???

2. discovery Service
  - help in registry and discoveries of shards.
  - also have the shard placement and shard role assignment information.

3. shard management service
  - Service sits on above all shards. It helps in manage, relocate and replicate a shard.
  - do load balancing.
  - dictate primary or other roles of a shard to data shuttle component.

4. shard management client
  - deployed per shard.
  - recieve and act on instruction received from shard management service.
  - sends replication related instructions to data shuttle from shard management service.

5. request handler
  - deployed per shard.
  - Recieve and delegate requests from zippyDB client.
  - all read requests are routed to store directly. 
  - While all write requests are routed through data shuttle.

6. zippyDB client
  - client library deployed in metadata store of tectonic file system.

7. Data shuttle
  - deployed per shard.
  - It is used to send all store's shards to another shard. It uses data-replication pipeline.
  - Each shard is assigned dynamic role (using lease) of primary, secondary and follower according to paxos algorithm.

8. ZippyDb deployment unit is called tier which consists of compute and storage resources which are placed geographically for fault tolerance.
9. **Replication** is based on both paxos and async replication. A subset of replicas are choosen to be part of quorum and data is replicated synchronusly using paxos algorithm. Once majority of them confirm the write is acknowledged to client. For the rest of replicas asynchronus replication is used.
10. **Follower** are extra replicas that observes the current state of shards and replicate locally. They dont participate in writes. Follower shards receives the update asynchronously from primary. They are used to scale read usecase.
11. For `read your own write` policy a write returns a sepecial tag which client caches and send it again in subsequent read. In case of a secondary do not have latest data with specified tag, it returns no data.
12. ZippyDb also provides bounded consistency which lie between the strong consistency and eventual consistency. A read replica which falls behind the primary, outside of a bound stops serving read requests.  