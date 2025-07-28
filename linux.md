## Questions
- How hypervisor or containers give the resource isolation ?

## Glossary
- `cpuset`: binds processes to set of processors. ???
- `process container`: group of processes with common parameters that are used by different subsystem
# Namespace
- ipc namespace
  - System V IPC identifiers ???
  - virtual filesystem in the implementation of POSIX message queues. 
- net namespace
  - separate network devices and port range for isolated set of processes.
  - packet filtering is easier due to separated network devices.
- pid namespace
  - PID namespaces also allow techniques such as freezing the processes in a container and then restoring them on another system while maintaining the same PIDs.
- mnt namespace
  - processes see isolated view of filesystem.
  - before mount namespace, `chroot` system call limits a process to see a part of filesystem. But other can see that part of filesystems. 
- uts namespace
 - isolate nodename and domainname
- user namespace
  - "Finally, the recent changes in the implementation of user namespaces are something of a game changer in terms of how namespaces can be used: starting with Linux 3.8, unprivileged processes can create user namespaces in which they have full privileges, which in turn allows any other type of namespace to be created inside a user namespace. " ???
  - creates userid which is visible to only set of processes.
  - user can be root inside the namespace but it will not have root privileges outside the namespace.
- syslog namespace
  - isolation of kernel logs.

# Control group
- logical grouping of processes for resource management.
- Each control group have set of controllers, that control the resource allocation to group processes.
- CPU controller mechanism make sure the minimum CPU allocation that will be allocated to processes. It also set an upper limit of CPU that can be used by cgroup. CPU scheduling is first done at a cgroup level then it happen across the processes in a cgroup.
- cgroup can be nested. Each hierarchy represents a different subsystem.
- cgroup subsystems:
    1. cpuset - assigns individual processor(s) and memory nodes to task(s) in a group;
    2. cpu - uses the scheduler to provide cgroup tasks access to the processor resources;
    3. cpuacct - generates reports about processor usage by a group;
    4. io - sets limit to read/write from/to block devices;
    5. memory - sets limit on memory usage by a task(s) from a group;
    6. devices - allows access to devices by a task(s) from a group;
    7. freezer - allows to suspend/resume for a task(s) from a group;
    8. net_cls - allows to mark network packets from task(s) from a group;
    9. net_prio - provides a way to dynamically set the priority of network traffic per network interface for a group;
    10. perf_event - provides access to perf events) to a group;
    11. hugetlb - activates support for huge pages for a group;
    12. pid - sets limit to number of processes in a group.
- `/proc/cgroup` file contains enteries for supported cgroup subsystem.
- `/sys/fs/cgroup/<subsystem>` each substem folder contains the files and required setting for each subsystem.
- `systemd-cgls`: systemd-cgls recursively shows the contents of the selected Linux control group hierarchy in a tree.  

## Package manager
- `apt-get install <software>`
- `apt-get remove --purge <software>`

## Httpd
## Iptables

`iptables -t nat -A PREROUTING -p tcp --dport 81 -j REDIRECT --to-port 80` redirect traffic received on port 81 to 80
## Inode
- File or Directory object is represented as inode data structure short for index node.
- inode contains information about file metadata like file permission, owner, last change etc. Additionally it contains disk block location of object data.
- Directory is a list of inodes with their associated names.
-

## Hypervisor
- Hypervisor is a software that emulates hardware access primitives which allows to create guest stack over it.
- Not very performant as it runs two kernel stack- host operating system and guest operating system.
- control system runs at hardware level.???

## Container
- container is group of technologies - cgroup, namespace, seccomp and capabilities.
- control system runs at shared operating system kernel level.
- Container uses shared operating system virtualization techniques instead of emulating hardware instructions.
- "In simplistic terms, OS virtualization means separating static resources (like memory or network interfaces) into pools, and dynamic resources (like I/O bandwidth or CPU time) into shares that are allotted to the virtual system."
- Beacuse of shared kernel resource efficiency is high as compared to hypervisor

## System calls
- mount()
- umount()

## Rough
- Modern CPUs recently started to support expanding virtualization instruction. ???
- POSIX RLIMIT 
 - "The namespace separation is applied as part of the clone() flagsand is inherited across forks. The big difference from chroot() is that namespaces tag resources and any tagged resources may disappear from the parent namespace altogether (although some namespaces, like PID and user are simply remappings of resources in the parent namespace)."
 - "However, in practice, the distinction between containers and virtual machines is more of a spectrum than a binary divide. Techniques common to one can be effectively applied to the other, such as using system call filtering with containers, or using seccomp sandboxing or user namespaces with virtual imachines."