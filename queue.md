## AMQP protocol
- very generic
- require lots of domain knowledge of how to use it.
## MQTT protocol
- simple and specific


## ZeroMQ
- It is a library. Not choosing to be a server 
  1. sending data from producer to broker then broker to consumer is an operational and performance challenge.
  2. To get optimal throughput combined with optimal response time in an asynchronous system, turn off all the batching algorithms on the low layers of the stack and batch on the topmost level. Batch only when new data are arriving faster than they can be processed.

- Architecture
  1. API interacts with socket which can connect to multi peers.
  2. worker thread do async work of enqueuing msgs, read data and accept incoming connection
  3. Tree like object heirarchy with `socket` object at the top. Objects can have parent-child relationship across worker thread boundaries. Parent object cannot close until it cleanup all the childs. This allows the all pending msgs are sent before the associated objects are cleaned up.
  4. `Session` and `engine` objects are per connection. On sending side `TCP connector` object creates the session and engine once the tcp connection is estabilished. On receiving side `listener` object creates the sessiona and engine object.
  5. Abstraction: `session` object interacts with socket. `engine` is the underlying protocol based which can be tcp, IPC, pgm etc.
  6. `pipe` which hold lock free queue. one for sending and second for receiving.
  6. "When striving for extreme performance and scalability, consider the actor model; it's almost the only game in town in such cases. However, if you are not using a specialised system like Erlang or ØMQ itself, you'll have to write and debug a lot of infrastructure by hand. Additionally, think, from the very beginning, about the procedure to shut down the system. It's going to be the most complex part of the codebase and if you have no clear idea how to implement it, you should probably reconsider using the actor model in the first place."
  7. Asynchnonus objects which are state machine in themeselves shared between worker threads. Each worked thread have no semaphore, mutexes etc.
  8. Queues are lock-free i.e. deviod of lock, semaphores, CAS operations etc. Queues have only one producer which is user thread and one consumer which is worker thread. Even for 1-to-N usecases uses N queues to maintain one-producer and one consumer strategy.
  9. " When solving a complex and multi-faceted problem it may turn out that a monolithic general-purpose solution may not be the best way to go. Instead, we can think of the problem area as an abstract layer and provide multiple implementations of this layer, each focused on a specific well-defined use case. When doing so, delineate the use case carefully. Be sure about what is in the scope and what is not. By restricting the use case too aggressively the application of your software may be limited. If you define the problem too broadly, however, the product may become too complex, blurry and confusing for the users."


