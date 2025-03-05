# Namespace
- ipc namespace
- net namespace
- pid namespace
- mnt namespace
- uts namespace


## Package manager
- `apt-get install <software>`
- `apt-get remove --purge <software>`

## Httpd
## Iptables

`iptables -t nat -A PREROUTING -p tcp --dport 81 -j REDIRECT --to-port 80` redirect traffic received on port 81 to 80

