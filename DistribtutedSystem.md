## Glossary
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

  2. **Linearizability**/**Strong consistency**
    - it is consistency from CAP theorem.
    - It is a stronger gaurantee than eventual consistency. It make all replica and leader behave as a single entity.
    - Once a replica returned a value that means other replica cannot return values which are older than that value. 
    - all the changes happened to a register are atomic.
    - Defintion does not entail multiple row/key-value/register. Linearlizability only covers a single row/key-value/register. 
    - read your own update.
    - usecases include leader election, distributed locks and unique constraint like unique username etc.
  - **Drawbacks**:
    1. Performance hinderess - not scalable beyond a point. Scalability would requires the usecase to be handle by multi nodes. 
    2. Make system unavailable in cases of network partitions and other faults.
  - There may be a case that even after linearizability you get to see values which are not latest. But as they are returned by any replica, it is okay.  
 
 3. Casual consistency
   - It is lighter version of consistency.
   - It serve casual ordering usecases and hence more performant than linearlizability.

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