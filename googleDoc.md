## Concepts
  - Conflict resolution should have following properties
    - Idempotency:
    - commutative:
  - Document revisions
    - store only the delta part instead of full document.
    - store only N number of revisions.
    - apply compression. 

1. **Operational transformation** 
    - It is defacto technique to resolve conflicts. It is lock-free and non-blocking.
    - It uses positional index along with change and send it to server. It holds commutativity and idempotency.
    - Rough "Collaborative editors based on OT are consistent if they have the following two properties:    Causality preservation: If operation a happened before operation b, then operation a is executed before operation b.Convergence: All document replicas at different clients will eventually be identical.The research community has proposed various consistency models over the years. Some of them are specific to collaborative editing, while others are specific to OT algorithms. The key consistency models are the following: CC model: As we defined above, this includes causality preservation and convergence. CCI model: This includes causality preservation, convergence, and intention preservation.Other models include the CSM (causality, single-operation effects, and multi-operation effects) model and the CA (causality and admissibility) model.Various consistency models are suggested, and usually, the newer ones are supersets of the earlier ones. Because there are so many proposed algorithms, discussing them is beyond the scope of our lesson. Interested readers can find more details here."
    - Disadvantage: operations are order dependent means If two user on different speed internet then operation from each will be differently received.

  2. Conflict-free Replicated Data Type     
      - CRDT is order independent
      - it also have commutativity and idempotency.
      - It assigns globally unique identity to each character.???
      - it globally orders each character ????
  3. document section locking
      - user will take a lock for editing
      - user will lock only a section of a documents.
      - More suitable for document like sheets.

## Requirement
- User want to delete/read/save/update documents.
- User want to invite other user to collaborate on his document with conflict resolution.
- user can snapshot his document.
- user should be able to share documents in read-only/edit/comment-only mode.
- System should show the presence of other user cursor position currently editing the same document.
- system should be able to count the number of viewer of a document.
- system should be able to maintain the history of document.
- system should help the user to complete words with suggestion like autocomplete. Also highlights grammatical errors and help user to fix it.
- User can comment on some part of document.

## Non functional requirement
- Latency should be low while collaborating and editing the document.
- consistency: 
  - Each user should see consistent view of the document.
  - Strong consistency where conflict resolution is resolved in real time.
- Availability:
- Scalability:
  - large number of user able to store and manage their documents.
  - increase collaboration.

## Estimation
1. Base facts
- 80 million active users
- 20 users should be able to edit document concurrently.
- text document should be 100KB
- user see 5 document per day
- user create one document a day
- 30% documents contain images and each image size is 500KB
- 3% documents contain videos and avg video size is 3MB
2. storage requiement
- size required per day: ((80 * 10^6) * 1 document * 100 KB) + (80 * 10^6) * 1 document * 100 KB * 0.30) + (80 * 10^6) * 1 document * 100 KB * 0.03)
3. upload bandwidth
- size required per day /86400 secs) * 8
4. download bandwidth
- document viewed = 5 doc * 80 million
- size of each document = 100KB
- total downloaded = document viewed * size of document /86400 * 8 
5. server estimation
- requests per sec = no of active user = 80 million
- requests per sec for each server = 64000
- total servers = (80 * 10^6) / 64000

## API and schemas
1. Metadata database 
  - User entity
  - document entity(latestRevisionId)
  - revision entity(documentUrl, revisionId, commitUserID, commitTime)
  - collaboratorPermission entity
  - comments entity(content, userId, documentId, createTime)
  - folder and folderDocument entity

## Flow diagram
### HLD
   ```mermaid
   A[client] ---> B[LoadBalancer]
   B ----> C[API Gateway]
   C ----> D[DocumentService]
   C ----> E[CollaborationService]
   C ----> F[RevisionService]
   C ----> G[AccessControlService]
   C ----> H[NotificationService]
   C -----> I[WebsocketServer]
   D -----> J[MetaDataDB]
   D ----> K[BlobStore]
   F ----> J
   F ----> K
   G ----> J
   ```
### Document creation flow
```<TBD>```
### Document retrieval flow
```<TBD>```
### Document update flow
```<TBD>```

## Components
### Databases
  1. **Time series database** to store edit history
  2. **Sqldb** for storing user and document related information.
  3. **Nosql db** 
    - For storing comments.
    - **P.S. document revision and content temporarily till it is asynchronously presisted in a new version of the document**
    - Collaboration session data
      - UserSession(collaborationId, userId, documentId, userChangesList)
      - documentData(baseRevisionId, deltaChangesList)  
  4. blob store
    - storing actual documents.
    - do chunking to support large files and parallelize uploads
    - storing images and videos
### API gateway
  - rate limiting
  - request routing to various services
  - authentication
###  CDN and Cache
  1. CDN to store frequently accessed document, videos and images. 
  2. Redis db to store user session, autocomplete suggestions and frequently access data.
### websocket server 
  - communicate through user where each update is send through a message including video, photo etc.
### collaboration service:
  - real time collaboration on document like sending cursor position to collaborator
  - do conflict resoultion with techniques like operational transformation
### Document service: 
  - expose CRUD operations API on documents
  - Manages document metadata as well.
  - send data downstream to document cache, metadata and blobstore.
  - Notifies colloaboration service about concurrent access.
  - Receives update event from collaboration service
### Revision Service:
  - Manages the revision history and version control of documents.
  - store and reterieves document revision
  - perform diff operation.   
### Other services like Notification service, Access control service etc.


## Deep dive
 1. How does collaboration work in your design and where conflict resolution happens.
    - Each client will starts the collaborate call.
    - After validation like write permission it fetches current state.
    - it starts/update a collaborative session and maintain some state in distributed db.
    - collaboration service returns the document 
    - client opens up a websocket with server. 
    - Each user will have their local copy and send the operations to the websoket server.
    - websocket server sends the event to collaboration service
    - collaboration service apply convergence algorithm
    - apply the transformed event and save it in a distributed cache.
    - broadcast the event to other collaborators using websocket service.
 	
 2. How document history is maintained
 3. How does view counter works
 4. how does you scale websocket server
    - consistent hashing to bind some document users to fall on same server.
 5. How the presence of other user and cursor information is being communicated to a other user.
    - current cursor information can be piggyback on the websocket events.
    - Or it can be a separate API call to collaboration service.
    - Collaboration service will send the notification to other users through websocket server.

## Evaluations
 - consistency:
 - scalability:
   - documentId ranges sharding for metadata
 - low latency: 
   - CDN for frequently access documents.
   - server side caching of metadata
   - **P.S.** local client caching by leveraging browser's IndexDB and localstorage. It helps in decreasing server load, offline support, resiliance in case of network outage and improve responsiveness.

## Rough
 - client holds following pieces of information
   1. lastest revision received from server
   2. local modification that are not sent to server
   3. local modifications that are sent to server but acknowledgment is not yet received.
   4. the current state of the document that is visible in the editior????
 - server maintains following information.
   1. modification received but not processed.
   2. complete history of changes made to the document.
   3. current committed state of the document.   
 - Operations queue to needed before collaboration service ????
 - 
## Resources
- [educative] (https://www.educative.io/courses/grokking-the-system-design-interview/evaluation-of-google-docs-design)
- book - System design for software developer

