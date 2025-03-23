# Glossary
- Command: is user intention
- Event: is a fact emitted from various system
- state
- state machine
- CQRS pattern

## Snapshot
- its purpose is to speed up recovery and reads.

## Event sourcing
- user command -> validation -> event
- Application's current state is generated from event logs. It is deterministic.
- It is meant to capture the intent of the user. Hence event log compaction is not done.


## Log compaction
- it is opposite of principle of event logging which wants to capture the history of actions. Though it is required as system do not have infinite space and replaying become unmanageable.	