# feature
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
- Term frequency: number of times a term occurs in a document. Square-root the frequency to dampen the effect of more occurance. Divison by document term count further normalize the effect of an longer document.
- Term importance: More number of document term appears in, less important the term is. IDF is a measure of it.
- Inverse document frequency(IDF): log of (total number of document/no of document which have the term).
- TF-IDF score of a document is sum of for each query term, term frequency for the term in the document multiplied by square of inverse term frequency.
### BM25 algorithm
 - It is TF-IDF score at its core but it factors in other factors as well.
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
- Semantic expansion: ocuments containing other words or concepts that are highly related to the query keywords and context should be boosted.


----

## Search engine
- domain understanding into their search capabilities, at which point organizations begin to invest in synonym lists, taxonomies, lists of known entities, and domain-specific business rules.
- understanding user intent, so they begin investing in techniques for query classification, semantic query parsing, knowledge graphs, personalization, and other attempts to correctly interpret user queries.
- Content based- Adjusting boosts, query parameters, and query functions; and otherwise trying to maximize the relevance of the traditional search experience.
- Signals-boosting algorithms create models that use aggregated signals to boost the rankings of the most important documents for your most popular queries.
- Collaborative filtering algorithms create models using matrix factorization or similar techniques that use signals to generate recommendations and user profiles to personalize search results for each user.
- Learning to rank algorithms train ranking classifiers to perform machine-learned ranking based on relevance judgments generated from user-signals-based click models. This process learns a set of features and ranking weights that can be applied generally to all queries—even ones that have not been previously seen.

### User understanding
 - click data or any interaction should be count as user feedback.

## Natural language processing
 - standard natural language processing techniques, like language detection, part-of-speech detection, phrase detection, and sentiment analysis to queries.

## Behavior based
## MultiModal search

## AI based Search
- Reflected intelligence is the idea of using continual feedback loops of user input, content updates, and user interactions with content to continually learn and improve the quality of your search application.

## Intent
- As a general rule of thumb, the more general a query, the more likely the user is just browsing. More specific queries—especially when they refer to specific items by name—often indicate a purchase intent or desire to find a particular known item.
- signal boost model: ML models are feedback and trained with most frequent/famous queries. It adds `popularized relevance` to the search.
- signals as sidecar collection query is searched in signal sidecar collection for product with `click` and `purchase` signal and counted. count will act as additional boost.
- `collaborative filtering`: using some user data detect other users behavior. Collaborative filtering approaches typically generate a user-item interaction matrix, mapping each user to each item (document), with the relationship strength between each user and item being based on the strength of the positive interactions (clicks, purchases, ratings, and so on).The user-item interaction matrix is too sparse, however, a matrix factorization approach will typically need to be applied.
- `learning to rank`: A machine learning model which ranks items. It applies to all item- new and old.
- Another signal for booasting is using content user reviews with sentiment analysis.
## Recommendation
- user-item recommendation
- item-item recommedation
- develop personal profile of user
- similarity between query and item. 
## questions 
- how to increase the weight of newer signals versus older signals
-  how to avoid malicious users trying to boost particular products in the search results by generating bogus signals, 
- how to introduce and blend signals from different sources, and so on.

## Embedding 
- For text- word embeddings, sentence embedding, paragraph embedding and document embedding.

## content
- Query intent classifiers

# Implementation
- **collection**
  - list of documents
  - provides `add_documents` method which indexes the documents. 
  - provides `search` method 


## Reference
- keyword search relevance by Doug Turnbull and John Berryman (Manning, 2016).
- Solr in Action by Trey Grainger and Timothy Potter
- [solr function reference](https://mng.bz/vJop)
- Relevant Search by Doug Turnbull and John Berryman