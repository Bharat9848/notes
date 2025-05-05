
# Microservices
## book
- microservice pattern

## Push
- push based system are active processing models

## Pull
- pull is slower and cause processing delays in active systems.

## Communication protocol
- Never trust the failure status message especially timeout in synchronus communication as there are possibilities of success owing to receiver is slow, ack packet is lost etc.
- see delivery semantics in distributed system notes

### RPC
- client stub, server stub, 
- RPC runtime retransmit, acknowledgement and encryption.

### Http

## Type
1. Aggregator service: calls many services downstream. It can benefit from cache to return result for duplicate requests.

## Service discovery
- Client based load balancing: Faster than the proxy LB. It have a disadvantage of client is exposed to some stale data.

## Metrics
- monitor process if its down e.g. no of pods
- Monitor resources for their health and anamolies - CPU usage, memory usage, disk and network usage
- monitor hardware component??, power consumption ??
- Monitor communication to essential service ???
- Monitor responsiveness to essential services - plot p99 of response time, other server error codes
- Intergrate and monitor cloud service using Cloud service providers provide a health status of their services:

    AWS: https://health.aws.amazon.com/health/status
    Azure: https://status.azure.com/en-us/status
    Google: https://status.cloud.google.com/


