## Supported data type
### SortedSet
- Unique set of items with an additional property on which items are sorted.
- operations
  - `ZADD(score, member)` Upsert a member
  - `ZINCBY(score, member)` increment score of a member
  - `ZRANK(member)` returns the rank of a member
  - `ZRANGE/ZREVRANGE` returns the sorted list of members with their sores
