## Latency numbers
Remeber following number in terms of O notation metrics. nsec, usec and msec are nanoseconds, microseconds and milliseconds respectively. Remember these numbers for latency estimation and thought framework.
1. L1 cache reference - 0.5 nsec ~ O(1) nsec
2. Branch mispredict - 5 nsec ~ O(10) nsec
3. L2 cache reference - 7 nsec ~ O(10) nsec
4. Mutex lock/unlock - 25 nsec ~ O(10) nsec
5. Main memory reference - 100 nsec ~ O(100) nsec
6. Compress 1K bytes with Zippy - 3,000 nsec ~ O(1) usec
7. Send 2K bytes over 1 Gbps network - 20,000 nsec ~ O(10) usec
8. Read 1 MB sequentially from memory - 250,000 nsec ~ O(100) usec
9. Round trip within same datacenter - 500,000 nsec ~ O(1) msec
10. Disk seek - 10,000,000 nsec ~ O(10) msec
11. Read 1 MB sequentially from disk - 20,000,000 nsec ~ O(10) msec
12. Send packet CA->Netherlands->CA - 150,000,000 nsec ~ O(100) msec

## Glossary
 - **Offered Load**: how many transactions per second a service can take and be responsive in acceptable limit of latency. Transactions rate above offered load can cause jitter in responses and increase in latency.
 - **Transaction**: A sizeable/logical piece of work.
 - Latency is a probability distribution. p99 value is the time which marks 99% of  transactions have less latency than the value.
 - for Batch software hardware utilization is more important than average latency. For transaction software average and P99 latencies matters. 
 - for Batch software 98% CPU usage is good whereas for trasactional software the 50% CPU usage is disaster as it leads to increase in latency whenever there is increase in load over offered load even for few seconds.
 - **Always slow transactions**: we need to determine transaction which are inherntly slow due to their nature.
 - it is also economical to have some non-user-facing batch programs to run when
there are otherwise idle processors.
- In datacenter  server also run supervisory programs alongwith user serving programs and batch programs. 
- For a set of parallel executions, the term **execution skew** describes the variation in completion times.
- **Thought framework**: the framework expects developer to do latency estimation for some system under test on some offered load then do reasoning for the fixes.

## System
- Simplistically one should plot actual offered load vs expected offered load for each subsystem in a request path with observed latency vs expected latency side by side.
- slow transactions hypothesis
  1. Branching structure of code is causing the extra delay. It can be measured running code offline with production load.
  2. Hindered transaction: if delay is not because of above reason, then it is due to some live enviroment thing that can only be measuered with very light observation tool.

## Microservice
- monitor process if its down e.g. no of pods
- Monitor resources for their health and anamolies - CPU usage, memory usage, disk and network usage
- monitor hardware component??, power consumption ??
- Monitor communication to essential service ???
- Monitor responsiveness to essential services - plot p99 of response time, other server error codes
- Intergrate and monitor cloud service using Cloud service providers provide a health status of their services:

    AWS: https://health.aws.amazon.com/health/status
    Azure: https://status.azure.com/en-us/status
    Google: https://status.cloud.google.com/

## Metrics
--see metrics.md

### software critical section
- lock protected data that will misbehave in case of lot of critical sections.

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