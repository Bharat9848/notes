## Brief summary


---

## Architecture and design 
1. HLD
```mermaid
  A[chubby client] ---> B[Master server]
  B[Master Node] ---> C[(tablet servers)]
  A --data?-> D
```
2. write data
```mermaid
 client ---> tablet server
 tablet server -data--> commit log
 tablet server --data-> Memtable
```
3. read data
```mermaid
 client ---> tablet server
 tablet server -query--> index
 tablet server --data--> SSTable lookup/memtable.
```
4. Caching client data

### Paritioning
- Rows are sorted lexicographically. Then row ranges are dynamically partitioned. Each partition is called **Tablet**.
- Data is partitioned horizontally. 
- Tablet are stored in SST table format on GFS/colossus file system.
- Tablets can be merged/divided further

### GFS Storage
- tablet files are stored in GFS
### Chubby usecase
- Manages metadata: Stores bigtable bootstrap data.
- Service discovery: Master uses a chubby location to discover all the tablet server. Master subscribes to any changes to tablet server directory. Tablet server holds exclusive lock on special file that represent it.  

---


## Data model

### Tablet data model
- It is a map, where key is rowKey,colkey and timestamp and value is column value.
- Each cell holds the unique version of data based on timestamp.
- Each column is referred with column family qualifier `<columnFamily:column>` .
- Each cell stores multiple version in form of having different timestamp.	
- Multiple columns are grouped in a **column family**
- Tablets are merged and split on the basis of volume of data.

### Metadata data model

- Root-tablet data model
  - can't be split further.
  - it host all the special `METADATA` tablet
- METADATA tablet
  - store USERTABLE reference of set of user tablet.  
  - row key is encoding of `<userTablet><endrow>` 
  - each row stores 1KB of data.
- USERTABLE tablet
  - stores the tablet server locations. 	
- all the above tablets are also stored in tablet servers alongwith chubby
---
## storage
 - multiple SSTable make a single tablet.
 - SSTable is a series of 64KB blocks and index file where each block starting index are stored. Index file is searched using binary search to find the appropriate block and loaded from the disk.
 - Memtable is in-memory data buffer where data is stored in sorted order and when it reaches a limit it is flushed to disk as SSTable.
 - SSTable is stored in GFS. 
 - Multiple column family can be combined to form a **locality group**. Locality group stores all the column to get stored together. It helps in increasing performance overall. Locality group can be marked as in-memory. In-memory locality group are kept in RAM and loaded lazily without refering to disk.
 - **compression** : SSTables blocks are the unit of compression. Client can opt for compression.

---

## Components
### Tablet server
  - split tables when data grows large. Minimum criteria for tablet splits is when it goes beyond 100-200MB of size.
  - read/write to its stored data.
  - Each server stores 10s to 1000s of tablets.

### Master server
  - `load tablet request`: sends request to new tablet server to load a new tablet.
  - Maintains set of live tablet server nodes against a tablets.
  - Assigning and unassigning of tablet server
#### Master init sequence
  - Master create master file in chubby
  - Master looks for all the alive tablet server in chubby servers directory.
  - Master takes note all the alive tablet servers about their assigned tablets.
  - Master checks bootstrap `metadata` data to check if there are any unassigned tablets and take note of them. 
#### Master node failure
  - If master loss its exclusive lock because of network partition or its chubby session expires it tries to delete its master data. To avoid problems like split brain etc.  

## cluster management
### Google Chubby
 - bootstrap location of bigtable data: Stores of all the usertables tablet using a hierarchical tree. see Metadata data table section.
 - store bigtable schema ?
 - Service discovery of new tablet server.
 - remove tablet server due to issues ?
 - one active server at a time ?
 - Single Master node: Master election
---

## fault tolerance
1. Tablet server Issues
  1. Graceful shutdown: When tablet server deallocated by cluster management, tablet server tries to release its exclusive lock. Master noticed this as it watches the directory, then it immediately start assigning its tablet to other nodes. 
  2. Network partitioned b/w chubby server and tablet server: On recovert tablet server tries to retake exclusive lock. If lock directory is not there it will kill itself. Otherwise it recovers???.
  3. Network partitioned b/w chubby server and master node: Master node repeatedly ask for chubby server file lock status from all the tablet server. Master node checks the chubby server for its server file and tries to take a lock on it. If 
2. Master node
  1. Chubby session expired: Manager kill itself.
  2. Master restart algo sequence.
3. Tablet recovery
  1. Tablet server reads Bootstrap metadata table for all the tablets assigned to it. Additionally it contains list of SSTables and redo points. 
  2. redo points to the commit log location from which server needs updates to be replayed to the memtable.
  3. server loads all the SSTable indexes and prepare Memtable from commit log.  

## concurrency
- Each row irrespective of number of columns are updated atomically. Transactions across multiple row keys are not allowed.

## consistency
## performance
 - Locality group optimization can make performance faster if data is segragated into locality group smartly.
 - Caching: 
   - Scan cache:
     - stores famous key-value pairs.
   - Block cache:  
     - stores recenly fetched blocks. It helps in fetching nearest neighbor blocks.
 ## Latency
 - Client caches the metadata and talk to tablet server directly.
 - Client prefetches the metadata.
 - Bloom filter decrease the latency of read in case false positive/ true negative and it is maintained at locality group level.

 ## Throughput

## Rough
- Based on Google File System/colossus.
- sparsely filled table 
- scalable to billion of rows and thousands of columns.
- offers low latency 
- offers high read/write throughput
- "Bigtable uses a hierarchy to locate data shards. The first level is stored in another service called Chubby to bootstrap that lookup process. Usually, whenever someone writes into a Colossus, the associated metadata goes to a Bigtable instance. But when this specific Bigtable instance puts its data into Colossus, it especially puts the location metadata using a lean hierarchy (probably just one level) of shards. The main Colossus metadata can use many instances of such Bigtable to scale."
"Access control and both disk and memory accounting are performed at the column-family level."
- "bootstrap location of bigtable data".
- processes often share the same machines with processes from other applications. Bigtable depends on a cluster management system for scheduling jobs, managing resources on shared machines, dealing with machine failures, and monitoring machine status.

## Questions
- what is the purpose of column family.
- how big table is throughput/latency friendly.
- How big table leverages chubby ?
- How big table leverages GFS ?

