## Questions
- How hypervisor or containers give the resource isolation ?
# Namespace
- ipc namespace
- net namespace
  - separate network devices and port range for isolated set of processes.
  - packet filtering is easier due to separated network devices.
- pid namespace
- mnt namespace
  - processes see isolated view of filesystem.
  - before mount namespace, `chroot` system call limits a process to see a part of filesystem. But other can see that part of filesystems. 
- uts namespace
- user namespace
  - create userid which is visible to only set of processes.
  - user can have root privileges to isolated set of resources.

# Control group
- logical grouping of processes for resource management.
- Each control group have set of controllers
- CPU controller mechanism make sure the minimum CPU allocation that will be allocated to processes. It also set an upper limit of CPU that can be used by cgroup. CPU scheduling is first done at a cgroup level then it happen across the processes in a cgroup.
- cgroup can be nested.

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
- control system runs at shared operating system kernel level.
- Container uses shared operating system virtualization techniques instead of emulating hardware instructions.
- "In simplistic terms, OS virtualization means separating static resources (like memory or network interfaces) into pools, and dynamic resources (like I/O bandwidth or CPU time) into shares that are allotted to the virtual system."
- Beacuse of shared kernel resource efficiency is high as compared to hypervisor
## Rough
- Modern CPUs recently started to support expanding virtualization instruction. ???
- POSIX RLIMIT 
 - "The namespace separation is applied as part of the clone() flagsand is inherited across forks. The big difference from chroot() is that namespaces tag resources and any tagged resources may disappear from the parent namespace altogether (although some namespaces, like PID and user are simply remappings of resources in the parent namespace)."
 - "However, in practice, the distinction between containers and virtual machines is more of a spectrum than a binary divide. Techniques common to one can be effectively applied to the other, such as using system call filtering with containers, or using seccomp sandboxing or user namespaces with virtual imachines."