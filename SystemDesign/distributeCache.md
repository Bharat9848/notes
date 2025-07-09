# Distribute Cache
## Concept
- **Locality principle** can be temporal and spatial.
- **Temporal locality** applies where data access pattern is temporal means same data is accessed repeatedly for short duration of time. 
- **Spatial locality** applies frequently access data maintains the locality relationship e.g. pagination, array or list loops etc.

## Requirement

## Non functional requirement

## Estimation
1. Base facts
2. storage requiement
3. upload bandwidth
4. download bandwidth
5. server estimation

## API and schemas

## Flow diagram

## Component

## Deep dive
1. How to deploy with pros and cons
   a. dedicated cache layers: cache can scale independently. It will be costly and not latency friendly. 
   b. embedded cache server: It is cost friendly. Sharding of cache data is not possible. Share resources with actual server. 
2. what are the write policies with their pro and cons. 
  1. write-through cache: Data is first written to cache and then asynchronously replicated to datastore. Most widely used strategy. Highly performant and no cache synchronization issue.
  2. write-back cache
  3. write around cache

## Rough
- Eviction policies
  1. Least recently used
  2. Least frequently used
  3. Most recently used
  4. most frequently used
- Cache Invalidation policy/ 
  1. Active expriration
  2. passive expiration: This strategy do cache eviction in a separate thread. It is favourable in high volume and high concurrent cache. As in Active expiration evicting same key candidate in different threads will present a race condition and requires some locking mechanism. 
  Cache coherence: invalidated data should get reflected in all the data copies across replicas.
- Data partitioning
  1. consistent hashing
- Data storage
  1. hashing of data
  2. Data structure: 
     1. doubly Linked list         
     2. Bloom filter
  3. Persistent might be optional in case cache data is an expensive query or data from various sources.   
- Cache client API
  1. `GET`
  2. `PUT`     
- service discovery: Configuration service to get the server location
### deep dive
- hot key:  
  1. Further Sharding of Hotkeys: This involves dividing the data associated with a hotkey into smaller, more manageable pieces across different cache servers or shards. By distributing the load, no single server becomes overwhelmed with requests for that key.
  2. Intelligent Cache Client Behavior: Cache clients can be designed to recognize potential hotkeys and adjust their access patterns or request distribution to minimize contention. This might involve spreading requests more evenly across the cluster or using algorithms to predict and mitigate hotspots before they occur.
  3. Dynamic Replication for Specific Keys: This strategy involves creating additional copies of data associated with hotkeys and distributing these copies across the cluster. By having multiple access points for hot data, the load is balanced, reducing the pressure on any single node.

- data replication: synchronus replication in all the replica in same data center.
- cache warming: Validation check to do before allowing client read.

## Understanding
- client only knows the subset of caching machines
- each caching nodes only knows subset of machine.

## Resources
- Harvest cache paper - Anawat Chankhunthod, Peter Danzig, Chuck Neerdaels, Michael Schwartz and Kurt Worrell. A Hierarchical Internet Object Cache. In USENIX Proceedings, 1996.
- Greg Plaxton and Rajmohan Rajaraman. Fast Fault-Tolerant Concurrent Access to Shared Objects. In Proceedings of 37th IEEE Symposium on Foundations of Computer Science, 1996.