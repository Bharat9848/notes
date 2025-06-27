## Requirement
- shorten a long url to a tiny url
- cache the tiny url with a ttl, after which they will be marked expired
- redirect a tiny url to corresponding long url.

## Non functional requirement
- Availability
- Scalability
- Latency for url redirection should be within 100ms.
- security: next-in-line shorten url should not be guessable.

## Estimation
1. Base facts
- read to write ratio: 1:100
- total redirection traffic: 100 million active user/day
- shorten service: 200 million / month ~ 6 million/day 
- url shorten data per record: 500 bytes
- Default expiration period: 5 years

2. storage requiement
 - storage calls/month * month/year * default expiry * per record Bytes = 200 million / month * 12months * 5years * 500 Bytes = 6 TB	
3. upload bandwidth
 - daily QPS * Request size * 8 bits = 60 * 100 Bytes = 480Kb/s   
4. download bandwidth
 - 5(peak traffic) * daily read qps * request size * 8 bits = 5 * 1000 * 500 * 8 = 20Mb/s
  
5. server estimation

## API and schemas

## Flow diagram

## Component

## Deep dive