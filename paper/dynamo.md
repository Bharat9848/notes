# Dynamo
- `N` is per-instance config. It denotes how many nodes data should be replicated to.
- `preference list`: List of more than N physical nodes where a key can be found or should be stored. 
- `coordinator`: node which coordinates `get` or `put` data to appropriate nodes. Mostly it is the first node of hash ring where the key should be stored. But if client is load balanced then it can be any node of the system which further sends the data or query to preference list nodes of key.     
- Eventual data store where availability and reliability is paramount.

## Client
- Client can be topology aware it will find the nodes responsible for storing keys and calls the server directly.
- Client can be dumb and sit behind an loadbalancer and request goes to random node. Most of the time random node is not the node where the data resides. Node will find the nodes responsible for storing data. Node can forward the requests to top N node in prefrence list. This strategy is beneficial in case of read intensive and help in reducing hotkey problem.

## Requirement 
- Reliability is paramount from key-value store irrespective of node failures. In case of failures and network partition the store should always allow write. SLA is defined with 99.9% calls to return in tens of millisec of latency at a peek load of `x` request/sec. 
- Allow system to tune according to usecase which might require tradeoff in consistency, availability, performance and cost-effectiveness.
- Efficiency to scale over commodity nodes


## APIs
- Simple `Get` and `Put` usecases. 
- Put and get operation also passes version operation of an object between server and client.
- In `put` operation coordinator server writes the object locally with newer version and send it along with object to N-1 replicas.
- Queries are not provided to scan over a range or multiple objects.

## Design
- not ACID compliant. No isolation. weak consistency
- System chooses peer to peer approach instead of centralized master approach. As centralized approach might have downtime till a replica becomes primary in case of primary node failure.
- no security requirement as all nodes are in trusted environment.
- No hop routing to favor stringent latency and throughput requirement.

## Key
- use MD5 to generate 128-bit identifiers

## Failure detection

## membership protocol
- using gossip protocol.

## Load balancing
- use consistent hashing for load balancing.
- virtual nodes for higher load balancing. 

## Availability
- To meet the requirement of always write, peer-peer data replication is used. 
- Data is replicated to next N virtual nodes in clockwise direction given those virtual nodes are not spawned on same physical nodes.  
- On node failure or network partition, write will fall to next node on the ring. It might lead to data inconsistency. We will need object versioning to help in this scenario. 
- allow disconnected operation and provide eventually data consistency.
- Each node maintains metadata information to send queries to appropriate server directly.

## Scalability
- Node addition is incremental. As it would allow system to be performant with less amount of data sync and load on operator of the system. consistent hashing allows incremental scaling.
- Partitioning is based on consistent Hashing.
- read is handled by different server

## Hetrogeneity: 
- datastore system should be able to take advantage of node hardwares according to their capacity. It do so by assigning more virtual nodes to high-end hardware nodes.

## Fault tolerence
1. Temporary failure: is handled by hinted handoff and sloppy quorum. `preference list` for a key have more than `n` nodes. In sloppy quorum any of the `n` nodes from preference list can answer for read/write operation. This helps in temporary failures.  
 - In hinted handoff if a node is tempoaraily down then another node will take the write on the behalf of the node. It is written in different dataset and another node will send the data back to original node whenever it recovered. Data is stored with metadata hint indicating the original node the write was intended for.
 - In sloppy quorum read is send to N nodes which are not first N nodes in preference list.

2. Permanent failure is handled using Anti-entropy process during recovery Mekle tree is used. It helps in recovering divergent replicas. Each node maintains a Merkle trees. It has a disadvantage of recalculation in case of new node addition or deletion

## Membership
- Each node maintains a membership history
- Gossip protocol is used where a node sends a heartbeat to another node after a sec.
- partner node reconciles their membership data.
- Each node maintains its allocated virtual nodes in a token set. Also It obtains  other node's token set using gossip exchanges with peers alongwith membership data.
- **External discovery**: Each new node will be given seed node information to startwith as otherwise it will see only itself as only node in the ring.
- Failure detection is done by locally by a node when other node is able to respond to a message in time. Then first node sends the message to next node responsible for the partition in steady state traffic. Without steady state traffic nodes are not aware about their peer failures. 

## Data conflict resolution
- **alway-write** availibility causes inconsistent data in replicas. Which further requires a conflict detection and resolution policy. Conflict detection and resolution is done during read instead of write. Conflict resolution is done by client instead of datastore to increase the number of choices for conflict resolution.   
- Vector clock

## Consistency
- no data integrity.
- Read your own write is not supported. But for any write which is followed by a read the fastest replica which replied for read is sent back to client for subsequent write. It has two benefits - write on your read and it takes some load from the top node of preference list.

- quorum for maintaining consistency
  - Strong consistency W + R > N and W > R. 
- System can be configured with in-sync replica `N`. Coordinator node decided by key hash from the ring. Coordinator maintains the list of more than N vertical nodes. Coordinator node replicate data to other nodes.
- List of replica nodes in called `preference list`. Virtual nodes are skipped in preference list in case they are assigned to same physical nodes.
- Eventual consistency: writes are asynchronusly replicated.
- **Read repair**: After sending data back to the client, coordinator updates on the replica which returned the stale data.

## Other optimization
- Write/read latency were decreased by a factor of 5(from 200ms to 40ms) when write is switched from disk write to main-memory buffer writes. Coordintion protocol is changed from 1 out of W to do risk write other nodes will do buffer write.

## Background task
- It includes merkle tree syncing and hinted handoff etc. 
- Foreground task like `get` and `put` are prioritized over background task
- Admission controller system monitors the latency of foreground operation using various factors and determine the slice of resource that will be available to background tasks.

## Consistent Hashing
- see consistent hashing in Distributed system notes.
## Vector clock
- see vector clock in distributed system notes

## Rough
- How object versioning works in case of quorum read/write.
- how sloppy quorum works if R or W nodes are partitioned.

- Several techniques, such as the load balanced selection of write coordinators, are purely targeted at controlling performance at the 99.9th percentile.

 Previously, Reddit’s media metadata was distributed across different storage systems. To make this easier to manage, the engineering team wanted to create a unified system for managing all this data.  ?
 Requirement - read 100k  50 ms  

12  version clock
15 19 replication
1 6 distributed file system
 7 22 - strong consistency Rdbms
 21 conflict resolution
 14 16 20 - intelligent querying
 9 17 routing overlays
 21 distributed rdbms
 15 distriputed block file
 23 - why key based approach
 2 - multiple queries - BigData
10 20 different consistent hashing to handle heterogenity

