# Kafka

## Run kafka locally
1. `K8 run --rm --image apache/kafka:latest` 

## traditional messaging system
- No transaction across multiple queues except IBM websphere MQ.
- not data partition across different machines.
- Message are assumed to be consumed online - as near time as possible. Less offline capabilities like batch apis or replaying etc.
- No batch APIs.
- Message acknowledgement one by one like in JMS.

## Design
1. Partition: it serves two purpose
   - Ordering is maintain in a single partition
   - Filtering/routing : Partition's data is sticky based on its key. This prevents rerouting of data among brokers after materializing state in the brokers.
2. Consumer group
   - Set of coordinating process which allow data partitioned.
3. Fault tolerance: Message replays can be used by consumer       

---

# Kafka producer

## Partitioner
- Producer do the load balancing across different brokers either using round-robin or predefined key based partitioning
- `linger.ms` If set to zero, publisher will not wait for additional messages for batching it will send the message as soon as it arrives.

## Availability
- `acks=all` makes partition leader wait for all the in-sync replica to return acks, only then it send ack to producer. This config allows the most safe mechanism for delievery and least performant. 
- `request.required.acks` ??
- Ack without Fsync 

### Kafka Producer API
1. Request object is `producerRecord`. `topic` and `value` byteArray is mandatory. While `key` and `partition` is optional.
2. Response is `RecordMetadata`. It have offset
3. client side exception occurs even before sending message to kafka
   1. SerializerException
4. Remote exceptions can be broken into recoverable and non-recoverable
   - Recoverable exception includes 1. No Leader 2. Connect exception
   - Non recoverable include - Message too long 

### Kafka producer-broker delievery
#### Exactly-once
  - Writing to kafka broker log is idempotent operation with the help of (producerId, sequenceId) metadata at each bulk write msg. Repeated message are checked in log if message with (producerId, sequenceId) is present then it is discarded and acknowledged.
#### At-least once:
  - need acks when data is written to disk or quorum of replicas

#### At-most once 
- `enable-idempotence=true` will make producer `send` operation idempotent means the message will be written in broker logs only once, even if producer retry. It also make sure of in-order semantics. Kafka uses an incremental sequence number which is assigned by the producer to each message. Broker and replicas check their partition log to see if seqence number is already received and do deduplication.


# Kafka transaction

- do not support transaction with external system. Instead rely on idempotence to propagate from an output topic to external system through kafka connect.
- `transactional.id=fundsAssempe` uniquely identify the application
- `processing.guarntee=exactly_once_v2` for streaming with consumer having `isolation_level=read_committed`
- A typical transaction can consist of processor, multiple consumer partition and multiple producer offset. 
- Transaction need to be serialized as messages belong to a transaction committed before other transaction should come first.
- Each transaction explicit commit will cause too much lag in kafka pipeline
- consumer group coordinator = `__consumer_offset`
- **Transaction coordinator**
  - Each producer group is assigned a broker as a transactional coordinator
  - `__transaction_offset` is an internal topic maintained by transaction-coordinator. 
  - Processor will be the producer for this topic.
 - **Happy Transaction workflow** 
  1. Processor finds its transaction coordinator.
  2. processor sends new transaction request to transaction coordinator.
  3. At start of a transaction, coordinator uses Producer ID and epoch time tuple as unique identifier for a transaction and communicate it back to processor after putting an entry into this `__transaction_offset` topic.
  4. processor consumes data from input topic.
  5. After processing just before processer about to write to output topic, it informs transaction coordinator about its intention.
  6. processor write processed output to output topic in uncommitted state.
  7. processor also writes to internal `__consumer_offset` topic in uncommitted state
  8. Once all the output is written to all output topics, processor request transaction commit request to transaction coordinator.
  9. Transaction sends the committed marker to all output topics and `__transaction_offset`. it marks the transaction complete. 
 - **Failed and recover transaction flow** 
- special message - `Abort` `commit`
- Recovery after failed transaction 

### kafka broker-consumer delievery mechanism
- Kafka guarntees the in-order delivery of a partition but not across partitions.
- `isolation.level=read_committed`
- `isolation.level=read_uncommitted`

--- 

# Cluster management
### Zookeeper
 - Maintans session with brokers with `zookeeper.session.timeout.ms`. 
 - watcher nodes - broker and consumer can trigger rebalance.     
1. Cluster Management
- Consumer metadata
 - detection of removal and addition of consumer. Removes their respective ownership registry and notified the watchers. 
 - consumer registry: comsumer saves the consumer information like which consumer group it belongs to and topics it is subscribed to. It is a ephemeral registry.
 - saves the consumer offset data against partition, 
  - **ownership registry**: it is ephemeral - `consumer_group/topic/partition1/owner cons1`
  - **offset registry** It is permanent - `consumer_group/topic/partition1/offset x`


2. controller management

3. Topic and partition management: Saves broker partition ownership metadata
  - Each broker watches other broker's ownership registries. Broker registries are destroyed when owner dies.
  - **broker registry** ephemeral nodes for broker partition ownership `broker/topic/<partition>/owner br1`

4. in-sync data replication

5. data configuration like quota and ACL.

### No zookeeper
- Each broker maintains the partition to primary broker assignment. So any producer and consumer can ask for metadata from any broker.
---

# Kafka broker

## Cluster controller
- one of the cluster is selected as cluster controller which helps in partition assigment to primary brokers. 
- It monitors broker failures.

## internals
- log compactions: keep the latest data for each key
- keeps sorted list of offset of each segment's first message
- intentionally no caching of messages in kafka broker process. Instead kafka rely on OS page cache. It has multiple benefit of less garbage, warm cache in event of broker restart, catched up consumer with producer can benefit from OS cache write through heuristics.
- uses OS `sendFile` API to skip steps of copy data from os page cache to application buffer and then from application buffer to socket buffer. `sendFile` api sends data directly from os page cache directly to socket buffer.
- broker does not maintain consumer offset.
- `log.flush.interval.messages` and `log.flush.interval.ms` are used for Fsync data from memory to the disk


### Storage
- partition data is stored in segments file of 1GB
- No explicit message Id, No primary index of Ids vs location, No random seek
- Message id is offset of msg in a file. offset are not consecutive but increasing in nature. Next msg offset is previous message offset plus the previous message length.
- Message are stored with CRC to check msg integrity during any I/O error and network error during production or consumption.

---

# Kafka Consumer
 - Consumer messages acknowledgment to broker means it has acknowledge current as well as all the previous offsets.
 - consumer can call `commitSync` to acknowledge the message synchronously before receiving next set of messages.
 - consumer can call `commitAsync` to send acknowledgement independent of `poll`. 
 - consumer `poll(<msgs>)` is batch read api. Internally consumer sends the offset id and number of bytes it want to receive. Broker keeps a sorted list of first message offsets from each segment file in memory. Broker locate the segment file using sorted list. And send data from the file to the consumer. After receiving message, consumer do the next offset calculation using the number of bytes it have received for next poll call.  

## Kafka coordination
### consumergroup-offset-management
 - **consumer checkpointing**The consumer offset manager associates each key (consumergroup-topic-partition) to the last checkpointed offset and metadata for that partition and stores them in zookeeper. Zookeeper maintains the latest offset of a consumer in case of consumer failures.

### Consumer rebalancing ??
 - For (`<v0.8.2`) consumer watch zookeeper registry for consumer ownership registry. It gets notified if any consumer added or removed. 
 - group management API 
 - group coordinator(>v0.8.2) - Kafka broker that maintains group membership of a group.
 - load balancing done by consumers themselves ???
 - Embedding protocol in group managment API that does rebalancing or load balancing withing group. Rebalancing is stop-the-world rebalancing, which can have serious drawbacks as trigger can be temporary like intermittent interruption or k8 scaling up (new node with security batch applied) etc.

 #### New Rebalancing algorithm
 ````
 Algorithm 1: rebalance process for consumer Ci in group G
For each topic T that Ci subscribes to {
remove partitions owned by Ci from the ownership registry
read the broker and the consumer registries from Zookeeper
compute PT = partitions available in all brokers under topic T
compute CT = all consumers in G that subscribe to topic T
sort PT and CT
let j be the index position of Ci in CT and let N = |PT|/|CT|
assign partitions from j*N to (j+1)*N - 1 in PT to consumer Ci
for each assigned partition p {
set the owner of p to Ci in the ownership registry
let Op = the offset of partition p stored in the offset registry
invoke a thread to pull data in partition p from offset Op
}
}
 ````

### Incremental cooperative protocol  
 - New incremental cooperative protocol replaces stop-the-world rebalancing kafka client protocol. 
 - Two basic tenent 1.to not to reach new global state in a single go. 2. Cooperating client should volutarily reliquish control on their resources to rebalance again.

---

## Kafka connect
 - connector- keeps the bookkeeping with external system.
 - worker 
 - connector task- do the data transfer

---


## Kafka stream
- read general streaming.md notes
- `processing.guarntee=exactly-once`
### Assumptions and design choices
- no backpressure: As buffering is done at consumer and bulk-write before writing by producer. Each stage work on a single element at a time.
- No support for asynchronus operation. It require that user do not do blocking operation.
- No resource manager
- `KStream` abstraction for stream indepenent k-v pairs while `KTable` is an abstraction for a table changelog.
- Out-of-order events are processed in case it comes before window retention period and then window emits an next entry in changelog. `window` operator returns a `KTable` as output. 


## Rough
monitoring stats http://www.confluent.io/blog/how-we-monitor-and-run-kafka-at-scale-signalfx


 it’s most useful to notify on alerts for the two leading indicators: Log Flush Latency (95P) and Under Replicated Partitions.
Any under replicated partitions at all constitute a bad thing. So for this we use a simple greater-than-zero threshold against the metric exposed from Kafka.


Scaling and Capacity

Scaling Kafka is involved.

The adding capacity part is easy. But re-balancing topics/partitions across brokers can be quite hard. For smaller, or simpler, set ups, Kafka can generate an assignment plan for you that  - provides even distribution across brokers. Which is fine if your brokers are homogenous and co-located. This does not work well if your brokers are heterogenous or spread across data centers. So we manually manage the process. Fortunately, Kafka takes care of the actual movement of data, given the partition to broker assignments. And with the expected addition of rack/region awareness, Kafka will soon allow for this kind of spreading of replicas across racks and regions.

This is where the pain comes in. Say you have a lot of traffic on one topic and are adding capacity for it. The topic partitions have to get spread across the new brokers. Although Kafka currently can do quota-based rate limiting for producing and consuming, that’s not a applicable to partition movement.Kafka doesn’t have a concept of rate limiting during partition movement. If we try to migrate many partitions, each with a lot of data, it can easily saturate our network. So trying to go as fast as possible can cause migrations to take a very long time and increase the risk of message loss.

This issue will be obviated soon, as we’re expecting Kafka’s built-in rate-limiting capability to be extended to cover partition data balancing. In the meantime, to reduce migration time and the risks, we end up moving one partition at a time, watching the bytes in/out on the source and target brokers, as well as message loss. We use those metrics to control the pace of rebalancing to minimize message loss and resource starvation, thus minimizing service impact.

Here’s the dashboard we observe, with the network in/out in the charts on the top right.

## Resources
- kafka paper - Done
- kafka the definitive guide book
- Jaspen - kafka
