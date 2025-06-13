## Proximity Service
## Concepts
- Quad tree
- static segments - fixed size area of `5*5` miles. We can assign segment before storing a location in the database.
- dynamic segment: helps in dividing the area more dynamically. It helps in preventing hotspot creation in densely populated areas. Google s2 library can help in its creation.    
- Google maps: helps in connecting all the segments
- Google s2 library:
  - divide earth into circular cells
  - lat-long belongs to cells
  - cells have different level based on zoom level.
  - Every cm2 is represented by 64 bit integer.
  - uber uses level 12 cells

## requirements
1. search user
- search by category
- search by name
- provide rating to place
2. Business user
- adding/removing/updating businesses
3. Redistribution of segments -- applicable only in case of dynamic segments to handle scalability
 
## non functional requirement
- latency: read should be very fast.
- availablity
- scalability
- consistency: business data changes very slowly. We can live with eventual consistency of data 

## Estimation
- Facts and assumption
  - Assumes 500 million places
  - 60 million active users daily
  - 600 million total users
  - Earth land area: 60 million square miles
- Server required
  - total active user/ server qps capacity

- Upload bandwidth
  1. 5 places added everyday
  2. assume 1 million reviews are posted everyday
  3. 5 user added everyday
- Download bandwidth
  1. 60 million QPS
  2. 20 unit of search result
  3. 10 % click on place page
  4. 6 million place page
- Storage bandwidth
  1. Index data
    - static segment based approach  
      - assume 10 mile single search radius or segment size
      - 6 million segment
      - 500 places per segment
    - Quad tree based approach  
  2. Location data
    - 500 million places
    - 2096 bytes per place
    - 100 KB per photo
  3. user data  
    - total user 100 million
    - 500 byte per user information
  4. rating data
    - 500 byte rating data
    - 10 review per place  

## storage schema
- place(Id, name, description, latitude, longitude, photoURl)
- rating(Id, userId, placeId, rating_star, comment)
- user(userId, userName)

## high level design
1. Search
   - user --> Load balancer ---> search service ---> collect service ----> Quad-server 
   - asynchronus index building flow
     - cron job ----> Quad server --> DB


2. Indexing of places
   - user -> LB --> places service --> segment provider ---> google maps(integration) ---> places db   

## APIs
- search(category, user, lat, long, radius)
- search(place_name, user, lat, long, radius)
- addPlace(name, lat, long, description, category, photoUrl)
- review(userId, placeId, rating, comment)


## Deep dives
- Add new search locations in quad tree

- scaling the search
  1. This can be done by partitioning the data using keys as `regionId` or `placeId`. We build quad tree indexes over the partitioned data.
  2. we can provide a ranking/rating to the places and returns the top K places from it. Collector service will collect all the top places from the nearby segments and return the top quality places.

- Search: 
  1. Using static segments: Each location is assigned to a segment, this helps in narrowing of search. Service finds the segment to search and its nearby segments. Searching segments are deciding by search radius and user current segments. 
  2. Using CRUD application : search a table with radius defined using lat range and long range.
  3. Using dynamic segments: We can leverage quad tree. If a location is densely populated then we can divide into dynamic segments, where each new segment will be represented by the children of a node. Places Ids will be stored in a leaf node. We will attach all the child nodes in a doubly linked list.  
    - Quad tree specification
       `ParentNode(long, lat, child1, child2, child3, child4)` 
       `childNode(long, lat, placesList, leftSibling, rightSibling)`

## Evaluation

## Distinctive feature/components.

## Rough
1. Segments producer: This component is responsible for communicating with the third-party world map data services (for example, Google Maps). It takes up that data and divides the world into smaller regions called segments. The segment producer helps us narrow down the number of places to be searched.
2. he concept revolves around optimizing data retrieval in a distributed system by leveraging key-value stores, a type of NoSQL database designed for high-performance, scalable, and simple data storage solutions. Key-value stores map a unique key to a specific value, allowing for efficient data access patterns.

    Efficient Fetching of Places: In the context of Yelp’s system design, each geographical segment (a defined area on the map) is assigned a unique segment ID. The places within these segments (restaurants, landmarks, etc.) are stored in a key-value store where the segment ID acts as the key, and the list of places within that segment is the value. This structure allows for rapid retrieval of all places within a specific segment without the need to scan through all available places.

    Storing QuadTree Data: QuadTrees are a data structure that helps in partitioning space to enable efficient spatial searches. By storing QuadTree data in a key-value store, where each QuadTree has a unique ID as its key and the QuadTree’s structure as its value, the system can quickly access and navigate through the QuadTree to find places within a given radius of a user’s location. This is particularly useful for the search functionality in Yelp, where users search for places within a certain distance from their current location.

In summary, using key-value stores for both segment-based place storage and QuadTree data enhances the system’s performance by minimizing search times and ensuring quick access to relevant spatial and place information. This approach is crucial for a responsive user experience in location-based services like Yelp.


