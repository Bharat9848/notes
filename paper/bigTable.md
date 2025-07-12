## Data model
- Multiple columns are grouped in a **column family**
- data is partitioned horizontally. Each partition is called **Tablet**.
- Each cell holds the unique version of data based on timestamp.
- Tablet are stored in SST table format on GFS/colossus file system.
## Rough
- Based on Google File System/colossus.
- sparsely filled table 
- scalable to billion of rows and thousands of columns.
- offers low latency 
- offers high read/write throughput
- "Bigtable uses a hierarchy to locate data shards. The first level is stored in another service called Chubby to bootstrap that lookup process. Usually, whenever someone writes into a Colossus, the associated metadata goes to a Bigtable instance. But when this specific Bigtable instance puts its data into Colossus, it especially puts the location metadata using a lean hierarchy (probably just one level) of shards. The main Colossus metadata can use many instances of such Bigtable to scale."