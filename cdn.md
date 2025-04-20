# CDN
## Requirement
- retrieve/pull data from origin server
- Deliever data to end user
- search content
- data management like deletion data after expiry

## Question deep dive
- how to intelligently distribute traffic
- metrics collection
- Discover nearby proxy in CDN
- Dynamic content optimization
- Data consistency

## Dynamic content optimization
- Edge server generate non-compute heavy scripts locally rather than origin server
- Uses compression to reduce data size
- **Edge Side Include** markup it allows to specify only the dynamic part of web pages. Rest of webpage can be cached.
 

## Content retreival
- push CDN 
  1. origin server proactively pushes data to CDN without user request.
  2. If data is not getting requested then it suffers from unnecessary updates.
  3. more suitable for static content.
- pull CDN content
  1. Proxy server responsible of pulling the data from origin server in case of data absense.
  2. More suitable for dynamic content ???
### Data consistency
- poll origin server and get new data after time-to-refresh is expired.
- TTL: Similar to time-to-refresh approach but in Time-to-live after expiry edge server ask if data's new version is updated. If it is not updated origin server refreshes only the updated ttl.
- Lease: Content is leased by origin to proxy server. **Adaptive lease** is used to optimize the lease duration after considering proxy load. During lease duration origin server notifies proactively to edge server if there are any changes in data. After lease expiration lease renewal request is raised by origin server.


## Traffic distribution 
- CDN supports tree like hierarchy where some set of nodes recieves traffic from a parent node which in turn receive data from origin server. Each different type of data follows a different path in tree structure. It helps in scaling.
- **Multi-layer caching** : Long tail data can be stored away from the user whereas the popular or latest can be stored near to user. 

## Find nearest CDN
- Nearest location of user with maximum bandwidth defines the nearest proxy to user.
- If request load of proxy is nearest location is high then due to bandwidth constraint the request is routed to second nearest edge server.
- DNS redirect response is used to intelligently send user to nearest edge server.
##
- Request routing system
- distribution system
- 