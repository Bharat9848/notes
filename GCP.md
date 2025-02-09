# Loadbalancer
## categories
 - Layer 4 or Layer 7
 - behavioural - passthrough or proxy
 - location - global, regional, cross-regional, classic
 - traffic type - internal or external
 - traffic medium - premium or standard


## Layer 7 load balancer
- based on envoy or google front ends backend based in external flavor
- Andromeda based backend in case of internal load balancer

## Layer 4 load balancer
- backend can be envoy or maglev.

### Classic load balancer
- in premium tier it guides traffic to multi region backend and in standard tier it only sends traffic to single region.

### passthrough load balancer
- do not provide advanced network capability
- preserves client IP.
- handle variety of protocols like icmp, ecs etc

### proxy load balancer
- takes traffic from multi-cloud, on premise cluster
- have advanced network capabilities.

