## Concept
- DocumentId: searchable documents assigned an Id for index.
- Fuzzy search: 
- inverted index
- document term matrix: each document is broke into terms and stored as matrix. Simplest document term matrix will store term as column and document will be row and each cell represent count. Advanced matrix have other meta information like documentId, count and location per term.

## Requirement
- search the system
- highly available 
- highly reliable/ fault tolerant
- low latency
- cost friendly

## estimates
1. server estimation
- 150 million user ~ 150 million requests/sec
- capacity of server 64000 requests/sec
- total server needed = 2343 servers

2. storage requirement
- 200 KB document
- 1000 term per document
- 100B per term storage
- total storage required per document = 200KB + 1000 * 100B = 300 KB
- number of document uploaded/day = 6000
- yearly storage requirement  = 6000 * 300 KB * 365 = 657GB

3. Inbound Bandwidth requirment
- total request/sec = 150,000,000/86400 = 1736.11
- 100 bytes request size 
- 1736* 100 bytes/sec = 1.39Mbs

4. Inbound bandwidth requirement
- total request/sec = 150,000,000/86400 = 1736.11
- 4000 bytes response size 
- 1736.11 * 4000 = 55.56 Mb/s

## Components
- Crawler
  - finds the new data and extract its searching context using various feilds e.g. for a video it can be captions, descripion, title, channels etc. Stores the searching context to a distributed storage in a JSON format.

- indexer:
  - Reads documents from a distributed storage. Creates a distributed index and again stores in distributed storage
  - do stemming

- search service
  - do spell correction etc.
  - Searchs the index for the search term.

## HLD
  - Onlne flow
    -  user --search---> cache(LRU) ---cachemiss--> search service ---> inverted Index lookup 
  - Offline flow
    - schedular ---> crawler ----> search new document db ---> distributed db
    - schedular ---> indexer ---> read new documents ---> inverted index geneartion ----> distributed db

## API design
- `search(query)`

## deep dives
- how indexer do indexing of documents at a very high scale.
  - Document partitioning:
    - **cluster manager** distribute search documents among the nodes of the cluster. 
    - Each nodes then index their own set of document and create inverted index and store it
    - Consequently search query is distributed to all the nodes. No merging of result is required for multi word queries but mapping list is sorted based on frequency or how strong is the match. 
  - Term partitioning
    - Each node is assigned term range e.g. a-b, c-d etc.
    - each node indexes all the search douments for the term-range assigned to it and create inverted index and store it.
    - It make easier to distribute load based on searched word. however multiword query will become difficult and require merging results from various documents. 

- How to make system highly available, reliable and fault tolerent.
 - Same documents partitions are assined to multiple availability zone nodes and each node will create duplicate inverted index and stores it. Alternatively one node can create inverted index and send it to other replica nodes
 - search and indexer can colocate on same node for faster latencies. Alternatively search and indexer will locate on different nodes. Each indexer node populates inverted index locally and upload it to a distributed database. While search service will download the index file. Alternative approach might have some delay before new search documents are onboarded.
 - If one nodes fails other can easily take over which makes the system available and fault tolerant.
 - Queries can further be load balanced among replicas. 



   