## Requirement
- top K suggestion based on user typed prefix
- in corporate user behvior in feedback system
- store new search queries

## Non functional requirement
- Low Latency: response time should be within 200ms
- scalability
- Availability

## Estimation
1. Base facts
- 3.5 billions searches per day.
- 2 billions unique searches out of 3.5 billion.
- 15 characters per user types.
- 2 byte per character
- 10 suggestions per response.
- 15 character per suggestion.
2. storage requiement
- per day data storage = no of unique searches * no of character * bytes per character = `(2 * 10^9)* 15* 2`
3. upload bandwidth
- backend data chruning = per day data storage/86400 sec per day
- Request upload bandwidth = (user typed character)* (no of searches/sec) = (15 * 2 bytes * 3.5 billion)/86400
4. download bandwidth
- response sent bandwidth = request upload bandwith * 10 
5. server estimation
- no of user/request per sec capacity of a server

## API and schemas
1. addToSearch(searchString)
2. getSuggestions(searchString)

## Flow diagram
 ```mermaid
 user[A] ---> LoadBalancer[B]
 B ---> Assembler[C]
 B ---> SuggestionService[D]
 C ---> E[redis service]
 D ---> E
 C ---> F[Nosql]
 D ---> F
 ```
## Component
- Assembler: store new searches and do analysis and rank the searches and store it in databases.
- Search service: returns top K result for search query

## Deep dive
- How would you design a typeahead suggestion system that is capable of learning from user behavior—how would you incorporate real-time data processing and feedback loops?
  1. We will log the feedback loop data and used it to create new trie in next iteration.
  2. we will update the frequency of searched term as it is searched.
  
- How does load balancer placement and configuration impact the typeahead system performance and user experience?

- How would you efficiently update sub-tree structures in a typeahead system to accommodate new data ingestion from various sources, such as web crawlers, etc.?
  1. We can update the tree in an offline setup. We can employ map-reduce jobs to update the trie. Mapper job will read the new data log after every 15 minute. Then it will be partitioned and get updated in hash table frequency map. After the reduce part of the MR job we will create a new tree offline by copy the old one. once the update is complete, we can mark the new one as latest and delete the old one. We can mark the job update complete.
  2. While updating the tree to new one, we can delete some enteries for which there are no searches happening for quite some time.

- How to take care of misspelled and incomplete words
  - Using edit distance like Levenshtein helps find close matches. Filtering by context or common phrases adds relevance. 
  - to optimize it for real time update we can use caching frequently misspelled words to speed things up with balancing cache size and hit rate is key.
  
- Client side optimization that will help overall system.
  - client should call the api only in case user have not typed anything after few words. It will be wasteful in case user is typing fast.
  - client can cache some history of suggestions
  - client can estabilish conection without waiting for user to type something.
  - client can connect to CDP/IXP or even ISP which caches some of the search suggestions.

## Evaluation
 - Latency friendly:
   - we optimize the trie to keep its depth low
   - update the trie in offline path.
   - we can use geographically distributed application to make our trie local search relevant.
   - we can use redis to cache terms it will sit over trie.
   - partition can be repartitioned in case the words count of a trie goes beyond a threshold range.
 - Fault tolerance
   - we can save the trie in a backup filesystem or mongo in case of server restart.
   - each trie partition is replicated to some redundant servers.



## Rough
- How to make our suggestion system multi-lingual
  We will separate data store for each language. We can recognize the language choosen using UI or character encoding.  frequency-based ranking might vary significantly between languages, so maintaining separate ranking systems per language could improve relevance.???

- How to prevent integer overflow while updating the frequency of terms.
  1. once a number reaches some threshold we will not update the frequecy and consider it max frequency.
  2. "When you've normalized frequencies to a range (like 0-1,000), you have a few approaches for updating them:


## Maintaining the Normalization Range

**Proportional Updates**: When adding new occurrences, increment the normalized value proportionally. For example, if your original frequency was 50 and normalized to 100 (in a 0-1,000 range), and you want to add 5 more occurrences, you'd add 10 to the normalized value (maintaining the same ratio).

**Re-normalization on Updates**: Keep track of both the original raw frequency and the normalized value. When updating:
1. Update the raw frequency first
2. Recalculate the normalization mapping
3. Update all normalized values accordingly

## Threshold-Based Approach

If you're using the threshold method mentioned in your selection, you can:

**Capped Updates**: Once a prefix reaches the threshold (say 1,000), stop incrementing it entirely. This keeps frequently used prefixes at the top without overflow issues.

**Sliding Window**: Instead of pure accumulation, use a time-based or count-based sliding window. Recent activity gets full weight, while older activity gradually decreases.

## Hybrid Approach

**Logarithmic Scaling**: Use a logarithmic scale for updates, so early increments have more impact than later ones. This naturally creates a ceiling effect while still allowing some differentiation between very popular items.

**Decay Factor**: Apply a small decay factor to all frequencies periodically, then add new occurrences. This prevents old popular items from becoming permanently stuck at the top.

The choice depends on whether you need to maintain relative rankings exactly or if you're okay with some approximation for the sake of computational efficiency."

