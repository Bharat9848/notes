## Glossary
 

## Distributed system failures
- Fail-stop: node stopped working and other nodes can detect failure.
- omission failure: node fail to send and receive some of the messages.
- crash: node failed silently, other nodes cannot detect.
- Temporal failure: request/response too late to be any useful. It is caused by clock skew, high load etc.
- Byzantine fault: Node behaves differently than protocol rules. 

## Consistency, Availability and Partition tolerance - CAP theorem
 - Consistency in CAP theorem means linearizability.
 - Partition tolerance is not a choice and It only considers case for network partitions. 
 - System can only choose between availability or consistency in case of network partition.
 - Disadvantage
  - it does not say anything about network delay, dead nodes or other trade off.
 - **PACELC** theorem extends the CAP theorem. In addition to CAP theorem, in case of no network partition system can only choose **Latency/Performace** or consistency.   

## Failure Detection
 - **Gossip protocol**
 
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

## Replication
 1. Single leader replication
  - linearlizability can affect availability in case of network issues.

 2. Multileader replication
  - useful for multi-datacenter operation.
  - linearlizability can affect availability in case of network issues.
 
 3. leaderless


# Consistency
 - **Split brain** - when two nodes simentaneously behave that they are the only leader.
 - Strong consistency is for strict usecases where some form of ordering is required otherwise situations like split-brain may arise. But implementing stronger consistency is not very performance friendly and make system less resilient to faults.

## Ordering
  1. **Casual ordering**
    - It is a partial ordering of events, especially in case of events are related in "happen-before" or "happen-after" relationship.
    - Concurrent events are not related.
    - More performance friendly than total ordering.

  2. **Total Ordering** 
    - Every message is applied in same order to all replicas.
    - Not performance friendly.

## Type
  1. **Eventual Consistency**
    - Its a weaker gaurantee as it does not gaurantee read your own write.
    - Different replica returns different results. There may be cases where it seems that data is going back in time.
    - It provides high availability

  2. Casual consistency
   - It is lighter version of consistency defines relationship between event as dependent and independent events. Dependent events are called casual events.
   - It serve casual ordering usecases and hence more performant than linearlizability.

  3. **Linearizability**/**Strong consistency**/**Sequential**
    - it is consistency from CAP theorem.
    - It is a stronger gaurantee than eventual consistency. It make all replica and leader behave as a single entity.
    - Once a replica returned a value that means other replica cannot return values which are older than that value. 
    - all the changes happened to a register are atomic.Defintion does not entail multiple row/key-value/register. Linearlizability only covers a single row/key-value/register- ???)
    - read your own update.
    - usecases include leader election, distributed locks and unique constraint like unique username, password change in banking system etc.
  - **Drawbacks**:
    1. Performance hinderess - not scalable beyond a point. Scalability would requires the usecase to be handle by multi nodes. 
    2. Make system unavailable in cases of network partitions and other faults.
  - There may be a case that even after linearizability you get to see values which are not latest. But as they are returned by any replica, it is okay.  
 

 4. **Total order broadcast**
   - Messages are delieverd exactly once and in the same order.
   - it is equivalent to repeated round of consensus.

  ## How
   - **Lamport clock**: 
     - it can define the casual ordering where each node and client sets its sequence to maximum sequence it have seen.
     - logical clock comprises of tuple (nodeId, sequenceId). 
     - Each time client writes or reads form the node they get/send maximum sequenceId.
     - unique NodeId act as tie breaker in case of concurrent events, higher nodeId be considered first. 
     - Disadvantage: Though it gives total ordering to events but in case like unique constraint across multiple nodes lamport clock first accept both concurrent event and then provide the order which will be misleading as system have to reject the event after accepting successfully.
     - useful in cases of multileader replication.

   - Single-leader replication
     - events will be casually ordered as they come to single leader. Leader can choose simple montonically increasing sequence to order them. 
     - cannot scale beyond a single node.

 - **Exactly-once semantics**
  1. Idempotent operation and retrying: 
   a. Using offset
   b. idempotent operation by nature
  2. Distributed transaction

## Consensus Algorithm 
  - Assumes safety property which includes following properties 
    1. Integrity - Node does not change its decision.
    2. Validity - Node chooses some valid values
    3. Uniform Agreement - no two nodes decides differently
  - Assumes Termination property - every node that does not die eventually proposed by some node. 

### Raft
- see papers/raft.md    
   
## Batching
 - output of batch system can be database files directly.
 - Map and reduce
 1. map stage - requires immutability of input, no side effects, output will be sent to different partition in distributed database based on a key, output will again be sorted by SST.
 2. Reduce 

Reads are more frequent than writes than do more work with each write to compensate less work to be done when read request comes.- Example Twitter to make it more scalable.

1.Measure Performance
1st fixate on the load. Now when you increase a load parameter, and keep the system resources (CPU, memory, network
bandwidth, etc.) unchanged, how is performance of your system affected?


If your application does use many-to-many relationships, the document model becomes less appealing.


## Sidecar pattern
 - Additional containers colocated with an application container to augment functionality for application. It usually share some of the system resources like network, disk etc.
 - Usecases of sidcar pattern
   - Legacy application needs additonal functionality.
   - Team do not want to horizontal concerns like security, monitoring to spill in application logic. Thus makes the code more modular.
   - e.g. Nginx sidecar pattern to terminate HTTPS traffic and send HTTP traffic to application container.
   - e.g. Push dynamic configuration using sidecars save it common disk location which is read by application. Sidecar after updating changes on local disk can trigger updates to the application container using some mechanism e.g. SIGHUP, SIGTERM, API etc.
 - Create your own sidecar
   1. parameterize your sidecar e.g. for SSL terminating nginx sidecar it will application port and path to certificate.
   2. Expose the sidecar API
   3. documentation

## Excercise
 - run sidecar topz alongside your container

 ## NoSql
### NoSql Database types
1. Document Based 
2. Column based 
  Usecases: Write-large number of small updates Read - read sequentially. 
  Example: HBase

### NoSql schema designing
1. When to have multiple collections in nosql.
 - If the objects you are going to embed may be accessed in a isolated way (it makes sense to access it out of the document context) you have a reason for not embedding.
 - If the array with embedded objects may grow in an unbounded way, you have another reason for not embedding.Embedding one to many relationship on the one side can help in saving extra queries. But gain can quickly turn into lose if those objects are getting updated very frequently.

2. Three basic different schema design One-to-N relationship in NoSql:
  1. Embed the N side if the cardinality is **one-to-few** and there is no need to access the embedded object outside the context of the parent object.
  2. Use an array of references to the N-side objects if the cardinality is one-to-many or if the N-side objects can be queried independently of 1 side.
  3. Use a reference to the One-side in the N-side objects if the cardinality is one-to-squillions(large indefinte size)

### What to choose - sql or nosql

1. Nosql
  When to use : 
  - **Schema structure** If the data in your application has a document like structure(i.e. a tree with one to many relationships where typically the entire tree is loaded at once) then its probabily is good idea to use document model. However the relational technique of shreddig- splitting the document into multiple tables can lead to cumbersome schema and unnecessay complicated application code.
  - flexible and evolving schema.
  - **size** Suitable for big volume of data.
  - **Compliance** Suitable where eventual consistency can be tolerated.
  - JSON schema has better locality than the multi table schema.

  cons: 1. Many to one and Many to many relatioships are very weakly supported.. As projects get bigger they tend to have more usecases. And subobjects in a document are queried independently of the main object. As soon as these usecases start to have many-to-many and many-to-one queries. It does not fit well in Json schema. This leads to breaking of hierarchial model(JSON) to relational model.
  2. querying a small piece of data from a big document will fetch the whole document.
  3. updation of document size form some update in  some field require rewritten of whole document again. information.

2. Sql
   when to use : 
   - **size** : RDBMS are at their best when performing intensive read/write operations on small or medium sized data sets.
        Need strong consistency.
   - **Compliance** : Usecases that require strict ACID compliance e.g. finance, Banking, ecommerce etc
   - **Schema structure** if the schema is consistent and does not change much. Also data size is limited. 
       
  cons:
        Does not scale well in horizontal scalability bcause of ACID rules

Notes : For highly interconnected data the document model is awkward, the relational model is acceptable and graph model are most neutral.

There is an implicit schema because the application need some kind of structure but it is not enforced by the database. A more accurate term is schema-on-read(the structure of the data is implicit and only interpreted when data is read) , in contrast to schema on write (the traditional approach of relational database where schema is explicit and the database ensures all written conforms to all).

Scheama on read advantages:
Case1: there are many different type of objects and it is not practical to put each type of object in its own table.
case2:The structue of data is determined by external systems over which you have no control and which may change at any time.

### Famous Non sql Database
Cassandra: Records are sharded based on partition keys. Within same partition key records are sorted based on a key. 
BigTable: It combines multiple files in a single block to store on disk. And is very efficient in reading a small amount of data.
HDFS/GlusterFS: Distributed File storage system.Suggested for Video binary stroage

### Bloom filter
- It gives definite answer in case a particular key is not present and it may give false positive in which case key might also not be present.
- Given N bits of master set then each key is passed to K hash functions, each function will return a bit position which is then set to mark the presence of the key.  

### CAP theorem 
It states that any networked shared-data system can have at most two of three desirable properties:
1. Consistency - Every node will serve the latest copy of the data.
2. High Availability - Any non failing node will replies to the request in a certain amount of time
3. Partition Tolerance - System will continue to function even in case of network partition.

As a consequence of CAP theoren in practice, we categorized distributed system following ways  : 
1.CA system: Since this particular system needs to be consistent, therefore in case of network partition the whole system will stopped working as all the nodes need to serve latest data. It is not a coherent design for any distributed application. e.g. RDBMS

2. CP system: This particular kind of system is very similar to CA system but in the case of network partition node will retry indefinitely(loosing Availiblity - read definition) until client times out. e.g. Big tabl, HBASE

3. AP system: These system will continue to serve stale data in case of network partition without comprimising availability. But system will not be consistent. e.g Cassandra, Mongo etc. AP system is also called BASE mean Basically Available Soft-state and Eventually Consistent.

Extension to CAP theorem is PACELC theorem where PAC is from cap theorem which says in case Partition(P) system can choose either Availibility(A) or Consistency(C). And ELC means in case of no Parition (E) system can choose either Latency(L) or Consistency(C). ??? 

## Distributed transaction
### Two phase commit
### Try-confirm/cancel
### Saga

## Time
- NTP: This protocol have shortcoming of time drifting and repeated correction can make it look that events are happening in future
- Lamport clock: each node will have a id and increment unique number. It does not identify casual events

- Vector clock

## consensus
1. Paxos
 - see paxos.md
2. Apache zookeeper, consul and etcd implements consensus algorithm 

## Rough notes
- read about Try-confirm/cancel algo for distributed transaction

