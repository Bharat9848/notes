# Cassandra
## Partitioning
### Random token strategy
- Each node is assigned T random token.
- New nodes gets new T random token which splits the existing nodes token ranges. This would result in decrease of partition data size of existent one. 

## Rough
- Sloppy quorums
- Hinted handoff
- read repair and anti-entropy
- compaction: 
  - Level compaction
  - size tier compaction
- Strict quorums
  - what is strict quorum?
  - Even strict quorum are not linearlizable.
  - Strict quorum with read repair synchronusly can achieve read linearizability
  - write quorum must read the latest state of quorum of nodes before sending writes to achieve linearizability.(?)