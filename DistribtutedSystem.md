## Fault tolerance
 - Replication 
 - Recovery need idempotency 

## Scalability
 - Data partitioning
  1. single leader
  2. multi leader
   - can provide geographical data center redundancy
  3. leaderless. 
 - problem of secondry indexes 
 - Load balance processing/querying
    1. leaderless 
    2. single leader
    3. multi leader

## Consistency
 - **Casual ordering**

 - **Total Order broadcast** 
  - Every message is applied in same order to all replicas.
  - **Linearizability** read your own update.
  - Drawbacks:
   1. not scalable beyond a point. scalability would requires the usecase to be handle by multi nodes. 
 
 - **Exactly-once semantics**
  1. Idempotent operation and retrying: 
   a. Using offset
   b. idempotent operation by nature
  2. Distributed transaction
   
## Batching
 - output of batch system can be database files directly.
 - Map and reduce
 1. map stage - requires immutability of input, no side effects, output will be sent to different partition in distributed database based on a key, output will again be sorted by SST.
 2. Reduce


## Streaming 
 1. map and reduce stages are blurry they are called operator. 
 2. Operator maintain managed fault tolerant state.
 3. fault tolerance require mini batching and checkpoint mechanisms. 

Reads are more frequent than writes than do more work with each write to compensate less work to be done when read request comes.- Example Twitter to make it more scalable.

1.Measure Performance
1st fixate on the load. Now when you increase a load parameter, and keep the system resources (CPU, memory, network
bandwidth, etc.) unchanged, how is performance of your system affected?


If your application does use many-to-many relationships, the document model becomes less appealing.
