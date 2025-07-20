## Status 
Not done very difficult maths

## Goals
- eliminate hotspots in a caching system
- No remapping of caching when nodes are added and removed.

## Correctness Problems
 - each client is aware of different set of caching nodes.
 - No of caching nodes changes.

## Before system
- Manager needs to have full cluster view to effectively distribute.
- Use "proxy-cache" caches the hot pages. But cache can themselves swamped by the traffic.
- Use distribute cache with IP multicast among peers if data is not found. It is operational challenge to scale because of no of messages among the peers.
- Tree based distribute cache where communication is limited among siblings. Root of the tree receive all page request and hence a scaling problem.
- virtual larger caching sites where each page is assigned to a random virtual node in each hierarchy. 

## principle
### static model
   1. Assumption1: all machines know about each other ?. 
   2. Assumption2: Machine to machine latency is contant. 
   3. Assumption3: and all request made at same time. 
   4. Results: no machine is swamped, total optimal delay of Log(C).
   5. Protocol:
      1. Each page is represented by balanced d-ary tree.
      2. Number of node is equal to `C`.
      3. Root of the tree always mapped to server of the page. While other nodes are mapped to caches through a hash function: `h:P * [1...C] -> C`
      4. Above hash function is distributed to all the browser and caches. 
      5. Request(id(requestor), name(page), List(nodes of the request path), List(mapped cache m/c of request path)).
      6. request comes to a random node.	

## Math reference
 - `C` is the number of caches


## Rough
- "Consistent hash function changes minimally as the range of function changes??"
- "centralized servers on the Internet such as Domain Name servers, Multicast servers, and Content Label servers are also susceptible to hot spots."