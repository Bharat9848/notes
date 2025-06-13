## Requirement
- Newsfeed should be collated from different sources like liked-pages, friends, followed users etc
- updated newsfeed time to time
- content of newsfeed contain images, video, text etc.
- content should be ranked

## Non functional requirement
- scalable
- Available
- Latency-sensitive
- reliability

## Estimation
1. Base facts
- 1 billion users
- 500 million active users
- 1 user have 300 friends average
- 1 user follow 250 pages
- 1 user open app 10 times a day
- QPS: (500 million * 10)queries/day = 58k	
2. storage requiement
  - user profile metadata
  - top 200 feed text cache
  - image/video post size for 200 posts per user
    - assume 4/5 contain images
    - video is 1/5

3. upload bandwidth

4. download bandwidth

5. no of servers
  - total active user/ server capacity = (500 * 10^6)/64000

## API and schemas
1. SQL DB: Post table, user table, media table, entity table(to store liked pages etc)
2. Graph DB: store relationships 

## Flow diagram
1. full hld
 ```mermaid
 A[client] ---> B[Load Balancer]
 B ----> C[Newsfeed publishing svc]
 C ----> D[feed cache]
 B ----> E[Post service]
 E ----> F[Newsfeed generation svc]
 F ----> D
 C ----> G[Blob storage]
 E ----> H[Post cache]
 H ----> I[Post DB]
 ```
 2. new post


## Component
1. Newsfeed generation service
- feeds will be generated based on demand for non-frequent user.
- feeds will be pregenerated for platforms frequent user.
2. Newsfeed publishing service
3. Newsfeed ranking service
- work in tendem with newsfeed generation service
4. post service
5. notification service
- sends push notifications.
6. newsfeed cache
- stores data format `userId->List<(postId, userId)>`
7. blob storage
8. post cache
9. post db

## Deep dive
- Feed generation: feed is generated offline for each user. Each time a user visits his home page he is served from allready generated feed cache.

## Rough
Design strategies to combat misinformation in a newsfeed

I will add a another service called content-guard service. It will receives postId through a queue to analyze based on viral post engagement, user flagged misinformation etc.  Following are the tasks this new service will fulfill

    checks if it is a already flagged post.

    checks for an misinfomation where it is taken out of context

    Any disturbing graphics etc.

After analyzing content-guard service may remove the posts from post cache or develop a case and assign to a human operator which will take appropriate action.

Certainly! Two design-level interventions to help mitigate misinformation on newsfeeds are:

    Flag or downrank content with suspicious origins or lacking verification. This helps reduce the visibility of potentially false information.
    Collaborate with fact-checking organizations to validate information before it spreads widely, ensuring that credible sources are promoted.

These strategies can significantly help in curbing misinformation. Keep exploring!
