## Concept
1. Base-64 encoding- Maps 0-63 quotient to `A-Z,a-Z,0-9,+,/` character set. It is not readable as compared to Base-58 encoding which gets rid of confusing character like (`l` and `I`) pair and (`0` and `O`) pair and also `+` and `\` characters.  

## Requirement
- shorten a long url to a tiny url.
- cache the tiny url with a ttl, after which they will be marked expired
- redirect a tiny url to corresponding long url.
- Minimum length of 6 alphanumeric characters
- custom Urls for premium customer.

## Non functional requirement
- Availability
- Scalability
- **Latency** for url redirection should be within 100ms.
- **Unpredictability**: next-in-line shorten url should not be guessable.
- **Readability**: Short url should be good for readability and should use only alphanumeric letters.

## Estimation
1. Base facts
- read to write ratio: 100:1
- total redirection traffic: 100 million active user/day
- shorten service: 200 million / month ~ 6 million/day 
- url shorten data per record: 500 bytes
- Default expiration period: 5 years

2. storage requiement
 - storage calls/month * month/year * default expiry * per record Bytes = 200 million / month * 12months * 5years * 500 Bytes = 6 TB for 5 years	
3. upload bandwidth
 - daily QPS * Request size * 8 bits = 60 * 100 Bytes = 480Kb/s   
4. download bandwidth
 - 5(peak traffic) * daily read qps * request size * 8 bits = 5 * 1000 * 500 * 8 = 20Mb/s
  
5. server estimation
 - RequestPer Sec per server = 65000
 - Daily qps ~1000
 - server needed = 65000/1000 = 65

## API and schemas
 - Shorten Post API(api_key, LongUrl, [ttl],[customAlias])
 - redirectUrl(apiKey, shortUrl) 
   - Response can be used with Http status - 301

 - deleteUrl(apiKey, shortUrl)
 
### SQL or NoSql ?
 - It requires read heavy but less data storage. MongoDB or SQL both are winner
 - each row would be self sufficient and requires no additional join. MongoDB or SQL both are winner
 - Scaling with sharding. Mongodb is the winner

## Flow diagram
1. shortenUrl
 ```mermaid
 user[A] -> LB[B]
 B -> ShortenService[C]
 C -> Mongo DB
 ``` 
 2. 
## Component
## Deep dive
- how shorten service works
  - Service will call sequencer which returns 64 bit ids. We can use further Base-58 encoder to encode the ID. Then make a database entry.
- how base-58 encoder works  
- how to avoid duplicate request
- how to avoid collision in short url in case of customAlias
## Evaluation
1. Scalability: We will employ consistent hashing to distribute data from application layer to database layer.
2. Readability: We use base-58 encoding instead of base-64 encoding
## Rough
"Since we’re using the 10 digits and beyond sequencer IDs, is there a way we can use the sequencer IDs shorter than 10 digits?
Hide Answer

We can use the range below the ten digits sequencer IDs for custom short links for users with premium memberships. It will ensure two benefits:

    Utilization of the blocked range of IDs
    Less than six characters short URLs

Example: Let’s assume that the user requests abc as a custom short URL, and it’s available in our system, as there is no instance in the data store matching with this short URL. We need to perform the following two operations:

    Assign this short URL to the requested long URL and store this record in the datastore.
    Mark the associated unique ID unusable. To find the associated unique ID, we need to decode abc into base-10. Using the above decode method, we come up with the base-10 unique ID value as 113019. The unique ID is less than 1 Billion, as the custom short URL is less than six characters, conforming to the above-stated two benefits.

    Our system doesn’t ensure a guaranteed custom short link generation, as some other premium member might have claimed the requested custom short URL.

"