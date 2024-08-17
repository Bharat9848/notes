## GC
## General
- GC is a computationally heavy operation.
- GC runs parallely to application threads and cause pauses in all running threads.
- efficient object reallocation
- One quick trick for optimizing GC operation based on this is to adjust the sizes of heap areas to best fit your applications’ needs.
- Garbage collection cycle events contain three phases – 
   1. marking = GC runs through the heap and marks everything either as live (referenced) objects, unreferenced objects or available memory space. 
   2. deletion = Unreferenced objects are then deleted
   3. copying/compaction. Remaining objects are compacted. In generational garbage collections, objects “age” and are promoted through 3 spaces in their lives – Eden, Survivor space and Tenured (Old) space. This shifting also occurs as a part of the compaction phase.
- Collection Type
  1. Minor collection: GC runs on eden space. 
  2. Major collection: GC cycle runs on all space.


## Type of GC
 - Choice of GC can be evaluated using.
  1. Throughput
  2. Latency
  3. Workload type.

### General type of collectors
 - Stop the world collector
 - concurrent collector
 - copying collector : They are best for immutable objects workload but disaster for object pooling optimization
### G1 
  - The Garbage first collector (commonly known as G1) utilizes multiple background threads to scan through the heap that it divides into regions. It works by scanning those regions that contain the most garbage objects first, giving it its name (Garbage first).


## Tuning of GC
 1. Allocate size to different survivor spaces.
   The fact of the matter, though, is that the duration of a Minor GC is reliant not on the size of the heap, but on the number of objects that survive the collection. That means that for applications that mostly create short-lived objects, increasing the size of the young generation can actually reduce both GC duration and frequency.


## TIPS for writing good GC Efficient code.
  1. Java standerd collections use arrays for storage underneath. As arrays have fixed capacity so if at runtime arrays crosses its capacity a new array is allocated and all objects from old array is copied to new array. So to keep a single array through out the lifetime of collection. Its better to declare collections with their expected sizes.
  2. While reading a file dont use intermediatory storage object like byte array Instead feed ur stream directly to your final parser.
  3. Immutability implies that all objects referenced by an immutable container have been created before the construction of the container completes. In GC terms: The container is at least as young as the youngest reference it holds. This means that when performing garbage collection cycles on young generations, the GC can skip immutable objects that lie in older generations, since it knows for sure they cannot reference anything in the generation that’s being collected.
  4. `System.gc` triggers a manual major GC. It is not recommended. It will disrupt heuristics.  
  5. Avoid `static` variable as they run forever.
  6. Before throwing away object we can mark inter object references to null as more interconnected objects are more complex and error-prone GC task is
  7. Use weak, phantom and soft references for usecases like cache etc. in case memory is constrained

