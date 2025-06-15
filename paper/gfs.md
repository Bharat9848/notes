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
6. Data store
7. Data reterival
8. Easy to operate: multi tenent and provide data safety

## Architecture
- GFS clients
  - Client ask for chunkIds and location of chunkserver for a file
  - client connect with chunkserver for data.

- GFS Manager
  - assign chunkservers to chunkIds included replicas.
  - stores mapping of chunkId to chunk server.
  - For performance put all metadata in memory
  - metadata is backed up using operation log for recovery.
  - data replication and rebalancing
  - Garbage collection of deleted data
  - operation lock for data consistency
  - stores location of chunkserver
  - namespace management and access control.
- GFS Chunkserver


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
