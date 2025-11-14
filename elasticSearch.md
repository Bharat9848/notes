# features
 - exact/phrase match: query in double quotes
 - Some N term match:
 - Any term match
 - step function: Accepting a percentage or number of terms to match, those engines also support a step function 
 - Filtering 
   - query acts as filter as well as search query vector
   - additional metadata fields filtering criteria

## Apache solr

# Concepts
- fuzzy search
- N-Gram search
- lexical search
- semantic search
- inverted index: Data structure that powers lexical search
- Approximate Nearest Neighbor
- signals: Any user interaction: searches, clicks, likes, add-to-cart, purchases, comments etc.
- Extractive question answering: To return the result from the document in form of question answer and prevent user from clicking the document.
- keywords, entities, concepts, misspellings, synonyms, acronyms, initialisms, ambiguous terms, explicit and implied relationships between concepts, hierarchical relationships usually found in taxonomies, higher-level relationships usually found in ontologies, and specific instances of entity relationships usually found in comprehensive knowledge graphs.
- Natural language understanding
- polysemy: same word but different meaning 
- Term: character sequence that have a meaning.
- Term sequences: term sequence that is not necessarily sequential.
- Phrase: is a term sequence where term appear sequentially e.g. house wife
- Field: searchable category
- stemming or lemmatization
- Distributional semantic: semantic relationship between term and phrase based on an assumption that words that occur in similar context tend to share similar meaning.
- reduced-dimension dense embedding: instead of putting every term as a separate index. terms are categorized into more abstract categories to capture more semantics.
- entity resolution
- ontology: a mapping of relationship between types of things like animal eats food.
- taxonomy: categorize the term in generic categories like human is mammal etc. 
- synonym lists: replcaces term with their synonyme like human with mankind, food with meal etc. 
- knowledge graphs: An instantiation of an ontology that also contain the things that are related.
- alternative labels: replaces term sequence with identical meaning. Acronym expansion, misspelling, alternative spelling. like specialize and specialise, CTO and Chief Technology officer.
- One key difference between alternative labels and more general synonyms is that alternative labels can be seen as replacement terms for the original, whereas synonyms are more often used as expansion terms to add alongside the original.
----
# Usecases
- spell check
- autosuggest
- faceting
- text highlighting
- embedding 
----

# percolator 



----
# Search

## matching
- This phase is only for performance optimization to reduce the search space.


## Relevance
- different relevancy functions can be configured as per the query 
- see similarity score in ml maths notes
- cosine similarity does not measure the term freq into account hence dot product should be used.

### BM2.5 algorithm
- Term frequency: number of times a term occurs in a document. Square-root the frequency to dampen the effect of more occurance. Divison by document term count further normalize the effect of an longer document.
- Term importance: More number of document term appears in, less important the term is. IDF is a measure of it. **Inverse document frequency(IDF)**: log of (total number of document/no of document which have the term) measure term importance.
- TF-IDF score of a document is sum of for each query term, term frequency for the term in the document multiplied by square of inverse term frequency.
 - BM2.5 is TF-IDF score at its core but it factors in other factors as well.
 - The TF for each term is calculated as `freq(t, d) / (freq(t, d) + k · (1 – b + b · |d| / avgdl))` where k and b are free parameter k in range of 1.2 to 2.0 and b is set around 0.75. TF saturation point is controlled by k, making additional matches on the same term count less as k is increased, and by b, which controls the level of document length normalization more as it increases.
 - IDF is calculated as `log((N-Nt+0.5)/Nt+0.5+1)` where N is total number of documents and Nt is count of documents with the term.

## Relevance functions
- Each query is subdivided into subqueries and with their own relevance function as opposed to vanilla BM25 function. Many of the other relevance-boosting techniques require constructing custom `features` using `function queries`. Then each `feature` score is added (called additive boost) to get the total score. In multiplicative boost we can muliply some feature score to give extra weightage. 
- Geospatial boosting: Documents near the user running the query should rank higher.
- Date boosting:Newer documents should get a higher relevance boost.
- Popularity boosting: More popular documents should get a higher relevance boost.
- Field boosting:Terms matching in certain fields should get a higher weight than in other fields.
- Category boosting: Documents in categories related to query terms should get a higher relevance boost.
- Phrase boosting: Documents matching multi-term phrases in the query should rank higher than those only matching the words separately.
- Semantic expansion: Documents containing other words or concepts that are highly related to the query keywords and context should be boosted.

### Signal boosting
- user signal schema
  ````
     query-id ## system generated id, it helps in corelating query and click
     target ## for click it will doc that is clicked. For query it will be query string. for query result it will be documents id. 
     query-type ## enum <Click|query|purchase|query-result|add-to-cart>
     user-id
     signal-time
  ````
- Head queries: Popular queries that derive most of the traffic and lead to more click/purchase.
- We can use useful user signal click, add_to_cart, seen_doc_signal, purchase. These signal provide different weightage to the boost as they are stronger intent. 
- We can also use negative signals- skip, remove-from-cart, returned item, negative review comment etc, we can put negative weightage to them based on the relative significance of their intent.
- We may want to add decaying factor to weightage of various signal, depending on domain like news article where time-decay is more relevant or ecommerce website where time-decay is not relevant.
- Data preparation
1. Normalization of user signal dataset: It is crucial to normalize the query as same query can occur in different variations, otherwise it will distills the effect of signals. Stemming and lowercaseing query to make it case insensitive are some of the normalization technique.  
2. SPAM-correction: Count multiple clicks by same user as single click.
- signal-boosting can be applied at query time or index time.

----

## Search engine
- domain understanding into their search capabilities, at which point organizations begin to invest in synonym lists, taxonomies, lists of known entities, and domain-specific business rules.
- understanding user intent, so they begin investing in techniques for query classification, semantic query parsing, knowledge graphs, personalization, and other attempts to correctly interpret user queries.
- Content based- Adjusting boosts, query parameters, and query functions; and otherwise trying to maximize the relevance of the traditional search experience.
- Signals-boosting algorithms create models that use aggregated signals to boost the rankings of the most important documents for your most popular queries.

- Learning to rank algorithms train ranking classifiers to perform machine-learned ranking based on relevance judgments generated from user-signals-based click models. This process learns a set of features and ranking weights that can be applied generally to all queries—even ones that have not been previously seen.
- **Boolean parsing**: search engines are configured on how to interpret multi word queries with either `AND` or `OR` operator.
### User understanding
 - click data or any interaction should be count as user feedback.



----


# Natural language processing
 - standard natural language processing techniques, like language detection, part-of-speech detection, phrase detection, and sentiment analysis to queries.
- `open information extraction`: extracts facts directly from the raw data.
- `hyponym`: are entities that maintains a simple `is-a` relationship with more general entities called `hypernym`.
- `statistical relationship`: `is-related-to` relationship.
- `pointwise mutual information`: predicts two words occurring together than independent.
  `pmi^2(k1,k2) = log(p(k1,k2)^2/(p(k1)*P(k2)))` 
 

## References
- Marti Hearst in “Automatic Acquisition of Hyponyms from Large Text Corpora”


----


# Semanic Knowledge graph(SKG)
- find any arbitrary but semantic related entities from the query entities.
- `traverse` allows query t
- we can build SKG through `open information extraction` technique
- schema
  1. `surface form`: actual keyword in the wild
  2. `cannonical form`: cannonical word for the surface form based on popularity of keyword.
  3. `type`: `semantic function|color|brand|place|event`. 
    - symantic function: location_distance for keywords near, in etc
    - symantic function: text_within_one_distance for misspelled words.
  4. `popularity`: extra weightage based on popularity. It can be based on signal boosting based on user context. Or it can be based on number of times term found in documenting. Or it can be basis of term meaning like cities population for location canonical term etc.
  5. `semantic_function`

````
relatedness(x,fg,bg) = (abs(interesect(Dx, Dfg))- abs(Dfg)*Px)/sqrt(abs(Dfg)*Px*(1-Px))
Px = intersect(Dbg,Dx)/Dbg
Dfg = forground set of docs that are matching fg query
Dx = set of docs that are matching x query
Dbg = set of docs that match bg query. bg query should be uncorrelated with x and fg and is usually set to match the entire collection of documents or a random sample from D
````
## Usage
- **Query expansion**: also called sparse lexical expansion. SPLADE: sparse lexical and expansion model. Query terms are expanded into semantic similar term and then can be used various ways to boost ranking or increase precision or increase recall.

- **Generating content-based recommendations**: in the absence of user signals we can use SKG to generate content based recommendation. We will rate documents other term compared to documents similar theme. It will give more nauanced information about the document.

- **query classification**: use SKG to find the category with the highest relatedness to my starting node if documents have associated category with it. Then the category is put as an additional filter or as a boost.
- entity detection in query

- domain specific phrases from the queries: Remove query syntax and obtain tokens and then apply domain specific techniques.

- domain specific phrases from the documents:
  - use spaCy NLP library to do a dependency parse and extract out noun phrases.
- query disambiguation: 
- anomaly detection, 
- data cleansing 
- predictive analytics.

### Misspelling and alternative representations(Altermative labels):
  - less common variant should be normalized to more common variant and then done the processing
  - User signals are mined to tune spell correction.
  - Apache solr provides spelling correction based on file, index and dictionary based.
  - sophisticated spell checking allow context based on the category or geography based.
  - spell check runs when none of the index terms matches the query.
  - plain spell check lacks user and domain context. E.g in computer gadges domain `moden` is spell-checked to `modes`, `model` and `modern` but it will not match to `modem` which is more appropriate to domain.
  - finding alternative labels and spell-check are two parallel activities.
  - number of occurance is proxy to find the misspelled/less common term than the correctly-spelled/most common term. The most quantile(0.8) freq items are the one should be corrected list. And the last quantile(0.2) freq items should be misspelled keywords.
  - If you wanted to generate multiterm spelling corrections from documents, you could generate bigrams and trigrams to perform chained Bayesian analysis on probabilities of consecutive terms occurring

### Learning phrases from queries
  - It will help in finding **spelling variation** keywords like (laptop,laptops), **Brand association** pair like (tablet, ipad), **synonym names** like (notebook, laptop) and **category expansion** pair like (tablet, computers) 
  1. Using only query data 
    - if someone do search within short span of time then it is reasonable to assume that current query is refinement of previous query. 
    - calculate co-occurance - We use queries like how often a user do separate queries for a given keywords pair.
    - calculate PMI - predicts the likelihood the two keyword occur together
    - calculate `comp score` by combining PMI and cooccurance model together with formula ((r1(q1,q2) + r2(q1,q2))/(r1(q1,q2)* r2(q1,q2)))/2
  2. Using combination of user query and click data.
    - If two different queries lead to same document getting clicked then we can assume keywords from both the query are related.
    - calculate comp score with PMI and co-occurance model
  3. high popularity queries are entities in themseleves that can be used as phrases. Futher we can remove false positives by searching the phrases in the document itself. Queries can be matched against different field to indicate the entities that are in query.  

## Tools
- apache Solr SKG capabilities
## Reference
- Grainger, et al., “The Semantic Knowledge Graph: A compact, auto-generated model for real-time traversal and ranking of any relationship within a domain.” 


----
# Semantic search pipeline
1. parse the user query
2. Add more context to the query
3. Transforming the query by adding boost for appropriate relevance
4. search using transformed query

## General
- If query does not match any document it is good to fall on recommendation as fallback.

## Query Parsing
1. entity extraction: keywords are searched in knowledge graph to identify terms and phrases. Also search in alternative spelling, misspelled collection.each keyword is matched to a canonical form e.g top,popular,best and good are matched to canonical form popular. It maps misspelling, acronyms, initliaslism, ambiguous terms, and specific intepretaion of term.
2. Boolean parsing: useful for lexical search
3. Query embedding: useful in dense vector search

## Query expansion 
- adding crowdsourced relevance
- or using knowledge graph to find query categorization.
- or using knowledge graph to find related terms.
- or find synonym, alternative spelling 
- embeddings

## Relevance boosting
1. signal boosting

## Searching
1. Lexical search
2. Knowledge graph search
3. Dense vector search
4. fallback to recommendation if none matches

## ReRanking
1. rerank the search result from the various matches.
2. Using machine-learning model
----



## Intent
- As a general rule of thumb, the more general a query, the more likely the user is just browsing. More specific queries—especially when they refer to specific items by name—often indicate a purchase intent or desire to find a particular known item.
- signal boost model: ML models are feedback and trained with most frequent/famous queries. It adds `popularized relevance` to the search.
- signals as sidecar collection query is searched in signal sidecar collection for product with `click` and `purchase` signal and counted. count will act as additional boost.

- `learning to rank`: A machine learning model which ranks items. It applies to all item- new and old.
- Another signal for booasting is using content user reviews with sentiment analysis.
- We can use click/query signal to find all the variations of a term spelling etc using techniques like PMI and co-occurance model from NLP. If query signal is too sparse and noisy. we can use click signal to more quality of data.

### User understanding
- popularized user query search using signal boosting model.
- specific user interests, user location, user history
- collaborative recommendation
### Domain understanding
- learn domain from content using SKG,
### content understanding

----

## Recommendation

- develop personal profile of user
- similarity between query and item. 
### Content-based recommender:
1. user-item recommendation
- recommendation options exposed to user. 
- item and item from user profile/history are intersected and returned in the result.
2. item-item recommendation
- applicable more on product details page where similar product related to page's product is recommended. We can leverage knowledge graph to search page's product attributes and details.
3. user-users recommendation
### Behvior-based recommender:
#### Collaborative Filtering
- It uses some users data to detect other users based on behavior similarity. Collaborative filtering approaches typically generate a user-item interaction matrix, mapping each user to each item (document), with the relationship strength between each user and item being based on the strength of the positive interactions (clicks, purchases, ratings, and so on).
- The user-item interaction matrix is too sparse, however, a matrix factorization approach will typically need to be applied. After breaking user-item interaction matrix into two - User matrix represents user interests and item matrix represents item similarity.
- User matrix and item matrix from matrix factorization can be used to find user-user and item-to-item similarity respectively. 
- recommendation is given by multiplying generating user matrix for all the users and items and then choosing the items which were not interacted by user and have predicted high score.
- suffers from cold-start problem where item do not have much user signal.

### Multimodel recommender
- it combines both content and behavior based recommendation. Content based recommendation helps in cold-start problem in behavior based recommendation and when signals are enough collaborative filtering takes precedence.
- users will see items from content based and behaviour based recommendations.
----

## questions 
- how to increase the weight of newer signals versus older signals
-  how to avoid malicious users trying to boost particular products in the search results by generating bogus signals, 
- how to introduce and blend signals from different sources, and so on.

----
## Embedding 
- For text- word embeddings, sentence embedding, paragraph embedding and document embedding.

## content
- Query intent classifiers

## Behavior based
## MultiModal search

## AI based Search
- Reflected intelligence is the idea of using continual feedback loops of user input, content updates, and user interactions with content to continually learn and improve the quality of your search application.


# Implementation
- **collection**
  - list of documents
  - provides `add_documents` method which indexes the documents. 
  - provides `search` method 
- **Finite state transducer**: helps in matching query keywords with list of known entities from knowledge graph. FST helps in returning results within millisecs.
- text tagger ?


## Reference
- keyword search relevance by Doug Turnbull and John Berryman (Manning, 2016).
- Solr in Action by Trey Grainger and Timothy Potter
- [solr function reference](https://mng.bz/vJop)
- Relevant Search by Doug Turnbull and John Berryman