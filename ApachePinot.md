# Apache pinot
- scalable OLAP 
## Usecases
- streaming
- analytics
## Requirement
- low query

## Features
 - query performance p95 in 10ms

## Node types
- server
- broker
- minion
- Controller: use Apache-Helix for scheduling and cluster management. Apache Helix further uses Apache-Zookeeper for fault tolerant, strongly consistent and durable state. Apache-Helix client run on broker and server node as agent.
