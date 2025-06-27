# OS
# Books and resources
- https://www.linuxjournal.com/article/6345
- papers/zeroCopy.pdf

## Glossary
 - what is `ulimit`

## CPU instructions
 - `cmpxchg`

## Kernel
 - handles I/O managment, process management, device management and resource management.
 - **Monolithic** - Separate memory space between kernel and user services. User processes use system call to avail kernel services.

## Processors
 - User mode is non previleged means program can be preemptied at any time. Kernel mode is previliged means kernel programs are non preemptive.
 - have execution unit and registers.
 - Modern CPU single core additionally have load/store/WC buffer and L1/L2 cache.
 - L3 cache is shared between all the cores.

### Registers
### Shared Cache system
 - fast hash tables without chaining ?
 - for case where read/write ordering is required coherency is maintained using cohrency exchange messages."Store buffers" exchange message write to these caches ??? "invalide queues" to mark invalidation to these caches.
 - Cache lines are not of byte or word size. They are in between range of 32-256 bytes. Given two different independent variables and happen to fall in same cache line are changed by different threads/processors. Then it would require cache coherency protocol for ordering as if these two variable are a single variable. This is called **false sharing**.     

## OS threads
 - Scheduling class
 - **priority inheritance**
 - complex priority inheritance method.

 
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
 - swap space/ virtual memory : In case of less amount of RAM to load a new process, OS put an existent memory pages to disk. For memory pages a part of disk is allocated called swap space. It is tradeoff between OS killing a process and perfromance penality. Lot of server software turn off the this feature as it causes performance penality.   
 - disk cache: It is part of RAM which caches disk pages. Its process agnostic as any process can avail the disk pages irrespective of process which loads those pages. It is very helpful in cases where some producer and consumer process are sharing resources. 
 - Throttling of resource to rogue process

## Throttling
 - Namespaces:
 - control group: 
   - defines the limit, account for, isolate the resources, prioritization.
   - resources are CPU time, system memory, disk storage, I/o and network bandwidth,
   - system memory include file system cache, 

## Further reading
 - How memory barrier works in mutliprocessor cpus?
 - what is difference between DMA copy and cpu copy


Configure Stack

step 1. configure stacktop and stackbootom tags with some reserved memory.
step 2.  point stackpointer register to stack top

## Virtualization
 1. container vs vm
  container is optimized on image transfer time and startup time. Image transfer time is reduced as compared to VM as it does not contain the operating system.
  container runtime engine like docker act as virtualized operating system
 


The interface between the container runtime engine and the container has been standardized by the Open Container Initiative,




## WASM
Wasm is a binary instruction set architecture (ISA) like ARM, x86, MIPS, and RISC-V. This means programming languages can compile source code into Wasm binaries that will run on any system with a Wasm runtime. Wasm apps execute inside a deny-by-default secure sandbox that distrusts the application, meaning access to everything is denied and must be explicitly allowed. This is the opposite of containers that start with everything wide open.

WASI interface sandbox wasm apps to run outside browser



## Rough
- "    In operating systems, there are four necessary conditions if a deadlock happens:

        Bounded resources: Only a finite number of client requests can access a resource concurrently.

        No preemption: Once a lock is acquired, its ownership can only be changed by the thread that acquired the lock.

        Waiting while holding locks: When a client needs multiple locks, it acquires one, then waits for the next ones to be acquired by keeping the previously locked resources.

        Circular waiting: There is a circular wait between different threads.

    The four conditions listed above are necessary for a deadlock. This means that if we don't let any one of them happen, we can prevent the deadlock. GFS primarily targets circular waiting. With its well-defined locking order, it never lets a circular waiting happen and avoids deadlocks."