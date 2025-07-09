## concept
- crawler trap: Infinte loops caused by calendar pages or dynamic urls.
- Crawler can help in other usecase like web page testing, site mirroring, copy infringments checks.

## Requirements
- crawl the entire web from seed urls.
- stores the content of the pages for search engine to index 
- provide search over the page content.
- Do validation like duplicate content should be removed.
- scheduling to redo the whole activity again to gain access to more latest data.

## Non functional requirement
- Scalable
- Fault tolerant
- Extensiblilty: system should be extensible to other type of format not just HTTP.
- Rate limiting: System should rate limit to respect the domain limit.
- performance

## Estimation
1. Base facts
  - Assume 5 billion pages world wide
  - Each page 2MB content
  - Assume 500 bytes per page metadata
2. storage requiement
  - `No Of pages * (page content + page metadata)`
3. upload bandwidth
  - Assume top 10 search result.
  - 1 billion search per day ~ 10000 rps
  - per search response = (10 * 500(per response object)) +50 bytes(static response headers)
4. download bandwidth
  - (total pages * (page content + page metadata))/(no of server)
5. server estimation
  ??? 
## API and schemas

## Flow diagram

## Component
   - Scheduler
   - DNS
   - Cache
   - Blob store
   - Extractor
   - Retriever
   - Dedup service
   
## Deep dive
- How to distribute seed urls
  - consistent hashing.

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

"