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


## Rough
Glossary
1. Event
2. Stream
3. Task scheduler
4. Executing engine
5. Slot
6. Slice
7. Watermarks
8. State
9. State backend
10. Keyed state
11. Operator state

Logical Dataflow graph
- nodes are called operator
- edge are data dependency

Physical dataflow graph
- nodes are called task which are translation of operator from logical Dataflow graph. There can be multiple parallel task running on different machines.

Data parallelism is done by partitioning of data.
Task parallelism is running of multiple task simentaneously.

Data exchange strategies describe how data is distributed from one task to next task in pipeline. It is based of semantic of operator or user enforcement. These are forward, broadcast, key-based and random.

Latency are lowest when system load is small and high when load is at its peak. Throughput and latency both will be benefitted by less processing. Stateful operator are difficult to parallelize and less fault tolerant.
Data source and data sink operator. Aggregator operator should be commutative and associative.
Window operator have multiple usecases - 1. limit the state of aggregation data which require maintaining the whole data like median 2. Allow queries on data which require a recent data like fraud detection etc. window operator is defined using how data is assigned to different window and how data is drained from a window in repeated manner.

Streaming is affected by delays and out of order issues.

Processing time 
- accuracy is less important than speed 
- periodic queries e.g. real time monitoring dashboard

State is durable across events in stream processing as compared to batch processing.
Stateful operator do three task sequentially - receive new event, update it's internal state and emit an output, failure can happen at any of these steps

Event time processing is true equivalent of batch processing. Processing time calculation gives different results if events are replayed again.

Event replaying

1. At least once can be used with persistent event log or the source and in case failure occur events are replayed from the source or log

2. At least once can also be used record acknowledgement an event is kept in buffer till its acknowledgement is received from every task.

Exactly once uses event replaying as suggested above also saves state and event in a transactional manner

Architecture
1. Job manager
Dataflow graph to materialize to execution graph aka tasks 
Ask for task manager slots through resource manager
Central entity for coordination between various stages for checkpoints 
Keeps execution meta. It is single point of failure.
Flink can run job manager in High availability mode using  zookeeper 

2. Resource Manager manages Task manager process. Resource manager interacts with various different resource providers like k8 and mesos.
3. Task manager offers slots to the job manager. Communicate with other task manager.
4. Dispacher expose http api to the application developer to submit application and provide dashboard

Broadcasted state vs broadcast stream
Managed state .? 
Result guarantees
- consistency of the internal state of the processor (consistency of application state) is not same as consistency of result as it would require sink system to support transaction.

Operator type
1. Union
2. CoflatMap

Operator - have internal timer service to compute at a specific time. Tasks like window operator register timers for each window completion.

How to handle late event

Describe credit based flow control helps in removing of skewness in traffic.
Describe benefits of task chaining.
Code notes
- StreamExecutionEnvironment exposes parallelism, fault tolerance, and time semantics. It can be local or remote. Remote if submission client with remote server is used.
- Transformation can be categorised as following 
1. Basic transformation: consumes only a single event and produces(map) another event or not produces (filter) based on some condition. Or flatmap which produces zero or single or multiple event after consuming an event. Flatmap is generalization of map and filter.
2. KeyedStream transformation: logically partitioned datastream based on some key. It internally maintain a state which are used by stateful transformations. State can be accessed using key.
3. Multistream transformation: either connects two stream or split a stream. Union opertor join stream of same type. Connect operator join two different type stream. Check the join logic ???. Check connectedstream keyby and broadcast. split operator tag each element to zero, one or multiple output tags. These tags then can be queried using select function.
4. Distribution transformation creates new datastream (not KeyedStream) mainly around how to distribute data across parallel downstream task. It have suffle(), rebalance(), rescale(), broadcast(), global(), and custom methods..


Flink infer type using a type extractor though it is possible to explicit pass type information using return in Java and implementing ResultTypeQuerable in scala api

Rich flavour function provides two additional method namely open and close alongwith general transformation method. Through rich function we can use getRuntimeContext to obtain function parallelism, name, index of current subtask and partition information.

Process function can only access the record timestamp and operators time stamp and register timers 

Flink applies the timestamp as metadata to  record.

Timer based operator have time service to which these operator register timers. On receiving watermark, task update their internal event time clock and triggers any trigger which have time smaller than received event time through timer service. Task emits watermark with updates timestamp.

If any input stream stop producing new watermarks then it will impact the latency and memory.

Failures
- on task manager failure job manager ask resource manager to provide new task manager slot.
- jobmanagr uses zookeeper for leader election and uses it high availabile and durable datastore. All the data required to recover jobmanager is stored in persistent store and pointers to it are saved in zookeeper. Zookeeper stores job graph, jar and state handles of the last checkpoints 

State
- example are the record accumulated in window operator, reading position of input source and custom application states like machine learning model
- issues are state consistency, failure handling and efficient storage and access
- state needs to be registered
- operator state - a single task state not shared by task of same type or different type. It can be of list , union list and broadcast state. List type is scaled by redistribution after collecting all then distribute evenly. Union list and broadcast state are broadcasted.
- keyed state - per task per key. Are scaled using key groups???

Checkpointing
State of all the task is stored in a persistent store when every task have consumed same subset of records. State can be offset for source task and some aggregation state from downstream tasks.

For checkpointing recovery to work, source should be resettable to previous offset and support transaction at sink end.

Watermark should be generated closest to source function or inside SourceFunction??? It can be of two types periodic or punctuated. Periodic watermark generate watermarks periodically by repeatedly calling get watermark method

Process function is a low level transformation function which can be used for custom logic.

Window operator have assigner, trigger and evictor.
Trigger is called
- when a window is considered ready for evaluation
- when window is purged and contnets are cleared
Trigger when is generally defined on timers or based on assigned elements.

Evictor is an optional element only needed in cases where no increment operator is defined. it receive all the elements one by one it can remove elements.

## rough
- do code example from flink book on page 92,94
- how watermarks are generated
- what's periodic and punctuated watermarks
- SourceFunction can be used to mark an source idle it will be excluded from the watermark computation.
- SourceFunction can be used to emit records with timestamp and watermark.
- user defined function can override watermark and timestamps.
- getRuntimeContext.getState
- process function context object give access to timerService(), side output, 
- what is full window function 

Flink advance usecase
- emit early results and update result of late element are encountered.
- window start or end when specific records are received.

Join
- interval join
- window join
- custom logic using  CoprocessFunction, Broadcast process function and keyed broadcast process function

Apache iceberg
Apache hive
