## Glossary
- Path MTU is the largest packet size that a source can send on the network beyond which packet fragmentation will happen. This number is equal to the smallest MTU on the network path.
# IP address
 - global anycast address

# Protocols

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

## Rough
- `arp -n` shows pods mac address.
- `brctl show cfbr0` shows root namespaces in veth pair attached to `cfbr0`
- DR/DSR is typically used for non-HTTPS traffic because when TLS termination is involved, responses need to be encrypted before reaching the client, requiring them to pass back through the Layer 7 load balancer for encryption.
- **Internet exchange points** are common grounds of IP networking, allowing participant Internet service providers to exchange data destined for their respective networks. 