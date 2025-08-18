## Partitioning
- Auto sharding: Data is partitioned once it reaches a configurable limit. 
- disadvantage is no of partition increased linearly with the data


mongod --storageEngine wiredtiger

db.serverStatus().extra_info
