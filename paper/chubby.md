## Chubby client
- maintain sessions with server and repeatedly renew it.
- client can register callback on server lock directories and files to stay consistent as soon as changes happen.

## chubby server
- Uses paxos algorithm for master election and stay updated among replicas
- Uses directory like mechanism to provide lock functionality.
## Requirement
- distributed lock service