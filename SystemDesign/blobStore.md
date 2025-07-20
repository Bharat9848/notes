# Blob store
## Concept
- flat data heirarchy
- stores any kind of data like images, pictures
- no update is allowed. New versions can be uploaded.
- erasure encoding to achieve 99.999999% availablity
- Fault domain: A set of devices that can fail together.

## Requirement
- list data
- Create/Reterive/Delete container
- store the data
- reterieve the data
- data cleanup after configured expiry.
## Non functional requirements
- highly durable- no data loss
- highly available
- highly scalable
- highly fault tolerant.
- less costly and efficient
- security

## scale
1. server required
- qps = 5Mil user
- commodity server request handling capacity = 500rps
- No of server required 5mil/500 = 10K server
2. storage required
- video size = 50MB
- no of videos daily = 250000
- storage required = 250000 * 50MB = 12.5TB/day
3. Upload Bandwidth required
- 12.5 TB/day ~ 1.15 Gb/s
4. Download bandwidth required
- 5000000 user * 20 request/day * 50MB data download each session 
- 462 Gb/s

## API design
- `createContainer(name)` creates container, `deleteContainer(name)`, `listContainer(accountId)`
- `putBlob(container, path, data)` add data in specific location in a container.
- `getBlob(container, path)` returns the data
- `listBlob(container, path)` return the list of blob by matching file prefixes

## Services
1. API service: 
- stores the metadata about blob-chunks, container metadata and blob metadata.
returns the metadata 
2. Namespace/placement service
- divides the file in chunks and distribute
- public/private access previliage of blob
- monitors store nodes by keeping track of heartbeat.
- send request to replicas in case of master node failure.
3. store fleet with hard disk
4. maintainence fleet for background operations like replication and tiering.
- do garbage collection for data that was explicitly deleted.
- Also recover space for data which is expired. 
5. rate limiter: As blob services are cloud offering and multitenent, we need rate limiter to prevent user to go above set limits.
6. load balancer: guides user to nearest data center
7. monitoring service: sends alert on low data nodes etc to administrators

## workflows
- read a blob: 
 1. API server will call placement server
 2. placement server will fetches all the chunk locations from metadata db
 3. Send it back to API server
 4. placement server will send it back to the client.


## Deep dive
### Questions
1. how to store large blobs

2. monitor the health of data nodes
- disk replacement model can be developed and deployed data should be regularly copy from old data nodes to new data nodes.
- Monitoring of data should be done and data should be copied to new node in case of replica failures.

3. how replication is achieved 
- data should be replicated using synchronus replication within datacenter and using asynchronus replication for different data center and region.
- Placement service should make sure that data is replicated in differnet fault domains.
- storage cluster is a rack of nodes with redundant power and networking setup
- Data is replicated in same regions different datacenters and one copy in different regions datacenter.
- placement service should be kept in hot-hot primary-secondary configuration.

4. how scalability is achieved

5. how to achieve low read latencies.
- We can do streaming for large blob files
- Client can cache the chunks to data node mapping for files.
- Placement service can use metadata cache and partition maps.
- Use CDN for public blob files.

6. Streaming a large blob file.
7. how do you make blob storage efficient and cost friendly:   
8. how to keep blob store secure
- using AES encryption for data stored in disk.
- For data in transit we can use Http over ssl/tls to prevent man in the middle attack.
- Checksum function to check if data is altered with
- Access policies like public-private blob, RBAC policies.