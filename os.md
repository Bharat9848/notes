# OS
# Books and resources
- https://www.linuxjournal.com/article/6345
- papers/zeroCopy.pdf
- Os concepts by Galvin
- Modern os by tanenbaum
- Os by stalling

## Glossary
 - what is `ulimit`

# CPU
- Cpu `control unit` controls operation sequencing and clock events etc. 
- other part is `arithmetic and logical unit`.
## CPU instructions
 - `cmpxchg`

# program/process
- How process instance is divided in sections when loaded into memory from lowest to upper
    1. Instruction section block 
    2. Data block - static and global variables
    3. Heap block
    4. Activation record ( method call) stack section
- program creation was previously an eager process these days this is a lazy process with the help of paging and swapping.
- Os needs following abstraction from a process for its lifecycle management 
  1. create
  2. destroy
  3. wait (before destroy): for graceful exit. 
  4. suspend(optional)
  5. status: returns current status.
- process can be in three states:
  1. Running
  2. Ready: 
  3. Block: process was in running state when it starts an I/O operation and then it have to wait. After I/O is complete it will come back to ready state.
  4. Final(zoombie): process has exited but its `machine state` not cleaned up 
- parent-child process cleanup proces: parent process calls `wait()` to wait on child process to finish. `wait()` suspends the parent process and retuns finished child process returned state. After this ??? child process is cleaned up from its `final` state.
- `process list` contains information about all the process in the system, in form of `process control block`.

## context-switch 
- it is low level mechanism
- process `machine state` is its address space in main memory, cpu registers like program counter(Instruction pointer), stack pointer and frame pointer and list of open files.
## scheduling-policy
- It is a policy through  which os decides which process to run next.


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
 - **Virtual memory**: Process is put under the illusion that it has a single memory space form 0 to Max required. It helps in memory allocation.

## Process scheduling
 - NICE value
 - multilevel feedback queues
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
 - Drawbacks of traditional OS
   1. Virtual memory manangement happen at a global scope. It allows memory hungary process to page out other processes pages. 
   2. CPU scheduling also happen at global scope. Modern applications creates sets of processes to accomplish a task. More number of processes cause CPU scheduler to allocate more CPU to sister processes.
   3. kernel memory is also global shared resource.
## Hypervisor
- run different os on each VM.
- resource isolation
- cleaner service statistics.

 1. container vs vm
  container is optimized on image transfer time and startup time. Image transfer time is reduced as compared to VM as it does not contain the operating system.
  container runtime engine like docker act as virtualized operating system
 


The interface between the container runtime engine and the container has been standardized by the Open Container Initiative,




## WASM
Wasm is a binary instruction set architecture (ISA) like ARM, x86, MIPS, and RISC-V. This means programming languages can compile source code into Wasm binaries that will run on any system with a Wasm runtime. Wasm apps execute inside a deny-by-default secure sandbox that distrusts the application, meaning access to everything is denied and must be explicitly allowed. This is the opposite of containers that start with everything wide open.

WASI interface sandbox wasm apps to run outside browser

## Excercise
- do coding excercise `process`-chapter from book `Operating System-Three easy part` 

## Rough
- "    In operating systems, there are four necessary conditions if a deadlock happens:

        Bounded resources: Only a finite number of client requests can access a resource concurrently.

        No preemption: Once a lock is acquired, its ownership can only be changed by the thread that acquired the lock.

        Waiting while holding locks: When a client needs multiple locks, it acquires one, then waits for the next ones to be acquired by keeping the previously locked resources.

        Circular waiting: There is a circular wait between different threads.

    The four conditions listed above are necessary for a deadlock. This means that if we don't let any one of them happen, we can prevent the deadlock. GFS primarily targets circular waiting. With its well-defined locking order, it never lets a circular waiting happen and avoids deadlocks."

-



Device should be Direct memory access compatible. Address should be logical address.


Special os call are converted into supervisory instructions while normal program call are converted into branch and save instruction. Supervisory instructions SVC raise interrupt or trap at runtime. Each type of trap have their own interrupt routine which are stored in dispatch table in memory. During the routine call processor mode bit changed to 0 kernel mode after it's execution its converted back to 1.


Program control block is a main memory structure contain process id, open fd, open device id etc.

After block and wait task is finished by os. Process is again entered in ready state to again get rescheduled for cpu.

Running state for process is when cpu is running it's instructions,

 Store buffer: modern processor use hierarchy of caches to store write before flushing to main memory and use coherence protocol to remain sync with other processor caches

Kernel mode is privileged, atomic - it is non preemptive 

Os kernel consists of process manager, memory manager, device manager, file manager and protection manager.

Address space is range of address used by a program. Programs do not have direct access to RAM instead they refer to virtual address space.

Virtual address for every process starts with 0 so no offset calculation on programmers part. Contiguous virtual address is hiding the non contiguous physical memory.

Segmentation: 
- variable size memory frame called segments.
- suffers from external fragmentation which causes pauses when system is out of memory. It needed defragmentation to fix it.
- uses segmentation register ?

Paging: 
- fixed size memory frame called frame or page. A Frame referred to physical memory's region while a page referred to virtual memory's regions.
- suffers from internal fragmentation that occur within a page.

Sequential consistency? Single Total modification order
Use of atomic type prevent compiler and hardware reordering - lockless in C C++.

Synchronisation requirement (look for another source)
1. Mutual exclusion - if two process wants to enter a critical section simentaneously then only one is allowed 
2. Progress - if no other process wants to enter except one then nothing should stop interested process to enter critical section.
3. Bound waiting - one process should not wait indefinitely to enter critical section.

User mode solution for synchronisation - lock variable, strict alternation, dekkers algorithm, peterson solution

Lock variable satisfy progress but not mutual exclusion and bounded waiting. While strict alternation supports mutual exclusion and bounded waiting. Peterson algorithm satisfy all three requirements.


Hardware solution for synchronisation - Tsa instructions, swap instructions

Kernel level mechanism - monitor, semaphore, sleep and wakeup
"    
- "In many operating systems, a common design paradigm is to separate high-level policies from their low-level mechanisms [L+75]. You can think of the mechanism as providing the answer to a how question about a system; for example, how does an operating system perform a contextswitch? The policy provides the answer to a which question; for example, which process should the operating system run right now? Separating the two allows one easily to change policies without having to rethink the mechanism and is thus a form of modularity, a general software design principle."