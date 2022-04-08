## NoSql
### NoSql Database types
1. Document Based 
2. Column based 
	Usecases: Write-large number of small updates Read - read sequentially. 
	Example: HBase

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

Notes : For highly interconnected data the document model is awkward, the relational model is acceptable and graph model are most neutral.

There is an implicit schema because the application need some kind of structure but it is not enforced by the database. A more accurate term is schema-on-read(the structure of the data is implicit and only interpreted when data is read) , in contrast to schema on write (the traditional approach of relational database where schema is explicit and the database ensures all written conforms to all).

Scheama on read advantages:
Case1: there are many different type of objects and it is not practical to put each type of object in its own table.
case2:The structue of data is determined by external systems over which you have no control and which may change at any time.

### Famous Non sql Database
Cassandra: Records are sharded based on partition keys. Within same partition key records are sorted based on a key. 
BigTable: It combines multiple files in a single block to store on disk. And is very efficient in reading a small amount of data.
HDFS/GlusterFS: Distributed File storage system.Suggested for Video binary stroage

### Bloom filter
- It gives definite answer in case a particular key is not present and it may give false positive in which case key might also not be present.
- Given N bits of master set then each key is passed to K hash functions, each function will return a bit position which is then set to mark the presence of the key.  

### CAP theorem 
It states that any networked shared-data system can have at most two of three desirable properties:
1. Consistency - Every node will serve the latest copy of the data.
2. High Availability - Any non failing node will replies to the request in a certain amount of time
3. Partition Tolerance - System will continue to function even in case of network partition.

As a consequence of CAP theoren in practice, we categorized distributed system following ways  : 
1.CA system: Since this particular system needs to be consistent, therefore in case of network partition the whole system will stopped working as all the nodes need to serve latest data. It is not a coherent design for any distributed application. e.g. RDBMS

2. CP system: This particular kind of system is very similar to CA system but in the case of network partition node will retry indefinitely(loosing Availiblity - read definition) until client times out. e.g. Big tabl, HBASE

3. AP system: These system will continue to serve stale data in case of network partition without comprimising availability. But system will not be consistent. e.g Cassandra, Mongo etc. AP system is also called BASE mean Basically Available Soft-state and Eventually Consistent.

Extension to CAP theorem is PACELC theorem where PAC is from cap theorem which says in case Partition(P) system can choose either Availibility(A) or Consistency(C). And ELC means in case of no Parition (E) system can choose either Latency(L) or Consistency(C). ??? 