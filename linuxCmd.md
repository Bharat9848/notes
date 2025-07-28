## commands
## Folders 
`/dev` is device folders.
## Files
-
### Process related commands
1. `pidof <name>` return the pid of given process.
  

## Network
1. Network namespace
  - `ip netns add <name>`
  - `ip netns list`
  - `ip netns exec <name> <command>` : runs given command inside the given name's network namespace.
2. Network interface  
  1. `ip link add <detail> ....`
    - To add virtual ethernet pair use the following `ip link add veth0 type veth peer name veth1` Veth0 is the name of the interface, it's type is virtual ethernet - `type veth`, create partner peer name veth1 - `peer name veth1`
  2. `ip link list` list down the network interfaces.
  3. `ip link set <interface> netns <name>` - changes the interface's network namespace.
  4. `ip addr add <ip/size> dev <name>` - assign a given IP address to device with given name. `/size` means the interface is part of a bigger network where other can be reached out by calculating ip range. e.g `10.0.1.1/24` can reach to others `10.0.1.2` or `10.0.1.4` etc.	
  5. `ip link set <interface> dev <up|down>` - brings the given interface name up or down.
  6. `ip route list` shows routing table.       	