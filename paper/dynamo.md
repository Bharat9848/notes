# Dynamo

## Requirement 
- Reliability is paramount from key-value store irrespective of node failures. In case of failures and network partition the store should always allow write. SLA is defined with 99.9% calls to return in tens of millisec of latency at a peek load of `x` request/sec. 
- Allow system to tune according to usecase which might require tradeoff in consistency, availability, performance and cost-effectiveness.
- Efficiency to scale over commodity nodes


## APIs
- Simple `Get` and `Put` usecases. 
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
- Data is replicated to next K virtual nodes in clockwise direction given those virtual nodes are not spawned on same physical nodes.  
- On node failure or network partition, write will fall to next node on the ring. It might lead to data inconsistency. We will need object versioning to help in this scenario. 

## Scalability
- Node addition is incremental. As it would allow system to be performant with less amount of data sync and load on operator of the system.
- Partitioning is based on consistent Hashing.
- read is handled by different server
## Hetrogeneity: 
- datastore system should be able to take advantage of node hardwares according to their capacity. It do so by assigning more virtual nodes to high-end hardware nodes.

## Fault tolerence
1. Temporary failure: is handled by hinted handoff and sloppy quorum. `preference list` for a key have more than `n` nodes. In sloppy quorum any of the `n` nodes from preference list can answer for read/write operation. This helps in temporary failures.  
2. Permanent failure recovery using Mekle tree it help in recovering divergent replicas



## Data conflict resolution
- **alway-write** availibility causes inconsistent data in replicas. Which further requires a conflict detection and resolution policy. Conflict detection and resolution is done during read instead of write for always-write requirement. Conflict resolution is done by client instead of datastore to increase the number of choices for conflict resolution.   
- Vector clock

## Consistency
- quorum for maintaining consistency
  - Strong consistency W + R > N and W > R. 
- System can be configured with in-sync replica `N`. Coordinator node decided by key hash from the ring. Coordinator maintains the list of more than N vertical nodes. Coordinator node replicate data to other nodes.
- List of replica nodes in called `preference list`. Virtual nodes are skipped in preference list in case they are assigned to same physical nodes.
- Eventual consistency: writes are asynchronusly replicated. Read your own write is not supported.


## Rough
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

