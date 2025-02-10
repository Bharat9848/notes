# Requirement
- Ask about scale - 1,000,000 Transaction Per Sec
- Correctness by reproducability (auditing)

# Services
- API gateway -> wallet service -> zookeeper(user partitionInfo) 
                               -> sharded user RDBMs
- Best solution is event sourcing as events are saved to help us with reproducability.

  commandQueue -> state machine -> event queue -> RDBMS.

# APIs
- Post API - transferMoney(fromAcc, toAcc, amount, currency, transactionId)

# Details
1. how to do transactions across multiple RDBMS accounts.
- Distributed transaction - Two phase commit. --read from distributedSystem.md
- distributed transaction - Try-confirm/cancel

## optimization
- write to local sequential file instead of kafka
- cache the file using `mmap`
- use `rocksdb` to save the state locally
- use `snapshot` to save replaying of message for any new system that comes up.

## Rough
 - no of RDBMS nodes - support 1000/sec
 - currency datatype is String - for no precision lost.

