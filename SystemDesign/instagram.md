## Requirement
- post photos/video
- like,comment and share photos
- view feed
- follow/unfollow users
- search photos

## Non functional requirement
- Scalability
- Latency
- Availability
- Durability
- Consistency: Eventual

## Estimation
1. Base facts
- 1 billion user
- 500 million total active users
- 60 million photo shared every day
- 35 million video shared every day
- 3MB photo size
- 150MB video size
- 20 times for the day per user.
- read to write ratio - 100:1
2. storage requiement
3. upload bandwidth
4. download bandwidth
5. server estimation

## API and schemas


## Flow diagram

## Component

## Deep dive

## Resources
- [highscalability](https://highscalability.com/designing-instagram/) - Done
- [cassandra at instagram](https://www.youtube.com/watch?v=_BfMH4GQWnk)
- [personalized newsfeed](https://www.youtube.com/watch?v=Xpx5RYNTQvg)
- [scale data infra](https://www.youtube.com/watch?v=1sPgogJlKWM)
- [scale insta infra](https://www.youtube.com/watch?v=hnpzNAPiC0E)
- [tech stack overview](https://instagram-engineering.com/what-powers-instagram-hundreds-of-instances-dozens-of-technologies-adf2e22da2ad)
- https://instagram-engineering.com/types-for-python-http-apis-an-instagram-story-d3c3a207fdb7
- https://highscalability.com/the-instagram-architecture-facebook-bought-for-a-cool-billio/
- https://instagram-engineering.com/under-the-hood-instagram-in-2015-8e8aff5ab7c2

## Rough
### Alternate design
- Dbs
1. Cassandra 
   - for usecases - user activities, user feed and counters.
2. graph database Neo4j
   - entities users, posts and comments
   - stores complex relationship b/w entities like comment, like, share etc
- microservices
  1. user feed service
  2. comment service
  3. user post service
  4. likes service
  5. user follow service
  6. media hosting service
  7. user activity service
- flows
  1. new post
  - user --postReq--> post service ---media--> Media Hosting service ----> File storage --url--> Media hosting service ----> post service --update post url-->  graph db ----> post service --push--> user activity queue ---> post service --ack--> user
  - user activity queue ---pop--> user activity service --update--> user activity cassandra ----> user activity service  --fetch follower--> follower service -----> user activity service --update feed--> user feed service 

  2. precompute feeds
  - user-feed-service queue --pop new post--> user feed service ---->follower service --query--> graph db ---> follower service --followers list ----> user feed service --add post--> user feed cassandra

  3. fetch feed
  - user ----> user feed service --> user_feed cassandra ----> user feed service 
                                 --celebrity users--> user follow service ----> user feed service --posts by celebrity users--> user activity service ---> user feed service
   ---> merge two streams ----> user

