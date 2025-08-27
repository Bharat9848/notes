## Glossary
- Multiple columns are grouped in a **column family**

## Data model
- It is a map, where key is rowKey,colkey and timestamp and value is column value.
- Each cell holds the unique version of data based on timestamp.
- Each column is referred with column family qualifier `<columnFamily:column>` .
- Each cell stores multiple version in form of having different timestamp.	


## concurrency
- Each row irrespective of number of columns are updated atomically. Transactions across multiple row keys are not allowed.

## consistency

## Paritioning
- Rows are sorted lexicographically. Then row ranges are dynamically partitioned. Each partition is called **Tablet**.
- Data is partitioned horizontally. 
- Tablet are stored in SST table format on GFS/colossus file system.

## Rough
- Based on Google File System/colossus.
- sparsely filled table 
- scalable to billion of rows and thousands of columns.
- offers low latency 
- offers high read/write throughput
- "Bigtable uses a hierarchy to locate data shards. The first level is stored in another service called Chubby to bootstrap that lookup process. Usually, whenever someone writes into a Colossus, the associated metadata goes to a Bigtable instance. But when this specific Bigtable instance puts its data into Colossus, it especially puts the location metadata using a lean hierarchy (probably just one level) of shards. The main Colossus metadata can use many instances of such Bigtable to scale."
"Access control and both disk and memory accounting are performed at the column-family level."

## Questions
- what is the purpose of column family