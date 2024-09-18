# Voltdb
## VoltDB avoids the overhead of traditional databases
- K-safety for fault tolerance
- no logging
- In memory operation for maximum throughput
- no buffer management
- Partitions operate autonomously and single-threaded
- no latching or locking

## Tables
 - Partitioned Tables: 
    Tables are partitioned using some partition column per CPU core. 
 - Replicated Tables:
    Table size is small hence replicated full across all partitions.

## ACID support
  - Serializability is achieved on transactions that can be done on a single partition. 
  - no interactive transactions support.
  - transactions are defined in terms of stored procedure.

## data storage
## data query

