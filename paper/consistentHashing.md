## Goals
- eliminate hotspots in a caching system
- No remapping of caching when nodes are added and removed.

## Before system
- Manager needs to have full cluster view to effectively distribute.
- Use "proxy-cache" caches the hot pages. But cache can themselves swamped by the traffic.
- Use distribute cache with IP multicast among peers if data is not found. It is operational challenge to scale because of no of messages among the peers.
- Tree based distribute cache where communication is limited among siblings. Root of the tree receive all page request and hence a scaling problem.
- virtual larger caching sites where each page is assigned to a random virtual node in each hierarchy. 

## principle

## Rough
- "Consistent hash function changes minimally as the range of function changes??"
- "centralized servers on the Internet such as Domain Name servers, Multicast servers, and Content Label servers are also susceptible to hot spots."