## Requirement
- detects brusty trends.
- give top K hashtags in a region.
- global top K hashtags


## Components
 - Post API flow: service --key,incr--> Redis
 - Get API flow: 1. service <---- cassandra 
                 2. Offline flow: cassandra <---- Schedular job <--- redis   

 - local hashtags shared counter
 - global hashtag counters
