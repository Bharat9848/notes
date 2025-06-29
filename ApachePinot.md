# Apache pinot
- scalable OLAP 
## Usecases
- streaming
- analytics
## Requirement
- Latency
  - query performance p95 in 10ms
- Fault tolerance:
  - serve the query traffic even without active controller. But it will not do any metadata related changes like add a table or ingesting a new segment.


## Glossary
1. Participants:  
  - Nodes which actively participate in pinot functional requirements
  - server node and minion are the participants type nodes
2. Spectators
  - Observe the changes on the cluster and inform controller
  - Broker are the spectator nodes.
3. Controller
  - schedule or rescheule a resource in case of node failures
  - orchestrate connection between certain external processes and cluster components.
4. Partition/Segment:
  - a subset of data stored in atleast one node or replicated on multiple nodes.
  - **consuming segment**: In memory segment counterpart for ingesting real-time data. It participate in query processing to make data available as fast as possible. It is flushed priodically depending on the row count, size or received data.
  - **Completed segment**: Flushed consuming segment resulted in completed segment.
5. Resource:
  - A table with all partitions
6. Tables  
  - real time tables
  - offline tables   
7. Queries
  - Multi stage queries
8. Deep store

## Node types
### server: 
 - Stores table segments
 - offline server: for storing data for long term. They have moderate cpu and memory but big hard disk.
 - real-time server: for querying real-time usecases. They are CPU and memory optimized.
### Broker:
  - maintains the state which server holds which data segment in form of a `routing` table. As a table segment is replicated each entry can have multiple server data. 
  - **query planning**
    - Broker does query planning of multi-stage queries. It routing of queries can be vary based on `routing` strategy. It supports replica-aware routing, partition-based routing and minimal server selection strategy. By default it choose to do load balance among replicas.
  - **Qurey processing**
    - assemble data from multiple sources
  - hosts http endpoint over JSON for query API.

### Minion: 
  - As opposed to server it performs computation rather than storage.
  - do format conversion e.g from `avro`,`json` to segment file
  - purge records
### Controller: 
  - use Apache-Helix for scheduling and cluster management. Apache Helix further uses Apache-Zookeeper for fault tolerant, strongly consistent and durable state. 
  - Apache-Helix client run on broker and server node as agent.

## Apache Helix
- holds the current state of the cluster
  - the number of broker and server
  - the config and schema of tables
  - connections to streaming ingest resources.
  - current executing batch ingestion jobs.
  - the assignment of table segments to the servers in the cluster. 
- Constantly calculating the current state as it is dynamically changes. 
- React to the current state if it diverts from desired state, as a result it pushes configuration to server and broker.

## Apache Zookeeper
- get to know first about any observable data and notify spectators about cluster changes.
- Stores the following
 1. controller: current leader
 2. server and broker: 
   - all list of servers and brokers
   - configuration of server and brokers.
   - health status of brokers and servers.
 3. Tables
   - list of tables
   - table configuration
     - routing strategy
     - table assignment strategy
   - table schema
   - list of table segments
 4. partition
  - exact server location of segment
  - state of each segment
  - metadata about each segment

## Rough
- "Apache Helix for sophistcated scheduling and resource management"