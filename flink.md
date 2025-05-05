# Flink
- dataflow graph
- Execution graph
## start flink locally
1. go to flink exploded installation's `bin` folder
2. run to start `./start-cluster.sh` run to stop `stop-cluster.sh`
- Note does not work on j21

## Architecture
### Job Manager
### Resource Manager
### Task Manager
## Features
## Fault tolerance
- consistent point in time snapshot for all the stages of pipeline. It is done progressively means not all pipeline is stopped. snapshot marker flows from upstream towards downstream, once all the stages done taking the snapshot, complete snapshot is presisted and made available for any worker failure.
- TCP connection being used to passed message among workers. Any connection failure starts from last good sequence number.
## Watermarks
- see watermarks in streaming.md
- each source can be configured with out-of-orderness by max of `<x>` ms. Source inactiveness can cause the window to never emit the results. timeout idle source, keep-alive event or fix the source are some of the solutions.
- watermark are special record - hold a timestamp as a long value.
- **Late records**: events arrived after watermark has passed a given event time are called late events.
## Resources
## Rough
- Chandy Lamport distributed snapshots

## Flink filesystem
- what is flink filesystem connector


## Excercise
- read generic zip file with metadata which gives the format information 