# profiling tools


## Disk metrics
- IOPS: disk capability for number of i/o operation it can do per sec. Blob-storage payload generally hits IOPs limit of a disk.
- badwidth: Max data limit it can send out or receive in. OLAP payload generally hits the bandwidth limit of a disk.

# Java performance tips
 - see JIT notes in java.md
 - To measure single operation performance run `System.gc()` and `System.runFinalization` to remove the effects of GC and finalizer thread.
 - Uncontended synchronization takes in tune of 100ns 
 - Synchronization vs atomic variables give best performance in tune of milli when contention is very less. As soon as contention increases the difference between the performance start decreasing. 


# Explore
## Compression
 - zlib
 - zstandard 