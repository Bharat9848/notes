# Zookeeper
- used for leader election and distributed locks.
- provide linearizable writes.
- provide stale reads by default. For linearizable read we need to call `sync` before read.


# Excercise
 - leader election and distributed lock through using Apache curator.