# Redis
- Value can be of complex data structure and provide APIs to do in place modification on them.
- also provide persistent in secondary storage as memory dump.
- preferred for complex, read and write heavy 

## Features
- cluster management
- automatic replication
- automatic sharding
- automatic failover
- different level of persistence
- performant due to asynchronus replication: less consistency
- Supported data types: bitmap, hyperlogs, hashmaps, sorted sets and string,
## Architecture
- separate control plane from data plane.
- multithread proxies queries multi shards and assemble data.
- shards have primary and secondary replicas
- Data plane consist of cluster manager which is responsible for monitoring and configuration
-  **Redis piplining** : instead of client blocking after each request to server. Client can batch multi request in a single request.