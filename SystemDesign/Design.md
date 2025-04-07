# General
 - In some cases interviewer tries to hide some major requirement.
 - Simplify requirements and system interfaces
 - Consistent Hashing vs Normal hashing

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


# S3 store
## Services
  - API service
  - Namespace/placement service
  - store fleet with hard disk
  - maintainence fleet for background operations like replication and tiering.
## Store
 - part of object stored in LSM tree.   
## Unique 
  - erasure encoding to achieve 99.999999% availablity
 
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
