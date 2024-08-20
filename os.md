# OS
## CPU instructions
 - `cmpxchg`

## Processors
### Registers
### Shared Cache system
 - fast hash tables without chaining ?
 - for case where read/write ordering is required coherency is maintained using cohrency exchange messages."Store buffers" exchange message write to these caches ??? "invalide queues" to mark invalidation to these caches.
 - Cache lines are not of byte or word size. They are in between range of 32-256 bytes. Given two different independent variables and happen to fall in same cache line are changed by different threads/processors. Then it would require cache coherency protocol for ordering as if these two variable are a single variable. This is called **false sharing**.     



## Further reading
 - How memory barrier works in mutliprocessor cpus?



Configure Stack

step 1. configure stacktop and stackbootom tags with some reserved memory.
step 2.  point stackpointer register to stack top

