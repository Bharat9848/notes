

## server meterics
- Server process up and running.
- request/sec
- Number of application container threads blocked or busy.
- Downstream services up and running 
- Downstream services network latency

## cloud services monitoring

## Node meterics
### CPU 
- processor load
- CPU statistics like cache hits and misses?

### Memory meterics 
 - RAM usage by OS and processes,
 - page faults, 
   swap space usage, and so on. 
### Network meterics
- throughput/sec
- server round trip latency
- client round trip latency

### Disk metrics
- IOPS: disk capability for number of i/o operation it can do per sec. Blob-storage payload generally hits IOPs limit of a disk.
- badwidth: Max data limit it can send out or receive in. OLAP payload generally hits the bandwidth limit of a disk.
- Disc space
- Disc read latency
- Disc write latency
- Disk swap space usage: Not recomendded for server, as it lead into increased number of page faults. 

### OS optimization
- see linux-performance.md 

## Profiling tool
 ## Flame graph
 ## system tool
 - see linux-permormance.md
# Java performance tips
 - see JIT notes in java.md
 - To measure single operation performance run `System.gc()` and `System.runFinalization` to remove the effects of GC and finalizer thread.
 - Uncontended synchronization takes in tune of 100ns 
 - Synchronization vs atomic variables give best performance in tune of milli when contention is very less. As soon as contention increases the difference between the performance start decreasing. 


# Explore
## Compression
 - zlib
 - zstandard 