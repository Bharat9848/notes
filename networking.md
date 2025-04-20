## Glossary
- **Routing**: route traffic from one network to other network.
- **Gateway**: default route if no other route criteria matches. It is usually send the traffic to other node on different network node. or if it is set to no route then kernel process the traffic.
- Latency have several subcomponent - transmission delay (due to less bandwidth), processing delay, queuing delay (due to network congestion) and propagation delay (due to physical distance).

- POP - point of presence where two different network meets. e.g ISP traffic is merging with general internet traffic. POP usually have CDN servers
- IXP - Internet exchange points. Companies tend to deploy on-premise smaller datacenter near the IXP. This helps in holding more data nearer to client. In case of youtube, client connection ends at IXP servers but if data is not there then it is forwarded to origin server on a TCP connection with low-latency, persistent, huge tcp window.   

- Path MTU is the largest packet size that a source can send on the network beyond which packet fragmentation will happen. This number is equal to the smallest MTU on the network path.


# IP address
 - global anycast address: Single address used globally for a set of servers. It uses BGP is a network-level protocol used by Internet edge routers to share routing and reachability information so that every node on the network, even if independent, is aware of the status of their closest network neighbors.

# Protocols
## BGP
## DNS 
- see DNS.md
## Layer 7
### HTTP
1. Http1.1
- suffers from head of line blocking. 
- `Keep-Alive`
- `Accept-Range:bytes`: server can accept partial request in terms of bytes.
- `Content-Range:200-700/2000`: client request bytes from 200 till 700 out of 2000 bytes.
- `E-tag`: specific version of response object.
- `Cache-control: private`: instructs the primary to not to modify cookies.
2. Http2.0
- binary protocol, compression and do multiplexing to provide good performance.
- Backward compatible to support Http1.1 in case client does not support Http2.0.
3. Http3.0

### QUIC



## Layer 4

### TCP
- multicast
- Congestion control mechanism: TCP congestion protocols are Tahoe and Reno.
- TCP_NODELAY : Tcp will not buffer.
- keep_alive
### UDP
### ICMP  
### IP tables

## Resources
Real-time Messaging Protocol (RTMP), HTTP Live Streaming (HLS), Real-time Streaming Protocol (RTSP), 
## Rough
- `arp -n` shows pods mac address.
- `brctl show cfbr0` shows root namespaces in veth pair attached to `cfbr0`
- DR/DSR is typically used for non-HTTPS traffic because when TLS termination is involved, responses need to be encrypted before reaching the client, requiring them to pass back through the Layer 7 load balancer for encryption.
- **Internet exchange points** are common grounds of IP networking, allowing participant Internet service providers to exchange data destined for their respective networks. 
- The concept of routing and default gateways is fundamental in networking, ensuring that data packets find their way across complex networks of devices and subnets.

