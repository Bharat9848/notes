## Advanced Queue Messaging Protocol - AQMP
- Defines binary protocol implementation which helps in interoperability
- stream based transport
- Channel 
- Multi channel using same tcp connection
- Message(channelNo, Size, Message)
- Transaction - for publish and acks.

## Glossary
- Routing key
- exchange
- Binding: Queue and exchange together make a binding

## producer
- publish messages with routing key

## Exchange
- routing decision then sends the message to different queues
- routing logic supports 
  1. topic based routing with wildcard support
  2. header based routing.

## Queue
- receives message from an exchange
- Message durability is upto implementation. It can be in-memory or disk based
- messages are stored till delievery

## consumer
- get message from push/pull mechanism.

## RabbitMQ
- Asynchronus batch transfer - ACK/NACK transfer ACK with Fsync 
- Reordering of messages before delivering to queues.
- Flow control
- better defined transcational behaviour
- acknowledgment mechanism for the publisher
- consumption bookkeeping
- handle messages in DRAM memory
- Best performance when queue is empty or nearly empty
- degradation when messages are allowed to accumulate.
- Alternate exchange for no binding or no bounded queue 
- Alongwith AQMP transaction, rabbitMQ has made rejection transactional ?
- Fedrated exchanges
- Shovel mechanism

## Multicasting
 - per queue per consumer but single copy of data but keep multi indexes and maintains them per consumer.