# Common metrics
## API calls
 1. client observed latency - Histogram
 2. server response latency - Histogram 
 3. total requests - Counter
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

 