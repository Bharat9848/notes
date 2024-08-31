## Problem
 - queue implementations conflated with consumer and producer concerns. Locking mechanism are needed at head, tail and size implementation because of contention. These locks usually fall victim to modern processor cache system' **false sharing** problem.  
 - single thread with lock which means there are no contention was causing significant slowness(3-4 times).
 - Heavy load queue systems are slow because of object promotions from eden space to survivor space. Survivor space garbage collection is not very latency friendly system 
  
## Solution
 - Ring buffer of not data but container of data objects. So that it is not garbage collected.  
 - Ring buffer is immortal object as it is preallocated. Immortality have low garbage collection overhead. Preallocation means ring buffer objects are allocated in a contiguous block of memory which is advantageous in prefetching in cpu caches. 

## Further reading
 - modern processor 

## Excercise
 - gather evidence of user mode to kernel mode switch between locking 

## Unknown
 how memory buffers works ?
 - "Modern CPUs are now much faster than the current generation of memory systems. To bridge this divide CPUs use
complex cache systems which are effectively fast hardware hash tables without chaining. These caches are kept
coherent with other processor cache systems via message passing protocols. In addition, processors have “store buffers”
to offload writes to these caches, and “invalidate queues” so that the cache coherency protocols can acknowledge
invalidation messages quickly for efficiency when a write is about to happen."
