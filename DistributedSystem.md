## Glossary
- **Tail-latency amplification** 

## Distributed system failures
- Fail-stop: node stopped working and other nodes can detect failure.
- omission failure: node fail to send and receive some of the messages.
- crash: node failed silently, other nodes cannot detect.
- Temporal failure: request/response too late to be any useful. It is caused by clock skew, high load etc.
- Byzantine fault: Node behaves differently than protocol rules. 
- communication medium failure:
- secondary storage failure:

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
- Replication is used for scalability, Availability and performance.
- modes
  - Synchronus Replication is where data is replicated synchronusly to replicas. 
    1. It makes write slow.
    2. If replica node crashes it will fail the write request itself. It will make system unavailable for write.

  - Asynchronus Replication is where data is replicated asynchronusly to replicas. 
    1. It make the read replica to have stale data.
    2. If primary fails before data is replicated it will result in data loss.
  
  - Multiple nodes are given same task. Each node will create same artifacts and data according to same logic running on each of them.
  
- Type of replication
 1. Single leader replication
  - linearlizability can affect availability in case of network issues.
  - replication can be done using 
    1. command based replication where `insert/update/delete` were replicated to replicas. System nondeterministic functions like `now()` can lead to different results.
    2. WAL based replication. Primary WAL logs are replicated to secondary it help in preventing non-deteminism. But It lock the db engine of primary and secondary - any maintainence would require node to be move out of cluster.
    3. Logical based replication - instead of actual physical value of WAL, this approach capture the primary node changes in term of `Insert/update` with all the changed values. 

 2. Multi-leader replication
  - explain ??
  - useful for multi-datacenter operation.
  - linearlizability can affect availability in case of network issues.
  - Conflict can happen in case of simentanoues write on a single key. Conflict avoidance, last-write-win or custom logic can be used in such situations.
  - star /circular/ all-to-all topology is used for replication
 
 3. leaderless
 - all nodes can receive read and write for any key
 - quorum is used to break the incosistency of data.


# Partitioning


- **Request routing**

  - How to make sure that there are no two different cluster view because this would lead to data corruption.
  - **Service discovery**:
    1. Client-aware routing: client is intelligent and cached partition assignment to the nodes. 
    2. Dedicated routing tier: client connects to a set of machines like zk nodes/ DNS which are aware of partition assignments. Consensus protocols are used to keep single cluster view. 
    3. Server nodes rerouting: Client connects to any node of server cluster which routes the request appropriately. Each node participates in goosip protocol to keep a single cluster view.
- **Rebalancing**:
  1. it is required in case of new capacity addition to the cluster due to performance degradation over time.
  2. Automatic rebalancing due to machine failures.
  3. Goals are that data should be available while rebalancing is happening, Data should be balanced after rebalancing and minimum data should be moved to keep it resources friendly.
  4. Partitioning type
    1. Fixed number of partitions:
      - care should be given before declaring number of partitions as big number of partitions leads to rebalancing overhead and less number of partitions will cause the data in each partition to bloat up and goes beyond the size a node can manage.
      - Rebalancing cause the some number of partitions to move from old nodes to new nodes.
    2. Dynamic partitioning
      - Key-range partitioning database like Hbase and RethinkDb allows dynamic partitioning which allows new partition to split up or old partitions to merge based on their data size.
      - Each partition can be assigned a configurable size, beyond which the partitions are split up.
      - Since each partition is configured with data size limit. Each partitions within the limit of a size.
    3. Fixed number of partition per node.
      - Introduced in Cassandra, it keeps the number of partition on the node stable.
      - Rebalacing: When new nodes are added some random partitions are split up in two halves, and one half from old nodes are moved to new node. while other half is kept in place. This will decrease the size of partitions.

- **Hotspot** 
  1. due to single key is not resolved either in key-range or hash partitioning. It requires extra bookeeping - to recognize the hotspot keys, provide data distribution strategy e.g. prepending random two decimal number in keys and partition the data and strategy to query hotspot data.
  2. Hotspot due to data skewness can be resolved using dynamic-range partitioning in key-range partitioning and by hashing in case of hash-range partitioning.  
- **Range queries:** 
  1. It is not supported in case of hash-range partitioning. 
  2. If range is limited to a single partition then the range query would be limited to single partition otherwise it is scattered to different partitions and results are gathered.
- **Secondary indexes**:
  1. Each part maintains their secondary indexes copy. Scatter-gather pattern is used to query all the partitions and results is gathered. But it suffers from tail-latency amplification.
  2. Term partitioning/ global indexes: Global indexes is partitioned to various nodes. It means the searching key will require answer from only one partition. Data is then gathered according to primary-keys. It makes read faster but write slower as seconday indexes are updated asynchronously. 
- ACID properties


## Data partitioning
 ### Key-range partitioning
  - Depending of data skewness, key range should be dynamic to give better partitioning. Uniform partitioning will not give good load balancing. 
  - Partitions data should be maintained in light weight CP key-value store like apache-zookeeper.
  - Supports range queries within partitions
  - Suffer from hotspot access pattern if some key-range is in demand.

 ### Hash-range partitioning
  -  keys are hashed so keys which are closer might get end up in different partitions, this helps in resolving of hotspot access pattern.
  - Range partitioning is not supported except Cassandra compound primary key approach.

 ### Hybrid partitioning
  - it make use of compound keys where one part is used for partition and other for sort ordering to support range queries.
  
## Request/data partitioning
### Shuffle partitioning
 - More useful in case of stateless load balancing.
 - Objective to parition failure isolation in case of multitanet services.
 - Each user requests are shuffled among the fixed hashed set of servers. Number of hashed set equals to combination of servers. No of combination surpasses the number of users. Each user have different set of partition servers, hence malicious user will impact only some partial capacity allocated to other users.

### Consistent Hashing
- DB nodes and keys are assigned to positions in a ring. keys will get stored in first node while traveling clockwise on the ring.
- randomly assign nodes on the ring may lead to data imbalance and load imbalance. This can be resolved by using concept of virtual function. Instead of using single hash function for a node we can use three hash functions. Each hash function places the nodeId into three random places which helps in distributing data more.  
- Virtual nodes have several benefits 
  1. Adding a physical node and recovery of physical node need data sync. Using virtual nodes allow this load to spread on other nodes equally.
  2. Deleting a physical node cause node's virtual node's data to redistributed to all other nodes equally.
  3. handle hetrogenity: More number of virtual nodes can be assigned to a big machine as compared to other nodes. 


## Table partition
 - **Vertical sharding**: 
 1. a table is divided such that few columns are in one table while others are in different table. 
 2. It is useful in cases where one table have very wide text or binary column. By breaking it one table with only id and wide text or binary column. we can make read and write faster.
 3. Also vertical sharding includes partitioning some tables in one physical server while some other set of tables in different server. One caveat is to make sure that tables with joins queries should be grouped together in one shard.
 - **Horizontal sharding**:
 1. Each db server will have all the tables of schema but the tables shard will only have data for some set of keys.
 2. Keys can be divided on the basis of range or hash. See key-range and hash-based partiting section.

----

# Consistency


 - **Split brain** - when two nodes simentaneously behave that they are the only leader. Quorum is used to resolve the split brain.
 - Strong consistency is for strict usecases where some form of ordering is required otherwise situations like split-brain may arise. But implementing stronger consistency is not very performance friendly and make system less resilient to faults.

## Ordering
  1. **Casual ordering**
    - It is a partial ordering of events, especially in case of events are related in "happen-before" or "happen-after" relationship.
    - Concurrent events are not related.
    - More performance friendly than total ordering.

  2. **Total Ordering** 
    - Every message is applied in same order to all replicas.
    - Not performance friendly.
  3. **Total order broadcast**
    - Messages are delieverd exactly once and in the same order.
    - it is equivalent to repeated round of consensus.

## Consistency Types
  1. **Eventual Consistency**
    - It's a weaker gaurantee as it does not gaurantee read your own write.
    - Different replica returns different results. There may be cases where it seems that data is going back in time.
    - It provides high availability as it is highly performant.
    - DNS is an example of eventual consistency as it is controlled by some propagation pattern and timed caches.

  2. **Casual consistency**
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
  
  4. **Quorum based consistency**
    - `r + w > n` and `w>r` is used to achieve high consistency.
  5. **Read your own write** consistency
    - it is a special form of casual consistency where if a node update some item then it should always see updated value.
    - It can be achieved by client sticking to same server node.   
  6. **Session consistency**
    - System will behave like read-your-own-write consistency during the session. In case of session invalidation user can see stale data.
    - It can be achieved by client sticking to same server node.   
  7. **Monotonic read consistency**: 
    - once a client has read some value it cannot go back in time and see some old value.
    - It can be achieved by client sticking to same server node.   
  8. **Monotonic write consistency**
    -  In this case the system guarantees to serialize the writes by the same process.
    - It can be achieved by client sticking to same server node.   


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

### Rough
- [external consistency](GIFFORD , D. K. Information Storage in a Decentralized Computer System. PhD thesis, Stanford, CA, USA,)
- [snapshot reads with bounded staleness.](???)
----

### Delievery Semantics
 - **Exactly-once semantics**
  1. Idempotent operation and retrying: 
   a. Using offset
   b. idempotent operation by nature
  2. Distributed transactions: see transactions in Dataflow model notes
 
 - **At-least once**
  1. Consumer is just failed before sending ack to the sender or network failure happened. In this case message will be retried and consumed multiple times.
  2. Implementation requires store of event or buffer of event permananently or temporarily till we get acknowledgement from consumer. 
  3. read about Apache storm "upstream backup and record ack".
  4. It may cause out-of-ordering in case of failures.
  
 - **At-most once** 
 1. Publisher of message does not attempt to redeliever in case ack is missing.
 2. It requires exensive end-to-end two phase commit.

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

## SQL vs nosql
-see sql.md and nosql.md

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

- **Vector clock**: 
1. It preserves casuality information history of data. This helps in conflict resolution in case of multi version history of an object is present. It can happen during network partition or concurrent write. 
2. Each object is associated with version `<nodeId, version>`. 
3. `Get` call returns the version alongwith value or return multiple values alongwith their versions. Client have to resolve conflict with an update in case of multiple values.
4. `put` call also take version as an input.
5. Syntatically reconcillation ??
6. Semantic reconcillation 
7. Maintenance of vector clock ?

## consensus
1. Paxos
 - see paxos.md
2. Apache zookeeper, consul and etcd implements consensus algorithm 

## Cluster management 
- distribute work using some hashing, memory and computation limit of nodes etc among the nodes by creating dags like flink's Job manager.

### Primary-Secondary Model
- Designated primary and secondary. primary is responsible for sending data to secondary nodes via synchronus or asynchronus replication 
- Data consistency is simpler
- Failover is simpler - secondary takes over
- Primary is chosen by cluster manager through lease based. Lease is fault tolerant mechanism where in case of primary failure lease will be given to other operation replica, once lease is expired. Therefore lease period should be appropriate. Lease will be granular to the resource. E.g. in GFS lease provide authorization for one of the chunkId stored in a replica.

### cluster of Independent Hosts
- Hosts are not aware of each other
- Data consistency is done via replication using consensus paxos and raft algorithm
- Failover is not applicable as any node capable of read/write
- More scalable than primary-secondary approach
- More complex than primary-secondary approach


# Questions
1. How to deal with hotspots
  - Caching layer
  - Replication of hotspot data and provide read through read replica
  - consistent hashing
2. How do we manage multi-tanet system.
  - Use shuffle sharding
  - set quotas. Tenents can go beyond the quota if free resources available according to some predefined policy.
  - Request throttling if tenets are going beyond their quotas.
  - fair queuing


## Rough notes
- read about Try-confirm/cancel algo for distributed transaction
- what are the authorative server