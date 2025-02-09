Load Balancer

Best practice
 - HAProxy
    (backend)* -> (DNS/VRRP) -> 2 (HAProxy) -> (backend)*


Routing algorithm
1. Equal cost Multi Path (ECMP)
2. Random:
3. Random best of two: two random choice but we further choose best between the two.
4. Round-robin
5. Weighted round-robin
