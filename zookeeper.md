# Zookeeper
## Usecases
- **Service discovery** Some nodes try to claim for a partition. Partition is given to nodes which claims first. This will keep single view of cluster. Routing tier subscribes to watch the path and get notified when cluster partition configuration changes.
- **coordination service**
- used for leader election and distributed locks.
- Provide linearizable writes??
- provide stale reads by default. For linearizable read we need to call `sync` before read.

## Path API
   - create path and save some value in against final key
   - read the value of path
   - delete the path
   - read children of path
   - path can be ephemeral and persistent

## Watcher API
   - notify a watcher on path or children of path

## replication
- zk node replicate its data.   

# Excercise
 - leader election and distributed lock through using Apache curator.