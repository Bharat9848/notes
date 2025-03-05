# Load Balancer
- DNS geolocation
- Anycast IP
- Best practice
 - HAProxy
    (backend)* -> (DNS/VRRP) -> 2 (HAProxy) -> (backend)*
- add firewall rules to a VPC to expose external IP of a K8 service to outside and then using a forwarding rule it sends the traffic to a node running cluster.

## DNS Load balancing
- used for L0 load balancing
- round robin based load balancing.
- susceptible to uneven load in case client system start caching the IPs.
- Size of DNS packet limitation(512 Bytes) cannot have list of all possible Ips.
- DNS geolocation

## Requirement
- scalability: Backend can scale so LB should support upscaling/downscaling.
- Performance
- Availability: LB should be able to handle backend server failure gracefully.

## Load balancer failure
- LBs are deployed as part of disaster failure recovery. LB clusters are deployed with heart beat communication.

## type
- Global serving load balancing: Automatic failover to other zones based on user geographic location, server availability etc.

- Region Load balancing


## Forwarding rules
- Applicable to L4 load balancer


## Application load balancer
- deploy a proxy 
- traffic weighing
- header based matching


# Routing algorithm
- Static algorithm
- Dynamic algorithm.
## Some well know algorithms
1. Equal cost Multi Path (ECMP) - tier 1 LB
2. Random:
3. Random best of two: two random choice but we further choose best between the two.
4. Round-robin
5. Weighted round-robin: higher infra servers were given higher weights
6. Least connection: new requests are sent to server with least connection. Even if servers of same configuration uneven load balancing can happen.
7. Least response time.
8. IP hash: user hash
9. Url hash: LB based urls params

## proxy based
 - for cookie manipulation each time proxy will reject/ignore `Keep-Alive` connections.

## Rough

- What is stunnel

- standby LB : VRRP (Virtual Router Redundancy Protocol) mode in servers refers to a network protocol configuration that provides automatic assignment of available IP routers to participating hosts. It's primarily used to increase the availability and reliability of routing paths on a network.Here's what VRRP mode does:
1. **High Availability**: VRRP enables automatic failover by allowing multiple physical routers to act as a single virtual router.
2. **Master/Backup Architecture**: In a VRRP setup, one router acts as the master while others serve as backups. If the master fails, a backup router automatically takes over.
3. **Virtual IP Address**: The routers share a virtual IP address (VIP) that clients use as their default gateway. This VIP moves between physical devices as needed during failover.
4. **Priority-Based Election**: Each router has a configurable priority value that determines which becomes master. Higher priority routers are preferred.
5. **Heartbeat Messages**: Routers in a VRRP group exchange regular messages called advertisements to indicate their status.

Common use cases for VRRP:
- Load balancers running in high-availability pairs
- Network gateway redundancy
- Edge router failover configurations
- Clustered server deployments where IP availability is critical

VRRP is similar to other protocols like HSRP (Hot Standby Router Protocol) and GLBP (Gateway Load Balancing Protocol), but VRRP is the standardized, vendor-neutral implementation (defined in RFC 5798).

In server clusters, VRRP is often implemented in addition to other redundancy mechanisms to ensure seamless service availability during hardware failures.