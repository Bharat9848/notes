# OS
## CPU instructions
 - `cmpxchg`

## Processors
 - User mode is non previleged means program can be preemptied at any time. Kernel mode is previliged means kernel programs are non preemptive.

### Registers
### Shared Cache system
 - fast hash tables without chaining ?
 - for case where read/write ordering is required coherency is maintained using cohrency exchange messages."Store buffers" exchange message write to these caches ??? "invalide queues" to mark invalidation to these caches.
 - Cache lines are not of byte or word size. They are in between range of 32-256 bytes. Given two different independent variables and happen to fall in same cache line are changed by different threads/processors. Then it would require cache coherency protocol for ordering as if these two variable are a single variable. This is called **false sharing**.     


## System calls
 - select() ?
 - poll() ?
 - read() ?

## Devices
 - Devices should be direct memory access compatible means data should be transferred between devices and secondary memory easily.

## OS Architecture
 - Security: One program should not interfere the integrity of other program i.e. its resources should not be changed maliciously by other rogue program. Program's instructions are coded in virtual addresses. 
 - Fairness: Process got preemption based on time.
 - Throughput: Processes blocked due to IO get preemptied to give control to other running programs.

## Further reading
 - How memory barrier works in mutliprocessor cpus?



Configure Stack

step 1. configure stacktop and stackbootom tags with some reserved memory.
step 2.  point stackpointer register to stack top

