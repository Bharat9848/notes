
# Stored Procedure
 - Multiple SQL statements is clubbed in a stored procedure saved with database. 
 - Operational challenges like different syntax for different DBs, unmanagable code and difficult perfomance tracking make stored procedure unattractive.
 - Modern stored procedure allowed languages like java, groovy etc.
 - Usage see VoltDB use of stored procedure for replication.

# Transaction
 - OLTP transactions should be short.

## Transaction problems
 
### Race conditions by parallel transactions
- Dirty Read: Read uncommitted data of a transaction and make decision.
- Dirty Write: Before commiting the transaction, write on commited data. It does not happen in reality as it can lead to atomicity violation. It can only happen if transaction see each other write before commits
- Read Skew / Nonrepeatable Read: Repeated query on database gives different result within a span of transaction.
- Lost Updates: 
- Write Skew
- Phantom Read.

## ACID

### Isolation level
1. Read Committed
2. Repeatable Read
3. Snapshot Isolation
4. Serializable: 
  - Gaurantees no race conditions between parallel transactions. System will act as parallel transactions are running one after another.
  
  - Implementations
    
    1. **Active Serial Execution**: Single thead executes transactions serially. With the advent of cheaper RAM and sharded dataset, whole dataset is kept in RAM only. It makes transactions blazingly fast. Secondly if transaction scope is small then they can run very fast. But throughput is only limited that of one CPU core. If database partition in a single node that allows data in a single partition enough for single transaction, then by binding each partition to a single core, scalability is achieved linearly with number of CPUs.(see VoltDB) Cross partition are tough to scale. Write throughput on a single partiotion cannot be scaled beyond single core performance.

    2. **Two phase locking**: 
    - most restrictive read and write locks. Read can block the write. Write is an exclusive lock.
    - read is a shared lock
    - Deadlock can happen as two transaction can wait for each other lock objects. Vendor database have to put deadlock detection and resolving mechanism in place.
    - very bad performance as it required lot of locks and waiting for other contention transactions to complete.



## Implementation notes
 - Logical locking 
  1. Row level lock
  2. Database level lock
  3. table level lock

Most relational database systems execute the ALTER TABLE statement in a few milliseconds—with the exception of MySQL, which copies the entire table on ALTER TABLE, which can mean minutes or even hours of downtime when altering a large table. Various tools exist to work around this limitation of MySQL.

Running the UPDATE statement on a large table is likely to be slow on any database, since every row needs to be re-written.


Postgres does not have true replica MVCC support. The fact that replicas apply WAL updates results in them having a copy of on-disk data identical to the master at any given point in time. This design poses a problem for Uber.??
