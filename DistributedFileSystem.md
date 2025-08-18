## Concepts
- Directory based structure is namespaces.
- Reed Solomon based encoding: RS(A,B) means that original data of B units of size but it is increased to A unit of size in RS encoding. Reed solomon encoding uses modular arithmetic and Lagrange interpolation. Parity chunks are appended to file data chunks. This chunks help in recovering the file.
- RAID
- NFS: network file system protocol
- NAS: Network attached storage
  - File based single server based on NFS protocol.
  - Many clients writing to single big server.
- SAN: storage area network
 - clients --> host servers ---> storage device arrays.
 - servers are backed by commodity block based storage devices connected via a fiber-channel.
 - Host-bus adapters are store at each level - server, switches and cabling
 - Operationally difficult to manage 
   1. failure of storage device
   2. rebalancing of load after some storage device failure
   3. Data inconsistency among replica.
 - Dedicated storage traffic from other traffic make it costly.  
 - **Rack drain**:  rack drain is a kind of decommissioning done by the service. The control plane of the service wants to stop using a specific rack, and for that, it will need to move data and user requests elsewhere. One reason for such a drain can be planned rack maintenance.

## Fault tolerance
- Use RS encoding. 

## Durability
- we can use RS encoding for warm data which is not access much frequently while we can use full replication for hot data which is accessed very frequenctly.

## HDFS
- data can be compressed using LZO algorithm.

## GFS and colossus
-- see gfs.md

## Tectonic file system
-- see tectonic file system.
