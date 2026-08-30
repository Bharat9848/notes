## NoSql

### NoSql Database types
1. Document Based: Mongo
2. Column based: HBase, hypertable, amazon redshift.
3. Key-value: Dynamo, redis, memcached, aerospike
4. graph based: neo4j


## Column based
- Usecases: Write-large number of small updates Read - read sequentially. 

## Key-value dbs
- easy to partition and horizontally scale.
- more suitable for user-session application.

## document DBs
- fast reterivals in JSON, XML and other format.

## Graph based dbs
- used for applications where entities have lots many-to-many relationships like social media, research based application etc.

## Concepts 
### Schema-On-Read
- There is an implicit schema because the application need some kind of structure but it is not enforced by the database. A more accurate term is schema-on-read(the structure of the data is implicit and only interpreted when data is read) , in contrast to schema on write (the traditional approach of relational database where schema is explicit and the database ensures all written conforms to all).
- Scheama on read advantages: 
 - Case1: There are many different type of objects and it is not practical to put each type of object in its own table. 
 - case2: The structue of data is determined by external systems over which you have no control and which may change at any time.


### NoSql schema designing
1. When to have multiple collections in nosql.
 - If the objects you are going to embed may be accessed in a isolated way (it makes sense to access it out of the document context) you have a reason for not embedding.
 - If the array with embedded objects may grow in an unbounded way, you have another reason for not embedding.Embedding one to many relationship on the one side can help in saving extra queries. But gain can quickly turn into lose if those objects are getting updated very frequently.

2. Three basic different schema design One-to-N relationship in NoSql:
  1. Embed the N side if the cardinality is **one-to-few** and there is no need to access the embedded object outside the context of the parent object.
  2. Use an array of references to the N-side objects if the cardinality is one-to-many or if the N-side objects can be queried independently of 1 side.
  3. Use a reference to the One-side in the N-side objects if the cardinality is one-to-squillions(large indefinte size)

### What to choose - sql or nosql

1. Nosql
  When to use : 
  - **Schema structure** If the data in your application has a document like structure(i.e. a tree with one to many relationships where typically the entire tree is loaded at once) then its probabily is good idea to use document model. However the relational technique of shreddig- splitting the document into multiple tables can lead to cumbersome schema and unnecessay complicated application code.
  - flexible and evolving schema.
  - **size** Suitable for big volume of data.
  - **Compliance** Suitable where eventual consistency can be tolerated.
  - JSON schema has better locality than the multi table schema.

  cons: 1. Many to one and Many to many relatioships are very weakly supported.. As projects get bigger they tend to have more usecases. And subobjects in a document are queried independently of the main object. As soon as these usecases start to have many-to-many and many-to-one queries. It does not fit well in Json schema. This leads to breaking of hierarchial model(JSON) to relational model. 
  2. querying a small piece of data from a big document will fetch the whole document.
  3. updation of document size form some update in  some field require rewritten of whole document again. information.

2. Sql
   when to use : 
   - **size** : RDBMS are at their best when performing intensive read/write operations on small or medium sized data sets.
        Need strong consistency.
   - **Compliance** : Usecases that require strict ACID compliance e.g. finance, Banking, ecommerce etc
   - **Schema structure** if the schema is consistent and does not change much. Also data size is limited. 
       
  cons:
        Does not scale well in horizontal scalability bcause of ACID rules
3. Graph based
 - For highly interconnected data the document model is awkward, the relational model is acceptable and graph model are most neutral.

### Famous Non sql Database
Cassandra: Records are sharded based on partition keys. Within same partition key records are sorted based on a key. 
BigTable: It combines multiple files in a single block to store on disk. And is very efficient in reading a small amount of data.
HDFS/GlusterFS: Distributed File storage system.Suggested for Video binary stroage

---
### storage
1. Sorted String Table
  1. Compactions
    - **Minor compaction**: finalize the Memtable and transform into SSTable and flushed to disk.
    - **Merging compaction**: merge few SSTables and Memtable to write a new SSTable
    - **Major compaction**: Merge all SSTables to write one single SSTable. It deletes all the enteries marked for deletion.
---

### Questions:
- how read and write can happen without interruption when compactions are happening.
- which type of columnar, rdbms, document and key-value based to use in which situation