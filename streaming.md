## Resources
- Millwheel paper
- Streaming system book

# Design principles and requirements

## Handle stream imprefection
1. Delay
2. Missing
3. Duplicated
4. out of order

## Correctness
- Same predicatable result can be obtained by replaying. Note that for some usecases out-of-order processing might result in different result.

## low latency
- persistence of msgs can cause extra latency
- polling based system cause processing delays. We can safetly add half polling interval to processing delays.
- timeout on potentially blocking operations.

## StreamSQL 
### operators
 1. when map and reduce stages are blurry they are called operator. 
 2. Operator maintains managed fault tolerant state???
 3. type- aggregate, join, merge
### window 
- It defines where in the time(snapshot) result are getting calculated.
- Window of some interval range can be marked closed once the event with event time more than window endtime arrives.
#### Type 
- windows can be categorized using length criteria or overlapping criteria
 1. Fixed window/Tumbling window: fixed length of time and non-overlapping.
 2. Session window: length is defined by number of message or breakpoint criteria in message attributes. it is non overlapping  
 3. Sliding window: length is fixed and overlaping with current window
 4. Hopping window

### Fault-tolerance
#### Issues
#### Solution
- checkpointing
- microbatching
- Exactly-once semantics
- idempotent

## Integration
- common language for live data as well as stored data.

## Scalability
- partition application state to more commodity server
- leverage multi threading 
- load balacing over multiple machine.

## Glossary
- Watermarks: signals the completeness of arriving of event with respect to some specific event time.
- Accumulation: overlapping or non-overlapping deltas of accumulation from same windows.
 3. fault tolerance require mini batching and checkpoint mechanisms.
 4. **Processing time** - when event was received by the collector, **Event time**: Time when event was actually generated, **Event-sent time**: time when event was sent from the client to collector.
 5. correctness and reasoning about time required for streaming to outperform batch.
 - Think in terms of time-lapse diagram
 - If external systems are contacted, it is up to the user to ensure that the effects of their code on these systems is idempotent.

## Details to be captured before pipeline 
- **What** results are calculated.
- **where** in event time results are being calculated. Answer can be time-agnostic/event time/ processing time/time-agnostic approximattion as well.
- **when** in processing time results are materialized - usually at time when majority of events are believed to be already gathered. materialization for a single window can be done at multiple times.
- **how** do the refinement of results are accumulated.

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
 - **low watermark**: the latest unprocessed event time - helps in detecting that if event before t will never arrive or lag.
 - when in processing time we mark the completeness of event window
 1. wm based on oldest in-flight/unprocessed in event time domain. If the oldest unpocessed packet is stuck then pipeline will not proceed. 
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


Here are some excellent resources for understanding watermarks and windowing concepts in streaming systems:

**Articles & Blog Posts:**
- "The Dataflow Model" paper by Google - The foundational paper that introduced many modern streaming concepts including watermarks
- Confluent's "Stream Processing with Apache Kafka" series - Clear explanations of windowing concepts with practical examples
- Flink's official documentation on "Windowing" and "Event Time" - Comprehensive coverage with great diagrams
- Databricks' "A Deep Dive into Structured Streaming" - Excellent for understanding windowing in Spark Streaming

**Books:**
- "Streaming Systems" by Tyler Akidau, Slava Chernyak, and Reuven Lax - The definitive resource for understanding streaming fundamentals
- "Kafka Streams in Action" by Bill Bejeck - Great practical examples of windowing concepts
- "Streaming Data" by Andrew Psaltis - Good coverage of streaming concepts across different systems

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

The "Streaming Systems" book by Akidau et al. is particularly recommended if you want a deep, thorough understanding of these concepts, as it covers the theoretical foundations along with practical applications across different streaming platforms.

- "In some cases, it’s desirable to phase-shift the windows for different subsets of the data (e.g., per key) to spread window completion load more evenly over time, which instead is an example of unaligned windows because they vary across the data"