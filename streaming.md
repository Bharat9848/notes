## Streaming 
 1. map and reduce stages are blurry they are called operator. 
 2. Operator maintain managed fault tolerant state.
 3. fault tolerance require mini batching and checkpoint mechanisms.
 4. **Processing time** - when event was received by the collector, **Event time**: Time when event was actually generated, **Event-sent time**: time when event was sent from the client to collector.
 5. correctness and reasoning about time required for streaming to outperform batch.
 - Think in terms of time-lapse diagram

## Glossary
- Watermarks: signals the completeness of arriving of event with respect to some specific event time.
- Accumulation: overlapping or non-overlapping deltas of accumulation from same windows.

## Details to be captured before pipeline 
- **What** results are calculated.
- **where** in event time results are being calculated. Answer can be time-agnostic/event time/ processing time/time-agnostic approximattion as well.
- **when** in processing time results are materialized - usually at time when majority of events are believed to be already gathered. materialization for a single window can be done at multiple times.
- **how** do the refinement of results are accumulated.

### Usecases
 - time agnostics: 
   - stream joining and filtering usecases without any notion of time.

 - approximation: 
   - approximate top K list and streaming K means.
   - usually based on processing time.
   - "This is particularly important for algorithms that provide some sort of provable error bounds on their approximations. If those error bounds are predicated on data arriving in order, they meanessentially nothing when you feed the algorithm unordered data with varying event-time skew. Something to keep in mind. ??" 

 - windowing by processing time: 
   - does not mimic reality of event time. In case of major delay and lags processing event using processing time give spiky metrics but in reality it was smooth.
   - simple to implement and reason about
   - best suited for usecases where event time is not reliable like user phone device evnets

 
 - windowing by event time
   - requires longer holding of data buffers with time shuffle
   - completeness is approximate 
   - best suited when events are replayed as processing time will not be very meaningful in this case.


## Event time
- suffered with skew
- more contextual and correctness than processing time
## Process time
- suffered with lag

## Batching
- correctness is ensured when all the input is consumed
### Joins
- Broadcast join
- sort-merge join
- map-side join
### how fault tolerence is ensured in batch system



## Streaming

## State management
### local state
- keeping state local as a log
### remote state
- calling a remote DB 

## Input stream partitioning model

### how to handle staggler events
1. ignore event but setup alerts if we are dropping too many events
2. recalculate the meteric and republish
3. inform producer to stop producing event before time t.
### Fault-tolerance
#### Issues
#### Solution
- checkpointing
- microbatching
- Exactly-once semantics
- idempotent
### windowing
- It defines where in the time(snapshot) result are getting calculated
 - Fixed window/Tumbling window
   - "In some cases, it’s desirable to phase-shift the windows for different subsets of the data (e.g., per key) to spread window completion load more evenly over time, which instead is an example of unaligned windows because they vary across the data"
 - Session window
 - Sliding window
 - Hopping window

### Trigger
- it dictates when the output of a window should get materialized. 
- **Periodic triggers**: 
 1. Aligned processing time delay - triggers the result to be emitted at processing delay of fixed interval for each key across all windows
 2. Unaligned Processing time delay - triggers the result to be emitted at fixed interval after recieving any new data.
- **completeness based trigger**
 1. perfect watermark
 2. Heruistic based watermark

### Join
1. stream-stream join
- joins two streams. Both stream maintain a configured window then events are correlated and merged.
2. stream-table join
There can be multiple solution
- query the database. can load the database and slow
- cache the data or local index. In this case data will become stale in which case cdc is required.





## Rough
- approximations have inbuilt notion of decay
- Hyperloglog used for cardinality estimation

## Lib
- **Apache Beam** is a unified programming model and portability layer for batch and stream processing, with a set of concrete SDKs in various languages
- Execution engines: Apache-flink, Apache-apex, apache-spark, cloud dataflow


## Apache Beam
- PCollection: represent massive dataset which can be parallelly consumed.
- PTransforms: operation that transforms a PCollections to other PCollections.

## Apache storm
- distributed RPC