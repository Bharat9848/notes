# Glossary
- Data cardinality: bounded and unbounded
- data constitution: stream or table
- stream vs table: each key value pair is independent while table each key-value pair is a changelog happened over time on a table means later key-value pair overrides the before data in given key-value pair.
- **Shuffle**: reordering of data in case data is partitioned according to some key. It makes sure that single worker receive data for a particular key


## Questions
- how exactly-once
- how backpressure

- why stateful streaming is required ? 
Unlike batching system the streaming system are unbounded. In batching in presence of faults, we can restart the failed stage as input to the state are immutable files. On the other hand streaming we have to save state in order to recover from failure.

- what is a state in stream processing
State in a streaming system can be offsets (ids from source event stream) or aggregation state of stream like sum, average etc or any combination of stage metadata, offset and state   

- how out of order events are handled.

# Requirements
## Handle stream imprefection
1. Delay
2. Missing
3. Duplicated
4. out of order

## Exactly-once
- see exactly-once in fault-tolerance section

## Completeness
- It refers to the all the events the were processed in time resulted in accurate processing meterics. All the events that arrived after deadline were explicitly dropped. It is common to batch and streaming system. In batch late events refers to data thats never collected or arrived after the batch job has run. 

## Accuracy
- It is common fallacy that batch system are more accruate than streaming system. Batch system have large lateness threshold while for streaming system it can be unpracticle. With exactly once semantic supported it in various streaming system, accuracy should be at par with batching system.

## Correctness
- Same predicatable result can be obtained by replaying. Note that for some usecases out-of-order processing might result in different result.

## Result consistency
- for result consistency we would require exactly-once in all component including source and sink.

## High throughput
- Streaming system should be able to process large amount of data.

## low latency
- persistence of messages can cause extra latency
- polling based system cause processing delays. We can safetly add half polling interval to processing delays.
- timeout on potentially blocking operations.
- Performance of stages can be improved by using fusion of stages.

### Fault-tolerance
- checkpointing: output of an processing stage is checkpointed(persisted) with its unique id before it get send downstream. This way processing never done again on retry. If output is not checkpointed then retrying might cause non-determinism in case processing is using some side effects. 
- microbatching
- Exactly-once semantics: 
1. why: at-least semantics suffers from duplication which results in inaccurate results. While at-most semantic results in lost events which also result in inaccurate events. Aggregations are also done in memory which may cause data loss at node crash. 
2. Performance of deduplication by checking record ids for a key can be improved by using bloom-filter. Bloom-filter are generated repeatedly based on time window.   
3. Acknowleged record Ids can be garbage collected using watermarks.
- non-idempotent side effects does not come under exactly-once semantics.
- late events (as batch system can also have it in form of delay in data collection) are not part of exactly-once

## Integration
- common language for live data as well as stored data.

## Strong programming model
- User should not be constraint with the framework and should be able to design the pipeline as per his requirement.

## Scalability
- partition application state to more commodity server
- leverage multi threading 
- load balacing over multiple machine.

## Flow control
- System should handle backpressure from slow stage all the way to the source.

## StreamSQL 
### operators
 1. when map and reduce stages are blurry they are called operator. 
 2. Operator maintains managed fault tolerant state???
 3. type- aggregate, join, merge, count 
#### count
- uses `groupByKey` internally 

### window 
- It defines where in the time(snapshot) result are getting calculated.
- Window of some interval range can be marked closed once the event with event time more than window endtime arrives.

#### Event Time Windowing
- observation order agnostic
- suffered with skew
- more contextual and correctness than processing time

#### process time windowing
- suffered with lag
- observation order dependent
- It can be achieved using the following
1. **Using trigger**: ignore event time and take window of infinite size and then trigger snapshots
2. **Ingress time**: Assign or override event time with ingress time and then use normal event time windowing.

#### Type 
- windows can be categorized using length criteria or overlapping criteria
 1. Fixed window/Tumbling window: fixed length of time and non-overlapping.
 2. Session window: length is defined by number of message or breakpoint criteria in message attributes. it is non overlapping  
 3. Sliding window: length is fixed and overlaping with current window
 4. Hopping window




## Glossary
- Watermarks: signals the completeness of arriving of event with respect to some specific event time.
- Accumulation: overlapping or non-overlapping deltas of accumulation from same windows.
 3. fault tolerance require mini batching and checkpoint mechanisms.
 4. **Processing time** - when event was received by the collector, **Event time**: Time when event was actually generated, **Event-sent time**: time when event was sent from the client to collector.
 5. correctness and reasoning about time required for streaming to outperform batch.
 - Think in terms of time-lapse diagram
 - If external systems are contacted, it is up to the user to ensure that the effects of their code on these systems is idempotent.
 - Watermark and punctuation provides the overall skew between event time and processing time.

## Details to be captured before pipeline 
- **What** results are calculated.
- **where** in event time results are being calculated. Answer can be time-agnostic/event time/ processing time/time-agnostic approximattion as well.
- **when** in processing time results are materialized - usually at time when majority of events are believed to be already gathered. materialization for a single window can be done at multiple times.
- **how** do the refinement of results are accumulated.
- Above question are also very helpful in defining expressiveness of the APIs.

### Streaming Usecases generalization
  - Anomaly detection
  - outer join
 - time agnostics: 
   - stream joining and filtering usecases without any notion of time.

 - approximation: 
   - approximate top K list and streaming K means.
   - usually based on processing time.
   - "This is particularly important for algorithms that provide some sort of provable error bounds on their approximations. If those error bounds are predicated on data arriving in order, they mean essentially nothing when you feed the algorithm unordered data with varying event-time skew. Something to keep in mind. ??" 

 - windowing by processing time: 
   - does not mimic reality of event time. In case of major delay and lags processing event using processing time give spiky metrics but in reality it was smooth.
   - simple to implement and reason about.
   - best suited for usecases where event time is not reliable like user phone device events.
 
 - windowing by event time
   - requires longer holding of data buffers with time shuffle.
   - completeness is approximate. 
   - best suited when events are replayed as processing time will not be very meaningful. Value of late data diminishes over time.
   - Anomaly detection

## Batching
- correctness is ensured when all the input is consumed
### Joins
- Broadcast join
- sort-merge join
- map-side join
### how fault tolerence is ensured in batch system



## Streaming
## Type of failure
- application bugs
- transient errors - network glitches, node down etc.

## State management
- helps in correctness in case of faults.
### local state
- keeping state local as a log
### remote state
- calling a remote DB 

## Input stream partitioning model

### how to handle staggler events
1. ignore event but setup alerts if we are dropping too many events
2. recalculate the meteric and republish.
3. inform producer to stop producing event before time t.



### Trigger
- it dictates when the output of a window should get materialized. 
- **Periodic triggers**: 
 1. Aligned processing time delay - triggers the result to be emitted at processing delay of fixed interval for each key across all windows
 2. Unaligned Processing time delay - triggers the result to be emitted at fixed interval after recieving any new data.
 - **completeness based trigger - watermark**
 - watermark suffered from lateness or too-early. strategies like early/on-time/late triggers can help in this case.
 - allowed lateness

 ### Watermark
 - Basic properties: 
  1. They are monotonically increasing.
  2. watermark completeness helps in detecting that if event before `t` will never arrive. It is safe to emit any meteric before watermark's time

 - global event time metric for progression in overall pipeline. It created at time of data ingress, it propagate through data pipeline and how it affect output timestamp.

 - **watermark**: the oldest unprocessed event's time among all the pipeline stages.
  1. Visibility if watermark is not making progress it means some event is causing slowness or stuck
 - Types
   - Perfect watermark: It knows about all the data means it proceeds only when it sees all the data at a given timestamp. It can be achieved if It have perfect knowledge of input ingress. E.g. If ingress time is the event time. Or System like apache kafka which assigned event time as data get stored, then watermark will the minimum of event time across all the latest read from all the partitions.
   - Heuristic watermark: It is an estimate that once watermark passed `t` it will never see data from before `t`. But lag events happen. System needs to put some mechanism in place to handle late data.
 - Watermark can be defined at every individual stage of the pipeline. Stages that are nearer to sink will have practically older timestamp as compared to stages which are nearer to input source. 
 - Watermark at each stage can be defined in term of input watermark and output watermark. Input watermark is min of all the output watermark of all the parent stages. output watermark is min of input watermark and the buffered/unprossesed data's min event time. Output watermark miuns input watermark typically gives us the lag/processing delay of that stage. 

 - watermark can be fast or slow.
 - "As we’ve made very clear above, notions of com-
pleteness are generally incompatible with correctness, so we
won’t rely on watermarks as such. They do, however, pro-
vide a useful notion of when the system thinks it likely that
all data up to a given point in event time have been observed,
and thus find application in not only visualizing skew, but
in monitoring overall system health and progress, as well as
making decisions around progress that do not require com-
plete accuracy, such as basic garbage collection policies."
- Read again watermark progression and output timestamp from book streaming system page 75.

- Percentile watermark

 #### Type of watermark
 1. perfect watermark - watermark accounts for all data.
 2. Heruistic based watermark - admits some (not all) late data.
#### Watermark propagation
- propagation of watermark across multiple stages of pipeline.
- increase latency of overall pipeline


 #### 
 - what is perfect watermark creation
 - how it depends on data source
 - input watermark
 - output watermark`

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

## practice
1. Consider two feeds, one containing TICKS data with fields: `TICKS (stock_symbol, volume, price, time)`, and the other a SPLITS feed, which indicates when a stock splits, with the format: `SPLITS (symbol, time, split_factor)`. A typical stream processing application would be to produce the real-time split-adjusted price for a collection of stocks. The price must be adjusted for the cumulative split_factor that has been seen.

## Rough

**Articles & Blog Posts:**
- Confluent's "Stream Processing with Apache Kafka" series - Clear explanations of windowing concepts with practical examples
- Flink's official documentation on "Windowing" and "Event Time" - Comprehensive coverage with great diagrams
- Databricks' "A Deep Dive into Structured Streaming" - Excellent for understanding windowing in Spark Streaming


**Videos & Courses:**
- "Fundamentals of Stream Processing with Apache Beam" on YouTube by Tyler Akidau
- "Apache Kafka Series - Kafka Streams for Data Processing" on Udemy
- DataStax Academy's courses on stream processing

**Documentation:**
- Apache Beam's documentation on "Windowing" and "Watermarks"
- Apache Flink's documentation section on "Event Time Processing"
- Apache Spark's guide on "Structured Streaming Programming Guide"

**Interactive Learning:**
- Confluent's Kafka Tutorials with hands-on examples
- Google Cloud Dataflow Codelabs
- Azure Stream Analytics online tutorials

- "In some cases, it’s desirable to phase-shift the windows for different subsets of the data (e.g., per key) to spread window completion load more evenly over time, which instead is an example of unaligned windows because they vary across the data"

## Resources
- ~~Millwheel paper~~ 
- ~~Adam Warski: “Kafka Streams – How Does It Fit the Stream Processing Landscape?[https://softwaremill.com/kafka-streams-how-does-it-fit-stream-landscape/]~~ 
- ~~low latency [https://www.ververica.com/blog/high-throughput-low-latency-and-exactly-once-stream-processing-with-apache-flink]~~
- Streaming system book
- Kafka stream in action book
- The Dataflow Model paper
- "Streaming Data" by Andrew Psaltis
