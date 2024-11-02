# books
 - Lmax disruptor
 - Concurrency in practice
 - JSR-166

# Concurrency
 - Mutual exclusion is unnecessary if only thread is accessing the contended resource. This strategy is used in Akka.
 - **Busy spinning** is a technique when cpu resource is not an concern while latency is important. **Waiting on lock/condition object** is used when cpu is scarce resource.


## Issues
 1. Mutual exclusion
  - require in case of multiple writer.
  - not required in case of multiple reader.
 2. Visibility of change
 3. Fairness

## locks
 ## Type
  - Mutex
  - semaphores
  - circular barrier
 
 ## Pessimistic locking
  - Internally when a running thread is blocked on some lock consquently program requires context switch from blocked thread to some other non-blocked thread. It requires arbitration from kernel. CPU registers will switch from user mode to kernel mode. It is an expensive operation.

 ## Optimistic locking
  - Compare And Swap(CAS) operation:
  - Internally it is a special CPU machine code instruction `cmpxchg`. It does not require context switch to kernel for arbitration. However the processor must lock it's instruction pipeline for doing compare and then swap operations one after the another. Processor also estabilish a memory barrier to allow the variable visibility across multiple processers.
  - CAS operations for muliple lines of codes in critical section is extermely difficult to write than conventional locking.

## Memory Barrier
## Fence


## lockless 
 - uses techniques like atomic variables, retrying operations and achieve algorithm etc to achieve same functionality as a locking algorithm

## ?
- The most common technique employed by CPUs to hide memory latency is to pipeline instructions and then spend significant effort, and resource, on trying to re-order these pipelines to minimise stalls related to cache misses.
- Modern single CPU contains multiple execution unit which can do combination of arithmatic, conditional and memory manipulation 


 ## practice
  - implement segmented concurrent hashmap
  - implement delayQueue for producer and consumer - data available after specific time. 



