## Requirement
- User want to delete/read/save/update documents.
- User want to invite other user to collaborate on his document.
- user can snapshot his document.
- user share read only copy of his/her documents.
- system should be able to do conflict resolution.
- System should show the presence of other user cursor position currently editing the same document.
- system should be able to count the number of viewer of a document.
- system should be able to maintain the history of document.
- system should help the user to complete words with suggestion like autocomplete. Also highlights grammatical erros  and help user to fix it.
- User can comment on some part of document.

## Non functional requirement
- Latency should be low while collaborating and editing the document.
- consistency: Each user should see consistent view of the document.
- Availability:
- Scalability:

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
  - revision entity(documentUrl, revisionId)
  - collaboratorPermission entity
  - comments entity 
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

## Components
  1. time series database to store edit history
  2. sqldb for storing user and document related information.
  3. Nosql db for storing comments
  4. blob store for storing actual documents.
  5. Redis db to store user session, autocomplete suggestions and frequently access system.
  6. CDN to store frequently accessed document, videos and images. 
  7. websocket to communicate through user where each update is send through a message including video, photo etc.
  8. session server ???
  9. Document service: 
    - expose CRUD operations API on documents
    - Manages document metadata as well.
    - send data downstream to document cache, metadata and blobstore.
  10. Revision Service:
    - Manages the revision history and version control of documents.
    - store and reterieves document revision
    - perform diff operation.   
  11. Other services like Notification service, Access control service etc.
    
## Deep dive
 1. How does collaboration work in your design and conflict resolution happens.
    - Each user will have their local copy and send the operations to the server.
 	- Concurrency resolution should have following properties
 	  - Idempotency:
 	  - commutative:
 	- Following agorithm can be used  
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

 2. How document history is maintained
 3. How does view counter works

## Evaluations
 - consistency:

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

## Resources
- [educative] (https://www.educative.io/courses/grokking-the-system-design-interview/evaluation-of-google-docs-design)
- book - System design for software developer

