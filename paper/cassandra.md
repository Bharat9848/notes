# Cassandra
- Sloppy quorums
- Hinted handoff
- read repair and anti-entropy

- Strict quorums
  - Even strict quorum are not linearlizable.
  - Strict quorum with read repair synchronusly can achieve read linearizability
  - write quorum must read the latest state of quorum of nodes before sending writes to achieve linearizability.(?)