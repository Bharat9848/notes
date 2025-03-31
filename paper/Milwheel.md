# Milwheel
## Glossary
- Injector
- Timer: can be based on wall-clock or collecting state window expiration.
- computation
- record(key, value, timestamp)
- production: state is reemitted in form an event to downstream. 
- soft state: state kept in-memory. Heap for production timer, queue for checkpointed productions 
- hard state: state kept on a persistent store

- Fault-tolerance gaurantee 
 1. every message is guarnteed to delievered to the system.
 2. exactly once guarantee by using idempotency. It is without putting any idempotency constraint on user's code.
 3. checkpointing at finer level to eliminate to buffer data at external source.

- Key is an abstraction for aggregation and comparison b/w different records
- Persistent state includes usecases like buffers for join, counter aggregation
- Low watermark the earliest unprocessed event in event time domain. It is also act as time bound which does not allow any event of before time to a computation. It is defined as `min(unprocessed event time of compution B, low watermark of A)` where computation B takes input from A. Low watermark does not consider the pending events in the input source.
- **Timer**: trigger the computation at a specific wall time or low watermark value.

## API
- hooks `processTimer(Timer timer)` and `processRecord(Record record)` is exposed to the user
- In above hooks applications arbitrary code runs.
- In the code user can leverage system `setTimer`, `produceRecord` and `mutablePresistent` APIs. 

- low watermark semantics: Injector should not send events from before low watermark of the system. If it does then user code should either discard or accept the record.

## Exactly-once semantics
 - record key is used as an ID and stored in journal once it is received. 
 - duplicated retries was compared against the jornaled Ids. If its already seen before then duplicated retry is acknowledged.
 - optimization: Bloom-filter is kept to fast track keys we have not seen before. For other case ids are campared against recorded data.
 - Garbage collection for data is done when millwheel guaranteed that no internal sender is retrying.
 - for slow injector, garbage collection can be configured to hours.

### Strong production
- production is also saved in same transaction which is used for saving the state modification. This is done before sending production downstream.
- Without strong production, there might be cases the downstream receiver duplicate key with different data which would requires a conflict resolution.

### State manipulation
#### Abstraction gurantees
- system should not lose data
- update to state must follows exactly-once semantics.
- All data must be consistent throughtout the system
- low watermarks must reflect all pending state
- Timer should fire in-order for a given key.  
#### distributed system faults
1. node failure
2. delayed on-wire transaction
3. exalted(not-dead) worker 
#### Implementation
- pending state like timers,state,Production are persisted in same transaction.
- Checkpointing
- Single production writer - A mediator before persistent state will check sequencing fencing token before writing to persistent store. It will prevent fault 2 and 3. Sequencer pattern is being used
#### Optimization
- always in-sync soft state.
- scanning is asynchronus to new event received.

### Architecture
- RPC is used
- single row being used to store state, timer, pending productions
- load balancing is done by master replicated process. It partitions the key range into interval, then assign a sequence to it. Unique sequence no is assigned to a worker. If worker dies new worker is assigned to same sequence. Key interval are split, merge in case of scaling, assigned sequence for key interval are invalidated and new sequence number is assigned and workers are assigned to new workers. Sequenceing also helps in single production writer mechanism.
#### Low watermark
- computed by a subsystem
- Subsystem writes to a persistent store to be fault tolerant
- Values are computed based on pending-state or pending state, pending production, checkpointing production
- Each worker uses its soft state to update the central authority 
- low watermark state is also partitioned based on key-intervals 
- subsytem can be scaled by key-sharding.
- consistency and fault tolerence in process and subsystem is achieved through key-interval sequencer
- Each worker calculates its own low watermark as it can be after than that of global system watermark. 



