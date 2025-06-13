## Requirement
- Post tweet
- See tweets from people user follows
- Delete tweet
- like/share tweet
- reply tweet
- follow and unfollow users
- retweet
- search tweets
- top N hashtags

## Non functional requirement
- Availability
- Latency
- Scalability: 
 1. System should be highly scalable as user want to see their timeline within 200ms.
 2. System should be highly scalable as more user joining in.
- Reliability
- Consistency: it can be relaxed. Eventual consistency will work fine.
- Durability: Tweets should never get deleted


## Estimation
1. Base facts
 - 500 million total user
 - 50 million active users
 - 1:1000 is write to read ratio
 - Text tweet size: 500 bytes
 - Tweet with picture: 200KB
 - Tweet with video: 3MB
 - Write: each user post 3 tweets a day
 - 10% of daily tweets have picture.
 - 5% of daily tweets contain video
2. storage requiement
  - per day tweet count: 50 * 10^6 * 3 = 150 million 
  - only text tweet storage per day = (150 * 10^6) * 200 =  30 * 10^9 bytes
  - pic tweets per day = (150 * 10^6) * 0.1 * 200 KB  = 3 * 10^12 bytes
  - video tweets per day = (150 * 10^6) * 0.05 * 3 MB  = 22.50 * 10^12 bytes

3. upload bandwidth
4. download bandwidth

## API and schemas
1. postTweet(userId, msg, videoUrl, picUrl, isDraft, access_type, content_type, user_location): TweetId
2. like(userId, tweetId, tweet_user_id, user_location)
3. retweet(userId, tweetId, tweet_user_id, user_location)
4. replyToTweet(userId, tweetId, tweet_user_id, content, content_type)
5. search(searchTerm, exclued, noOfResult)
6. timeline(userId, tweet_count, max_result, exclude, next_page user_location)
7. Follow/unfollow(followeeId, followerId)

### Dbs
 - BigTable and BigQuery for ad-events, click events etc
 - Manhatten (key-value store) for tweets, direct msg, account etc,
 - Blobstore to store all the tweets pictures, videos and checkpointing data
 - Mysql or postgres for ad exchange and ad campaign data.
 - Vertica for aggregated dataset and Tableau dashboard
 - flockdb (graph database)for storing relationship between users.


## Flow diagram
```mermaid
A[user] ---> B[Load balancer]
B[Load Balancer] ---> C[Tweet service]
C[Tweet service] ---> D[Mysql, Vertica, postgres, Manhatten]
B ---> E[Timeline service]
E --topK tweets--> D
E ---> CDN[cached timeline]
B ---> F[Search service]
F ---> D 
```


## Component

## deep dives
- Celebrity problem
- high read throughput
- top-K hashtag trends: Requires system to show trends locally and globally. 
- Timeline: Users home timeline is a list of user's followers tweet. This can be cronologically sorted or based on some custom highly engaging tweets strategy.

## Tweeter blog
- Manhatten: custom made key-value store
  1. uses rocksdb as storage engine
- Presto: distribute sql query engine
- Fingale: protocol agnostic RPC library.
  - aperture: 
    - Term defines the number of session a client opens up with a subset service's servers.
    - Uses client hashring and server hashring to map client to servers.

## Rough
- "Twitter also uses Vertica to query commonly aggregated datasets and Tableau dashboards."
- "The initial design of Twitter included a monolithic (Ruby on Rails) application with a MySQL database. As Twitter scaled, the number of services increased and the MySQL database was sharded. A"
