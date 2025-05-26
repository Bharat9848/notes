## Concepts
- Sorted Set implementation using hashmap and skiplist

## Requirement
- Update score of a user
- return top 10 users
- Rank of a particular user
## Non functional requirement
- scores should update in realtime.
- durability
- availability
- scalabilty
- reliability

## Data model
- leaderboard : userId, score, rank
- competition:  Id, name, start_date, end_date, status 
- user: Id, name, email etc,

## Components
- Client -> GameService -> leaderBoardService

## Apis
- `postScore(score, userId, competitionId)`

## Deep dive
1. How leaderboard maintains the rank data
   - On small scale it can be done through SQL table query with rowNumber can be used as rank for score sorted query.
   - for millions of user Redis sorted set solution.
2. Redis storage requirement.