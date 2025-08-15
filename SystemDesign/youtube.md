# Concepts
- bitrate
- Encoding

# Requirements
- upload video
- stream video
- search video
- like/dislike video
- Add comments video
- view thumbnail of video

# Non functional requirement
- high availability
- Scalability
- Good performance
- Reliability

## Estimation
Usage assumption
- upload no = 500Hr of video per minute
- 1.5Million users - 500K Active user every day
- avg video duration: 5min
- uncompressed video size 5min: 600MB
- compressed video size 5min: 30MB.
- upload/view ratio = 1/300

1. Storage estimation: 


2. Bandwidth estimation
- Upload Bandwidth
  - upload stats: 500 video-Hour/min = 30000 video-min/min (basic fact)
  - size of a 5min video: 600MB/5min = 120 MB/min = 2MB/sec 
  - bandwidth requirement = upload video minutes * video size/min = 3600000 MB/min 
- Download Bandwidh
  - download stats: (download/upload) view ratio * upload stats =  150000 video-hour/min = 900000 video-min/min
  - avg bandwidth req: 10 MB/min 
  - badwidth required/min = 9000000 MB/min = 1500000 MB/sec = 12000000 Mb/sec = 12Tb/sec

3. Server required
  - QPS = 5000000/sec
  - server processing RPS = 64000 request/sec  
  - servers = QPS/server processing sec ~ 8k.


## Flows
1. Update flow
- client device -> load balancer -> web server -> upload server(DB for temp storage) and metadata service(DB) -> Encoder -> Blob storage and thumbnail Bigtable-> CDN(optional) and colocation server

- components
1. upload server: 
  - temporarily store the videos 
  - validation like check for malicious user and duplicate video. 
  - Breaks the video and audio in segments.  
2. encoder: 
  - encode the video in different resolution and store it
3. blob storage: 
  - resting place for all the uploaded videos
4. CDN: 
  - act as recent frequent/hit cache

2. Streaming flow
- client <-> CDN

3. Search flow
- client -> API gateway -> web server -> search service, thumbnail service and metadata service -> elastic DB, thumbnail service and metadata db

4. Comment flow 
- comment service -> API gateway -> web server -> comment service

5. like/dislike flow 
- like/dislike service -> API gateway -> web server -> like/dislike service

## LLD
### APIs
- Post API upload videos 
  uploadVideo(user_id, video_file, title, discription, tags, language, privacy_settings, category_id, playlist_id)

- get API stream video
  getMetadataVideo(user_id, video_url): MetadataVideo   

#### Playback APIs
- get Manifest
  getManifest(user_id, video_id)

- stream video
  getVideoSegment(user_id, video_id, video_segment_id, screen_resolution, user_bitrate, device)
  getAudioSegment(user_id, video_id, audio_segment_id, screen_resolution, user_bitrate, device)
- Event APIs: event can be sync playback to other device, pause/play etc   
  saveEvents(user_id, video_id, event) 

  getSubtitles(user_id, video_id, subtitle_id)

- like/dislike video
  like(user_id, video_id, like_boolean)

- post api for comment api
  postComment(user_id, video_id, comment_str): comment_id

- get search Api
  search(user_id, search_string, page_id) 	 

### Schema
User(id, name, joining_date, password, DOB)
Video(id, user_id, like, dislike, upload_date, video_url, views_count, admin_disabled, privacy_level, language)
video_details(id, video_id, resolution, format, compatible_devices)
Channel(id, name, created_on, modified_on)
channel_videos(channel_id, video_id)
Comment(user_id, video_id, text, flagged, posted_on, like, dislike)

## Deep dive
1. Thumbnail service : BigTable for storing thumbnail.
2. Search
  - video data is extracted from (channel_name, playlist_name, video_title, video_description, content_transcript, video_length, tags)
  - ranking algorithm based on view_count, watched_minute, like, dislike, user_id
3. Stream service
  - interacts with Ad service, user data service, encoding service.
  - Server sends a manifest file to user. Manifest file contains the information about the different video segment based on different bitrate that user device can fetch based on user device's network and other condition.
  - **mainfest files**: Static (one-time) manifest files are pre-generated and delivered to clients as soon as the streaming session begins. This means that the same manifest file is shared with all the users requesting the stream. In contrast, dynamic manifest files are generated on-the-fly as soon as the request is placed on the server. Each generated manifest file takes into consideration the client’s location, device specifications, network conditions, preferences, etc., to generate a tailored response. Although dynamic manifest files produce a better user experience and are suitable for dynamic ad insertion, their generation is resource-intensive and complex as compared to the static approach.
  - Video is decoded and decompressed on client device. 
  - Ad service
    - updates a manifest file to decide which ad is apt to show against a video
    - decides the frequency cap for an ad to be shown to user.
  
4. Scalability
 - Adaptive bit rate
 - caching at various level using Http1.1 etag and caching feature
 - prefetching
 - compression
 - Storing famous content at ISP/IXP so that origin servers face less burden and less network congestion. 

5. Intelligent encoding
 - Storing entire video in different encoding formats os less storage friendly then store and encode video in smaller chunks where each chunk can be stored in different encoding technique.
 - Video is divided into segments. Segments can be choosen intelligently and divide an entire video in segments with minimum dynmics frames, medium dynamic frames and high dynamic frames. Then for each type of seqment, different encoding might be choosen for optimal quality and minimum storage.

6. Recommendation service
- ML algorithm to pick and choose videos that should be placed at edge(CDN/ISP) to save cost and better user experience.


## Streaming
- flow
 user device -> streaming server -> cdn 
 cdn <-> viewer device

- protocols 
1. **RTMP** is widely used for ingesting live streaming with the help of different encoders. So, it would be useful for sending the raw video to the server.

2. **HLS** would be the best option for sending the video from the streaming server to the CDN. It provides the audience with ultra-high-quality streaming, and the stream is also secured. Furthermore, it is supported by all major browsers, as well as Android and iOS.


- Streaming server

## Rough
In the context of the lesson, using lossless but fast compression like Google Snappy on the client end before uploading videos to YouTube is suggested to decrease the amount of data that needs to be transmitted over the internet. 
- Live stream
- Building custom data stores like Vitess and BigTable to meet scalability needs???

## References
