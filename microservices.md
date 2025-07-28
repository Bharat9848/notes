
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
### Websocket
- fully duplex.
- long lasting connection.
- no overhead of request/response headers.
### RPC
- client stub, server stub, 
- RPC runtime retransmit, acknowledgement and encryption.
- open source  Tchannel, finagle
- Goals - performance, forwarding, checksum/tracing, pipelineing(bidirectional), encapsulation(different protocols)
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

## Rough
### Quotes
"## Disadvantage
- Backward compatibility issues, feature flags, config changes etc
- distributed debugging - observability, monitoring and alerts
- A distributed tracing tool to help more complex debugging
- A shared understanding of good API design. Optionally auto-generated documentation of all known APIs with usage examples.
- An internal repository to store and share things like shared libraries
- Service discovery infrastructure
- Dealing with network inevitabilities: re-tries, exponential backoffs
- Shared libraries for graceful degradation and resiliency: load-shedding, circuit-breaking, rate-limiting
- Testing infrastructure: unit testing, load testing, chaos testing, integration tests, automation tests"


