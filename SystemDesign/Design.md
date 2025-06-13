# General
 - In some cases interviewer tries to hide some major requirement.
 - Simplify requirements and system interfaces
 - Consistent Hashing vs Normal hashing ??

## Metrics
 - Break down of latency in performance critical operation.
 - Traffic pattern from different channel
 - System load

## Scale calculation
 - QPS handled by MySQL: 1000
 - QPS handled by key-value store: 10000
 - QPS handled by cache server: 100,000–1 M
 - L1 cache reference: 0.9ns 
 - L2 cache reference: 2.8ns 
 - L3 cache reference: 12.9ns
 - Main memory reference: 100ns 
 - Compress 1KB with Snzip: 3,000ns (3 microseconds)
 - Read 1 MB sequentially from memory: 9,000ns (9 microseconds)
 - Read 1 MB sequentially from SSD: 200,000ns (200 microseconds)
 - Round trip within same datacenter: 500,000ns (500 microseconds)
 - Read 1 MB sequentially from SSD with speed ~1GB/sec SSD: 1,000,000 (1 milliseconds)
 - Disk seek 4,000,000ns (4 milliseconds)
 - Read 1 MB sequentially from disk: 2,000,000ns (2 milliseconds) 
 - Send packet SF->NYC: 71,000,000 (71 milliseconds)
 - If cpu bound workload have performance X then memory based workload will have 10X slower and IO based workload will be 100X slower.
 - Per request time `CPU(time per program)=Instructions per program × CPU Cycles Per Instruction × CPU time per clock cycle` e.g. lets say we are running million instruction per request. cycle per instruction is 1. cpu time per clock is 1/3.5Ghz will give 0.001 sec. Or 1000 request per sec.   
 - No of user(assume in millions) can be used as proxy for request per sec.
 - capacity of single commodity server - assume 500 request/sec
 - cache or inmemory server operation 64000 request/sec
 - Assume 10x of normal QPS as peak QPS.
 
## Design interview template
````
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
````



# Sequencer
## Requirement
- provide globally time sortable unique Ids


# Social media app

# Streaming server - youtube/netflix
 - View video
   - video is served through CDN 
   - Streaming protocol is chosen based on player-server coupling. Known protocols are MPEG-DASH, Apple-HLS etc.
 - Upload video
   - Upload video Transaction can be completed using two parallel tasks. Uploading original video which will further triggers the `transcoding` server to encode video in h264/mpeg etc formats and parallely we can start `metadata` API call which will post file metadata to server. After encoding is complete metadata should be updated with new encoded video and formats. Encoded video should be further transferred to CDN. Transaction should be marked complete.
 - Video transcoding -- deep dive
   - why needed
    1. raw format is of very big size.
    2. certain phones and web browser support only some formats.
    3. network bandwidth shifts and user's internet connection demands different video qualities.  
   - Two component
    1. container - video, audio and metadata
    2. Codec like H.264 which compresses while preserving quality.
   - Transcoding subtask includes audio/video encoding, thumbnail generation, watermarks which can be parallalized. video encoding is for different resolution, bitrates and codecs.
 - However, if we were building an API for a streaming service, then supporting different devices could be considered a separate functional requirement because different devices support the playback of different encodings, and we may have to transcode the data to the appropriate one for each device.
 - DASH protocol: Manifest file is shared with client have multiple urls on different bit rate. Client adapts the video sttream quality based on network bandwidth of client device.
  
# Ticket master problem

# Car ride app

# Chat application
 - User online/offline
  - user client will send heartbeat to presence server.
  - after 3 heartbeat timeout user is considered offline
  - user presence is sent to all friends using `channel`(websockets) msg group.

# Group chat application

# Dropbox
 - sync client that uploads files data to server
 - send notification to other devices
 - download files
 - high write ratio
 - ACID requirement
 ## scale
  - segregate upload/download functionality
  - segregate upload to two steps 1. store file directly to AWS S3 through block server 2. And then use upload metadata-server API to commit the file with its metadata.
  - Alternatively client -> file server(store in temp storage, persists metadata) -> processing server(encode/decode data) -> blob storage
  
# Notification server
- polling mechanism - lot of idle connection
- long polling
- 1M connection

# bike rental

# Dating app
 - Technology used
   - elastic search
   - websocket
   - google s3 service
   - dynamo db - for key value store usecases like user profile, matched


 - User matching suggestion based on geo location 
   - see common section for find nearby entity.
 - user changing location:

 - how users are matched based on their likeness.
   - right swiped matches are put on a stream
   - worker checks and save the `like` cache if other user has also liked
   - if yes then both users were notified using websockets and saved in `matched` DB. 
   - left swipe stream can be sinked to low-cost datastore like s3 for data analysis.

 - Services: 1. User Profile Service 2. User Recommendation Service 3. swipe services 



 
# Common problem
 1. find nearby entity

 2. Recommendation service

 3. multipart file upload

 4. high write-read ratio

 5. File store
  - Components - 1. File/block server 2. metadata db 3. Aws s3 object metastore

 6. Database scaling
  - single write paths
  - caching data

 5. Timeline 
  - Usecase post a video
    - save the post from a user in a data store.
    - send the post to a pipeline which inserts the post to follower/friend's timeline.   

 7. Ultra low latency
   1. e.g. Stock exchange, mission control system
   2. Move different components in a single server
   3. Use unix `mmap` for sharing data between different system. 

 6. Trending service  

 8. Transactional system
  1. use uuid to deduplicate or make calls idempotent.

## Monitoring system
### Components
 - Data collector system: it pulls the data from various services that we want to monitor.
 - Timeseries database: It is the resting place of all the meterics. It is backed up by an blob storage which natively stores the DB data files. Blob storage is very cost effective than a server node with persistent volume. 
 - querying system: It provides an API through which we can query a meterics database.
 - Alert Manager: It repeteadly query the metrics on a set of frequency set on the detail definition using query service.
 - Alert and action db: It stores the alert and action notification details
 - service discoverer

### deep dive
- cleaning up old data
- remove single point of failures
- scale Local monitoring system to global monitoring system: Use push based approach from local to global. local monitoring system or global monitoring system uses blob store as backup.

## Distributed Queue
- Strict ordering
  - Approaches
    1. client side monotonically increasing sequence no
    2. client side casuality ordering
    3. timestamp based on synchronized clock
  - How to handle late event: situations where consumer have already received msg after current timestamp message. We can put late message in other queue and client should handle it based on it own semantics.
  - sorting before enqueue using timed window approach.
- concurrent multiple writer
  1. use single writer thread can only write to queue and writers put their msg in single writer thread queue.
- High Level Diagram
  LB ->FrontEndService -> (MetadataCache <-> MetadataService) -> Queue
- Frontend service
  1. Authentication and authorization
  2. Data validation
  3. Deduplication
  4. auditing
  5. user level caching
  6. metadata caching
- Metadataservice
  1. stores the mapping of queue to storage node/clusters
  2. stores queue metadata
- Cluster Management
  1. Primary-secondary model
  2. External cluster management
  - see distibuted system cluster management.
- Dead letter queue 
  1. special queue used if delievery of message failed repeatedly.
  2. For non existent queues/ or length limit reached
- Message deletion
 - deletion after delievery via explicit/implicit consumer call. parallel consumers do not see the message.  
 - no deletion. msg are garbage collected. Consumer have to maintain its position.  

## Pub/sub
- see kafka.md
- Strict ordering of msgs
  - topic will have partitions. Write can be done with given partition id to maintain strict ordering.
- Components
  - produer -> broker (topic)-> topic metadata db,  consumerManager -> topic metadata db -> consumer, consumer -subscribe---> consumer Manager.
- Brokers
  - topic will have partition. Each partition will be assigned to different broker
- Cluster Manager
  - Manages broker 
  - topic and partition assignment to different brokers
  - data replication
- consumer Manager
  - consumer authorization
  - message retention mechanism
  - consumer offset management
  - consumer msg delivery according to consumer push/pull strategy          

## Distributed cache
- **Locality of principle** can be temporal and spatial. Temporal locality of principle says data access pattern is temporal means same data is accessed repeatedly for short duration of time. Spatial locality of principle says frequently access data maintains the locality relationship e.g. pagination, array or list loops etc. 
- server type
  1. dedicated cache server
  2. embedded cache server
- write policies: 
  1. write-through cache
  2. write-back cache
  3. write around cache
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

## Distributed Logging
- Requirements
  - new services should be able to integrate
  - logs should be searchable
  - logs should be stored in central location for easy access
  - centralized visualizer: system should have unified view
  - low latency and highly available
  - highly secure for some kind of application like banking etc and multi-tenent situations
## Flow
  - applicaton ---pushes-log-file---> logs accumulator ---publish---> pub/sub system -->(filterer, error accumulator, alert aggregator) ---filterer--> blob storage
  - blob storage <--- indexer ---> inverted index <--- Queryservice <--- visualizer  

## Components
- Logs Accumulator: 
  - It will gathers logs from various nodes and dump it in a distributed blob storage 
- Logs Indexer
  - It will repeatedly indexes the new logs from dump location and build index
- Visualizer
  - It will provide the search query  
- Query service
  - do query on inverted index generated by query service  
- Filterer 
  - it will redistibute the logs based on (application-id, service-id) and save it blob store location specific for application-service type. 
- Error aggregator:
  - It filter out non error messages and send it repective stakeholders
- alert aggregator
  - It monitors and raise alert in case of any fatal error logs.

    
## API
- `write(uniqueId, msg, metaKeyValuePairs)` uniqueId can be combination of application-id, service-id, and timestamp 
- `search(keywords)` search keywords 

## Deep dives
  - How to keep size under control for large scale applications
    - use sampling to log only few samples
    - categorizes logs e.g. use more stricter logs like error or trace etc.


## Distributed Counter
### Requirement
- create counter
- read counter
- write counter
### concepts
- Use shared counter distributed to no of shards.
### Deep dives
1. how to process millions of likes/view in a short amount of time.
   - sends write to any shards
   - put a load balancer which can forward the calls to appropriate shard based on its load.
2. Read a counter
   - add all the counter from all the shards put it in a cache periodically in some cases where stale data is allowed. Otherwise we have to wait for all shards and then sum up the counters.
 
### APIs
- `createCounter(counter_seq_id, shards)`
- `writeCounter(counter_id, increment/decrement)`
- `readCounter(counter_id)`    





## Rate Limiter
- Functional requirements: should be configurable, return appropriate error message, should rate limit, rejected request can be replayed if usecase allows. 
- Non functional Requirements: Availibility, low latency and scalable with client
- Concept: Throttling type- 
  - Hard: hard stop after the configured limit.
  - Soft: allow configurable x% more requests.
  - Elastic/dynamic: no limit defined. Request are throttled according to system availability.
- placement:
  - at client: can be affected by malicious behaviour
  - At server
  - At middleware: more generic rate limiter, might affect performance
- 1st hld
  - set of nodes -> update counter -> central database
  - Not very scalable as contention    
- 2nd hld
  - nodes with independent distributed db having its own count.
  - not latency friendly: it needs to collate current api hit count from all other nodes
  - can be improved upon with sticky session but that will not be scalable and fault tolerant
- Components
  1. Rule cache <--periodic update--- Rule database
  2. Client Id generator
  3. Desicion maker
  4. Rejection queue
  5. Distributed database (clientID - count)
- Deep dive
  1. Contention:
    - locking can be used for modest and hard limiting usecases. It is not scalable
    - Atomic locks can be used. It is more performant and scalable than locking.
    - For high throughput cases, limit can be divided among the nodes as quotas. Every node will update and maintain their quota. More node can further divide the quotas.
  2. Optimization:
    - count increment can be done in offline path/asynchronusly.
  3. Rate limiting algorithm
     1. Token bucket 
     2. Leaky bucket
     3. fixed window counter algorithm
     4. sliding window log algorithm: 
        - smoothen out burst bcas of sliding window
     5. sliding window counter
        - further smoothen out sliding-window-log algorithm by calculating remaining capacity through rate.       
  
## Rough
    Rate Limitter
    URL Shortener
    Web Crawler
    Notification System
    News Feed System (Instgaram, Facebook, Twitter)
    Chat System (1:1 and group)
    Search Autocomplete system
    Youtube
    Google Drive
    Uber
    Tinder
    Spotify
    Bookmyshow
    Goibibo/Skyscanner
    Flipkart/E-commerce
    Leetcode
    Logging System
    Zoom
    Google Pay/UPI
    Nearby Friends
    Google Maps
    Ad Click Event aggregation
    Airbnb
    Real time Gaming Leaderboard
    Stock Exchange

The concept revolves around managing message visibility in a queue to ensure that once a message is consumed, it is not immediately available to other consumers, thus preventing duplicate processing. This is achieved through a visibility_timeout attribute, which sets a period during which the message is invisible to all consumers except the one that initially retrieved it. During this invisible period, the consuming application has the opportunity to process the message. If processing is successful, the consumer explicitly deletes the message from the queue using an API call. If the consumer fails to delete the message before the visibility_timeout expires, the message becomes visible again in the queue and can be consumed by another worker. This mechanism is crucial for distributed systems to ensure reliable message processing, especially in scenarios where tasks may fail or take longer than expected. It supports the at-least-once delivery guarantee, ensuring that messages are not lost even in the face of consumer failures.






