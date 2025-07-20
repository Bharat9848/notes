## Requirement
- user should be able to send message to other user.
- user should be able to receive message from other user.
- user should be able to send message on a group channel
- user should be able to receive message from a group channel.
- system should see acknowledgement from the service like deleivered, sent, read etc.
- System should support multi-format messages.
- System should buffer the messages until it is delivered.
- System should send push notification
## Non functional requirement
- latency: system should be able to send/receive messages with low latency
- consistency: system should send messages in the right order.
- Availablilty
- Scalability

## Estimation
1. Base facts
- Total users: 2 billion
- message exchanged: 100 billion
- Avg text message size: 100 Bytes
- Avg video message size: 30MB
- Avg image size: 200KB
- text to image ratio: 1/100
- text to video ratio: 1/1000

2. storage requiement
- storage per day: (100 * 10^9) * 100 bytes	
3. upload/download bandwidth
- 10TB/86400
4. server estimation

## API and schemas

## Flow diagram

## Component
- WebsocketServer
  - caches the other websocketserver information for recent chats.
  - First check its all list of users before checking websocketManager server for other user's websocket server information.
- WebsocketManager: Mapping of websocket server, port and user is stored in manager
- redis: WebsocketManager stores the data in a redis server.
- Mnesia database:
  - optimized for ever increasing data.
  - messages are stored in FIFO order
  - frequent delete operations.
  - Highly fault tolerant
  - complex objects and dynamic configuration.
- Message service: 
  - Manages the messages relaying when user is online.
  - Store the message in Mnesia database in case user is offline.
  - retrieve the messages from mnesia database when user come back online.
  - messages are deleted after 30 days. 
  - send message to kafka topic of a group in case of group chat message 
- Asset service  
- Group Message service
  - Maintains the group metadata information
  - Uses mysql DB to store the group information.
- Group Message handler
  - consumes message from kafka topic.
  - fetches the metadata of all users.
  - sends data to websocketservers of all the available group users.




## Deep dive
1. How is a communication channel created between clients and servers?
```mermaid
 A[user] ---> B[FrontLoadBalancer]
 B ---> C[WebsocketServer]
 C ---> D[WebsocketManager]
 D ----> E[redis]
``` 
2. How can the high-level design be scaled to support billions of users?
 
3. How is the user’s data stored?

4. How is the receiver identified to whom the message is delivered?

5. how media files are sent ?
- Files are uploaded to CDN if multiple request has been made for file
- content checksum is used to do deduplication.
```mermaid
A[user] --compressed,encrypted--> B[asset service]
B ----> C[blob]
C --HashId---> B
B --HashId-> A 
A --msg+hashId--> D[websocketServer]
D ---> E[websocketManager]
E --webSoketServerUserB--> D
D -----> F[WebsocketServerUserB]
F ---> G[user]
G --download---> B 
```
6. Group messages.
7. how data consistency and ordering is maintained 
- Sequencer is used to for ordering and it also preserve the casuality information.
- Mnesia db is used to store offline users message in a queue order.

## Rough
- " To support billions of users, WhatsApp’s system should be highly scalable and distributed. Use multiple WebSocket servers for connections, a Redis cluster for user mapping, a message service on a Mnesia database for messages, and a MySQL cluster with Redis caching for user/group data. Distribute components across servers and databases, with replication and caching to handle growth efficiently."