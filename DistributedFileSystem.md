## Concepts
- Directory based structure is namespaces.
- Reed Solomon based encoding
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

## HDFS
- data can be compressed using LZO algorithm.

## GFS
-- see gfs.md
