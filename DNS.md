# DNS
- Name server: replay to DNS queries
- ttl: it instructs DNS client to cache DNS reply till ttl expiration.
- caching can be done at os level, local server, browser etc.
- servers are replicated across different part of the world.
- UDP protocol is typically used for DNS queries. But it can happen over TCP in case packet size is greater than 512 bytes. HTTPS is used in case of sercure requests.
- The root server’s IP addresses are within the special software. Typically, the Berkeley Internet Name Domain (BIND) software is used on DNS resolvers. The InterNIC maintains the updated list of 13 root servers.

## type of DNS record
- canonical/cname record: provide a different hostname alias for the original host name.
- Answer record: contains IP against a domain name. 
- NS record: provides the hostname that is authorative DNS for a host name.
- MX record: provides mail server alias CNAME against a host name.

## tools
 1. dig
 - `dig <hostname>`
 - `dig -x <IP>`
 - `+short`  	
 2.	nslookup

## DNS server infra
1. DNS resolver server
- lie within user network
- initiate resolving sequence forward requests to other server
- also called **local/default**
2. Root level nameserver
- responsible for root part of domain like `com`,`in` etc.
- returns the list of top-level domain servers
3. Top level domain name server
- returns list of IPs of authoritative server.
4. Authoritative server
- returns the IP address of web/application server


## Problems
 - DNS load balancing - DNS scalability(due to response size) and DNS drain 