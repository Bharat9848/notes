## Summary
- Web crawler takes some seeds url and scale the whole web. Potential problem while doing these are as follow:
  1. How do you deal with content duplicity
  2. how to deal with url duplicity
  3. politeness: how to honour a domain crawl policy as defined by hosted `robot.txt`.
  4. politeness: how to honour sites rate limiting.
  5. how will you extend the crawler to accept more MIME protocol like ftp etc.
  6. how will you extend the crawler to accept more file formats like images, videos etc.
  7. how will you defend web crawler against crawler strategies.

## concept
- web crawler is also known as robot or spider.
- crawler trap: Infinte loops caused by calendar pages or dynamic urls.
- Crawler can help in other usecase like web archiving, web page testing, site mirroring, copy infringments checks.
- website hosts `robot.txt` to direct webcrawler. Below is sample of a robot.txt.

````
  User-Agent: GoogleBot
  Disallow: /creatorHub/*
  Disallow: gp/member/review
````

## interviewee questions
- Main purpose of web crawler 
- scale of number of pages.
- content format
- storage time limit for content.

## Requirements
- crawl the entire web from seed urls.
- stores the content of the pages for search engine to index 
- provide search over the page content.
- Do validation like duplicate content should be removed.
- scheduling to redo the whole activity again to gain access to more latest data.

## Non functional requirement
- Scalable: World Wide Web is too big so we need our system to be scalable.
- Fault tolerant: web is full of potential loophole and threats. Our system should be fault tolerant.
- Extensiblilty: system should be extensible to other type of format not just HTTP.
- Rate limiting/politeness: System should rate limit to respect the domain limit.
- performance:

## Estimation
1. Base facts
  - Assume 5 billion pages world wide
  - Each page 2MB content
  - Assume 500 bytes per page metadata
2. storage requiement
  - `No Of pages * (page content + page metadata) * year`
3. upload bandwidth
  - Assume top 10 search result.
  - 1 billion search per day ~ 10000 rps
  - per search response = (10 * 500(per response object)) +50 bytes(static response headers)
4. download bandwidth
  - (total pages * (page content + page metadata))/(no of server)
5. server estimation
  ??? 
## API and schemas
 - Admin APIs
   1. addSeedUrl(url, priorty, updateFreq)
 - RDBMS:
   (url, priority, updateFreq)
 - Priority Queue 
   (url, priority, updateFreq)
   updateFreq: how frequent crawler should crawl the page. It depends upon the page's nature.   

## Flow diagram
   ```mermaid
      flowchart LR
        subgraph
          url frontier
            Scheduler ---> database
            Scheduler ---> A[priorityQueue]
            
        A ---> B[Worker]
        B ---> C[Html retriever]
        C ---> D[DNS resolver]
        D ---> E[Content Parser]
        E ---> F[Deduplicator]
        F ---> G[LinkExtractor]
        G ---> B
        G ---> H[(url storage)]
   ```
### Initialization   
  ```mermaid
  ``` 

## Component
   - Scheduler/URL frontier
   - DNS
   - Cache
   - Blob store
   - Extractor: 
     - deassimilate content into subparts like image, content and urls.
     - stores the individual parts in a separate cache like redis temporarly
     - invoke deduplication service 
   - HTML Retriever
    - have the logic for crawler trap 
   - Dedup service
     - Deduplication service do deduplication on the bases of various algorithm like checksum etc.
     - sends the deduplicated data downstream to blob store for further usecases like indexing etc.
   
## Deep dive
1. How to distribute seed urls
  - Urls can be distributed according to geographical region as it will be very latency friendly.
  - consistent hashing.
  - Manually categorized into categories like sports,news etc.

2. How frontier mananges the urls priority.
  - Each url is assigned an update freq based on which it is enqueued again. Update freq is needed for urls where contents are regularly updated like news website.
  - Also each url is assigned a priority e.g. priority of a seed url would be more than normal extracted url. Priority can also be assigned by respecting `robot.txt` value.
  - Alternate solution would be to have different queues with different priority. Each url is placed in different queue based on different priority.

3. how webcrawler take care of politeness
  - popular graph traversal like DFS and BFS are not appropriate for webcrawler for webpages links graph. In case BFS it will choose all the urls from same domain and choking domain of other url and higher priority. In case of DFS it is proiortizing very deep urls which is not very efficient.
  - Forentier is designed as below diagram. All the urls from same domain are added to same domain queue. Urls are proitizes according to pagerank, website traffic, update freq etc, and queued in queues with highest priority queue possible.

  ```mermaid
      flowchart LR
         E[InputURL] --->F[priortizer]
         F ---> HighPriorityQueue1
         F ---> HighPriorityQueue2
         F ---> HighPriorityQueue3
         HighPriorityQueue1 ---> H[FrontQueueSelector]
         HighPriorityQueue2 ---> H
         HighPriorityQueue3 ---> H
         H ---> A[QueueRouter]
         A ---> B[(mapping table)]
         A ---> DomainQueue1
         A ---> DomainQueue2
         A ---> DomainQueue3
         DomainQueue1 ---> D[QueueSelector]
         DomainQueue2 ---> D
         DomainQueue3 ---> D
         D ----> Worker1
         D ----> Worker2 
  ```

4. Priority queue in URL frontier is distributed or centralized?
  - centralized queue is SPOC and not scale friendly. It will be very helpful deduplication
  - distributed queue can easily scalable and fault tolerant. Enqueuing can be url-hash based which will further helps in decreasing duplicity.  

## review design requirement
 - uses consistent hashing between url-forentier and workers.
## Rough
    "How would you design a web crawler system that can handle large datasets, and how would you incorporate Redis for caching and Amazon web services (AWS) for scalability?

    How would you handle request timeouts and manage rate limits set by websites?

    What optimization strategies would you use for components like parser, fetcher, etc., for large-scale use cases like those at FAANG?

    How metrics like response time, cache hit rate, etc., help evaluate web crawlers’ performance to crawl large datasets for aggregation."

    "DNS lookup strategy"

    "How do we select seed URLs for crawling.

    Location-based: We can have different seed URLs depending on the location of the crawler.
    Category-based: Depending on the type of content we need to crawl, we can have various sets of seed URLs.
    Popularity-based: This is the most popular approach. It combines both the aforementioned approaches. It groups the seed URLs based on hot topics in a specific area.

    Mostly, web crawler traps are the result of poor website structuring, such as:

    URLs with query parameters: These query parameters can hold an immense amount of values, all while generating a large number of useless web pages for a single domain: HTTP://www.abc.com?query.

    URLs with internal links: These links redirect in the same domain and can create an infinite cycle of redirection between the web pages of a single domain, making the crawler crawl the same content over and over again.

    URLs with infinite calendar pages: These have never-ending combinations of web pages based on the varying date values, and can create a large number of pointless web pages for a single domain.

    URLs for the dynamic content generation: These are query-based and can generate a massive number of web pages based on the dynamic content resulting from these queries. Such URLs might become a never-ending crawl on a single domain.

    URLs with repeated/cyclic directories: They form an indefinite loop of redirections. For example, HTTP://www.abc.com/first/second/first/second/....



"