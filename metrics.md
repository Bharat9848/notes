# Guidelines
- USE method: applies to hardware resources
  1. Utilization of a resource: 
    - How much percentage of time it was busy
  2. Error signal from the resource
  3. Saturation from the resource
    - how big the task queue for the resource

- The RED method: applies to services
  1. Rate: requests/sec
  2. Error: errors/total responses
  3. Duration: Duration of task completion/error
- The Golden signals
  1. Latency
  2. Errors
  3. Traffic
  4. Saturation
# Common metrics
## API calls
 1. Latency 
    - Client observed latency - Histogram
    - Server response latency - Histogram
    - Latency anomaly: to detect if latency falls outside a normal range.
    - Latency Breach: to detect if latency is going above average threshold
    - P99 Error build up: to detect if lot of requests are breaching p99 latency.      
 3. total requests - Counter

## Kafka
 - lags saturation
 

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
 - Resident memory
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
 