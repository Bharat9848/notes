# Glossary
- **Follower**
- **leader**

## rough
Raft  a node can be in follower, leader and candidate state

1. Leader election
All node starts in follower mode if they don't hear from Leader than they become candidate for leader then it ask other nodes votes. Majority candidate become leader.
All changes in the system goes through leader node.
- election timeout is a Random timelimit between 150-300 ms in which a node can become from follower state to candidate state.
- candidate send "Request Vote" message to other nodes
- in case of two candidates receiving equal vote election happens again 
- heartbeat timeout
- "Append message"
2. Log replication: an entry is added to leader log file. Then it got communicated to followers which in turn add entries in their log file. Follower send back acknowledge of log entry. Leader com
mit the change from entry and send committed notification to all followers. Followers do the same.

# References
 - [raft](https://raft.github.io/)

