# Requirements
- Data production is very spiky or uncontrolled. We can handle the usecase with consumer and producer decoupling.
- producer and consumer have independent usecases which might be fatal for business decoupling producer and consumer helps in this case. 
- online consumption only: No retention of message for longer periods.
- offline and online consumption
- Transaction across multiple queues.
- Ordering guarntee.

- Temporal decouplng: producer and consumer are not actively participating in communication in timely manner.
- Entity decoupling: producer and consumer should not be aware of each other.
- Synchronization decoupling: publisher/Subscribe should not need to block producer and consumer thread.
- Routing logic
  - simple topic based
  - regex topic based
  - message's data/metadata field based.
- correctness is based on delievery semantics and ordering guarntees.
  - Delievery semantics: check `delievery semantic` in DistributedSystem.md
  - Ordering gurantees:
    - No order
    - Partition-order: casual ordering is maintained at a partition level but not across partitions
    - Total order: Ordering across all partitions
  - latency: calculated by time between message entering and message leaving the pub/sub infra.
    - compute cycles for metadata handling e.g. validation, routing etc.   
    - compute cycles for packet copy
    - storage class access - write vs read, DRAM vs disk, seq vs random access
    - persistence and ordering overhead
    - dequeuing latency: dependent on consumer speed
 ### Activemq
  - Disadvantage
    1. heavy penality of random access in case queue extend beyond RAM
    2. separate queue for each consumer.  

## Messaging queue vs Topic
 |feature/characteristic| Messaging queue          | Topic |
 |----------------------|--------------------------|--------------|
 | Data security        | Only consumer can listen | Anyone can listen |
 | Entity Decoupling    | Producer consumer know each other | Producer does not know about consumers |
 | Architecture flexibility | Number of consumer can scale      | Producer need to change for new type of consumer |
 | Data Contract        | Different consumer can have different contract | All consumer need to have same data contract |  

# tech
- see kafka.md
- see rabbitMq.md
- JMS : Apache activeMQ is implementation of JMS 
- IBM websphereMQ