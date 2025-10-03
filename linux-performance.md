## Optimization
- `sendFile` API send data directly from disk to network buffer.
- `mmap` loads file directly in process virtual memory instead of loading it into RAM.


  # CPU
  perf record -F 99 -a -g -- sleep 10; perf report -n --stdio   # and flamegraphs
  execsnoop       # from perf-tools
  turbostat

  # Memory
  cat /proc/meminfo
  slabtop

  # Disk
  df -h
  iosnoop         # from perf-tools
  pidstat -d
  iotop

  # Networking
  netstat -s
  tcpdump
  tcpretrans      # from perf-tools

Where perf-tools is https://github.com/brendangregg/perf-tools.

lsof -c firefox
lsof -p pid
lsof -i tcp


## Tools
- strace
- tcpdump