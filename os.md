# OS
# Books and resources
- https://www.linuxjournal.com/article/6345
- papers/zeroCopy.pdf







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
