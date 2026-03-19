# Retrieval Augmented Generation

## RAG Usecases
Following are some of the usecases of RAG
- search the web for latest data. 
- query the database for internal private data. 
- help in grouding answer to prevent hallucination: relevant search is provided as a context to LLM alongwith user's question
- RAG helps with facts but doesn’t give the LLM memory across conversations or enable planning and automation.
- RAG to consume data from following resources
  - structured data sources like rdbms
  - unstructured data sources like pdf, images etc.
  - streaming data.
  

----

# Ingestion phase
- Metadata can help in giving storing source links.
- increasing vector dimension for richer semantic details.
- combination of metadata and embedding indexing
- parent/child document indexing: Vector store will store both parent and child embeddings. In case of broader question parent index will be fetched and for detail question child index will be fetched.
- hypothetical question indexing associated with the chunk 
- Compression techniques: 1. Quantization 2. Pruning
- check the embedding model used in LLM to encode user query. E.g. text-embedding-ada-002 is used by OpenAI model

#### embedding model
 - `word2vec`, `GLoVE`, `BERT` and `text-embedding-ada-002`, vertex ai embedding model, `OpenAiEmbeddingModel`. Tokenization: have encoding type `EncodingType.CL100K_BASE`
 - `auto-truncate` by vertex AI embedding model silently truncate document if tokens are more than embedding model context window.
  - `OpenAIEmbeddings`: not free.
  - `all-MiniLM-L6-v2` ?
  - [ONNX model](https://docs.spring.io/spring-ai/reference/api/embeddings/onnx.html)
  - Search optimized model [bge-large](https://huggingface.co/BAAI/bge-large-en-v1.5) [multilingual E5 large](https://huggingface.co/intfloat/multilingual-e5-large)
  - [embedding leaderboard](https://huggingface.co/spaces/mteb/leaderboard)

#### Chunking strategies  
1. text split strategy: 
  - chunk overlap: without chunk overlap chunks lose meaning around sentance boundry, chunk overlap allow chunks to overlap some part with each other. It is used along with fixed size chunking.
  - document hierarchy: Documents is break around paragraph, sentence. more accurate in semantic meaning.
2. token based chunking: "You can also chunk documents using tokens, determined by the generative model’s tokenizer, as a unit. Let’s say that you want to use Llama 3 as your generative model. You then first tokenize documents using Llama 3’s tokenizer. You can then split documents into chunks using tokens as the boundaries. Chunking by tokens makes it easier to work with downstream models. However, the downside of this approach is that if you switch to another generative model with a different tokenizer, you’d need to reindex your data." ??  
3. Semantic chunking: Each sentence is vectorized and consequtive sentences are checked for semantic similarity, if they are similar enough then they are part of same chunks otherwise different chunks.
4. Language based chunking: LLM are given task to intelligently break the document into semantically coherent subparts.
5. context aware chunking: It can be added over and above any kind of above strategies. It generates a summary of chunk and add it back as context.
6. Multi vector indexing: The key to these strategies is a two-layer chunk structure. The top layer includes synthesis chunks—the chunks fed into the LLM to generate answers. The lower layer consists of retrieval chunks, smaller segments that create precise embeddings for retrieving the synthesis chunks.
##### Refrences
- [strategies](https://www.pinecone.io/learn/chunking-strategies/)
--- 
# Pre Retrival phase

## Query preprocessing
1. **Question transformation**: Rephrasing a vague question can result in more efficient search. It requires an LLM to remove unnecessary details, use synonyms from the domain to better query matching and clear the ambiguity phrases.
2. Named entity recognition: takes the prompt before the retriever and extracts the entity metadata like person, books, date, company etc. Then use entity metadata can be used in enriching the prompt or can be used in metadata filtering.
3. Chat engine condensed context: 
  - Query reformulation: Follow up question based on references previous question/answer cannot be passed directly to RAG retriever, as it will be missing context from previous conversation. 
  - Previous chat history and current query is transformed into standalone question before fetching context from retrieval phase
```txt
Given the following conversation and a follow up question rephrase the follow up question to be a standalone question

Chat History
{chat_history}
Follow Up Input: {question}
Standalone question:
```  
  - refrences
    1. llamaindex [condense plus context mode](https://developers.llamaindex.ai/python/examples/chat_engine/chat_engine_condense_plus_context/)

4. Multi query retrieval/ **Question split**: queries can be break into multi queries that can run in parallel. Broad question may not result in pinpoint answer, breaking the question into sub-question might help in overall process of vector search and generation phase.

5. step back prompting: user query is transformed to a more general query.
  - reference: step back prompting

6. Query Routing:
  - in case of multiple routes - subagent or multiple datasources
  - llamaindex [intro](https://developers.llamaindex.ai/python/framework/module_guides/querying/router/)
  - langchain [intro](https://docs.langchain.com/oss/python/langchain/multi-agent/router)

---

# Retrival phase

- Shorter context are more efficient but they fail to answer broader questions. The longer the context, the more likely the model is to focus on the wrong part of the context.

### Search type

#### Semantic search:
-  User query is converted into query vector and then it was searched in relevant vector indexes.
- Similarity measure
    1. Which similarity measure to use: It is important to use the same metric on which the underlying foundational model has been trained. For example, in the case of the OpenAI GPT class of models, the distance function is cosine similarity.
    2. L2 Norm/Euclidean distance: good for spatial dataset.
    3. Cosine similarity: ideal for text as it is suitable to ignore doc length
    4. Dot product: recommendation system where degree and magnitude of vector both are important.
    5. Manhatten distance/ L1 norm:
    6. Hamming distance: used for categorical/binary data.

#### Multi-store routing/ Hybrid RAG
- Vector store can be supplemented with other store like relational databases, table or graph which are presided over LLM to help with individual technology syntax.
  1. Metadata filtering further filter out irrelevant search.
  2. Semantic search
    -- It uses ANN algorithm see ANN in machine learning notes
    - it is also called dense vector/ embedding search
  3. lexical/sparse vector search
    - also called term-based search and lexical search.
    - `fuzzy match` tries to gauge two sentences similarilty by measuring edit distance.
    - `N-gram match` strategy tries to gauge similarity by doing exact match by breaking sentences in N-gram.
    - keyword exact search
  - involves invocation of term based and embedding based search in parallel then using algorithm like [reciprocal rank fusion](https://oreil.ly/3xtwh) to calculate final score. It improves precision of the retriever phase. 

#### Search expansion
  - for broader question it is helpful to add smaller chunks with neighbouring sentences to provide broader context.
  - context enrichment:
    1. Sentence window retrieval: sentences are embedded and during retrieval matched sentence is expanded into k sentences above or below
    2. Parent child retriever: child chunks were searched upon. Parent chunks were fetched for retrieved child chunks before sending to LLM.

#### **Reranker**
  - It can be done using cross encoder or LLM.
  - **Cross-Encoder**
    - each document and prompt is given to an encoder which returns the matching score.
    - It is better result than normal BiEncoder but it is extermely slow as it requires linear calls to cross encoder.
    - It can be used in reranker as the number of potential matches from first search are not many.
  - After retrieving relevant documents, each document and user prompt is given to cross-encoder/LLM to give final score.
  - It is needed if the number of documents increasing the context length or decrease the number of input token.

- **Advanced Indexing**/**contextual indexing**: 
    - multiple embeddings for single document. 
    - additional keywords indexing

- Ensemble strategy to maximize precision
- Removal of inaccurate answer.
- Multimodel embedding model like [CLIP](https://arxiv.org/abs/2103.00020) is used when you have query as text but embedding data is a image.



#### Graph RAG
 - see paper notes kg-guided rag
 - steps
   1. node and relation extraction
      spacy
      LLM prompt
   2. Vector index building
      - triplet can be linearized and embed using same embedding model
      - Graph clustering summarization is linearized and store as embedding   
   3. Query preprocessing
      - plain query is transformed in triplets based Cypher query language through llm using Named Entity Recoginiton(NER) pipeline. 
   4. Querying 
      - simple query: how many hops to reach from the subject of the query
      - multi entities query: below flowchart for the process. and also limit the worst case scenario of repeat process to 3 (based on research every person is related to other through a path of length 6).
      ```mermaid
          flowchart TB
            Start --> id1{Direct relationship b/w main entities A and B?}
            id1 --yes--> Result
            id1 --"no"--> B[Find related entities of A and B using filter queries]
            B --> C{Related entities of A connected to related entities of B ?}
            C --yes--> Result
            C --"no"--> D[Repeat process using direct neighbour of A and B]
            D ---> Start
            Result --> End
      ``` 
      - result is subgraph which requires further size reduction
        1. select nodes that are on shortest path b/w interested parties
        2. apply graph pruing algorithm to reduce relations futher.
           - not to reduce number of short path.
           - maintain diversity in the result.  
    5. Graph text linearization
      - Pseudo documents are created using path linearization between entities.
      - collect most relevant entities from the graph linked to asked entities by using a filtered ES KNN approach.



#### Hypothetical question
 - index comprises of question based on chunks.
 - retriever compares user question with generated question vector.
 - Augmentation phase use the original text form the chunk

#### Hypothetical Domcument embedding(HyDE)
 - LLM generates an hypothetical document that will match the user query and then generated document is used as query to be searched in vector store.

#### Hierarchial index retrieval
- For many documents corpus usecases, it introduces summary index before the chunks index.
- large document are summarized and embedded into summarized index.
- first query is searched in search index and then from search index refrences all original chunks are retrieved.

#### Query expansion

----
# Post retrieval phase
- reranking,
- keywords
- date wise sorting
- metadata filtering

----
# Augumentation phase
- retrived content is augmented to user's original prompt.
- problems
  - disjointed and incohrent prompt
    - disordering of retrieved documents
    - stylic and tonal inconsistency
  - redundant similar information

----
# Generation phase
  - problems
    - mere repetition of retrieved documents without any insight or synthesis information
## Reference citations
  - input the source document url to context and ask LLM to cite the sources for used context.
  - Match the generate source to fuzzy match with retrieved context.
    - reference [intro](https://towardsdatascience.com/a-guide-on-how-to-build-a-fuzzy-search-algorithm-with-fuzzywuzzy-and-hmni-26855ce1818b/)
## Response synthesiser
  - call LLM with each context individually
  - summarize all the answer
  - refernce llamaindex [responseSynthesizer](https://developers.llamaindex.ai/python/framework/module_guides/querying/response_synthesizers/)
  
----
# vector databases
Embedding models: `word2vec`, `GLoVE`, `BERT` and `text-embedding-ada-002`.It is best suited for unstructured data. Some vector store needs schema initialization -???.

## Vector index
 - Dedicated vector dbs are different from DBs that support vector search. They use specialized data structures to store vector database.
    - reverse indexes
    - product quantization  
    - locality sensitive hashing
 - Hierarchial Navigable Small World(HNSW):Hierarchial graph with many layers. Upper layers are sparse once upper layer nodes are selected. Search is shifted to lower layer to refine the results. Tuning parameters: number of candidate to consider at 1st iteration of search. number of neighbor to consider while constructing the graph. number of docs to return. Distance metrics to be used for semantic searching.
 - index creation optimization can be done on two different strategies: 1. recall 2. latency

### Vector DBs / tools
 - "In general, vector databases organize vectors into buckets, trees, or graphs. Vector search algorithms differ based on the heuristics they use to increase the likelihood that similar vectors are close to each other. Vectors can also be quantized (reduced precision) or made sparse. The idea is that quantized and sparse vectors are less computationally intensive to work with."
 - search retrun theme
  1. `similarity`: return search without score
  2. `similarity_with_score`: return search results with score
  3. `mmr` Max Marginal Relevance: also checks diversity in documents. It balances the relevancy and remove similar sounded documents.
 - Distance metrics
   -- see machine learning maths notes
   - cosine similarity is used for NLP and sparse matrix calculation
   - dot products distance is used in Matrix factorization in recommendation system and neural networks activation
   - euclidean distance is used in geo indexes, computer vision and image analysis

#### References
 - `redisai` and `torchserve` are also in-memory databases
 - `milvus` : Image dense vector search. [link](https://milvus.io)
 - Google ScaNN: scalable [link](https://oreil.ly/faJqj)
 - spotify annoy: [link](https://github.com/spotify/annoy)
 - Qdrant : [link](https://qdrant.tech)
 - Chroma: [link](https://www.trychroma.com)
 - Weaviate: [link](https://weaviate.io)
 - Vald: [link](https://vald.vdaas.org)
 - Scann:Vector library[link](https://github.com/google-research/google-research/tree/master/scann)
 - KDB: Time series DB [link](https://kdb.ai)
 - Elastic Search: Search engine [link](https://www.elastic.co)
 - OpenSearch:Fork of ElasticSearch[link](https://opensearch.org)
 - PgVector: PostgresSQL extension [link](https://github.com/pgvector/pgvector)
 - MongoDB Atlas(MongoDB extension)[link](https://www.mongodb.com/ )
 - Paper [Local sensitive hashing](https://oreil.ly/slO9x) 
 - Hierarchical Navigable Small World [1](https://github.com/nmslib/hnswlib) [2](https://www.pinecone.io/learn/series/faiss/hnsw/) 
 - [product quantization](https://oreil.ly/VaLf4)
 - [Inverted file Index](https://oreil.ly/9BcYN)
 - [Approximate nearest neighbour oh yeah](https://github.com/spotify/annoy) 
 - [embedding model](https://github.com/UKPLab/sentence-transformers)
 - [massive text embedding benchmark](https://arxiv.org/abs/2210.07316)
 - influxdb/prometheus: store vectors against timestamps.
 - vector store sample [data](github.com/datastax-labs/colbert-wikipedia-data)
 - [nmslib](https://github.com/nmslib/nmslib) 


---
# FAISS
in-memory vector database, each embedding is associated with unique document identifier. Document is stored somewhere else.
 - supports IVF, FlatL2, LSH, HNSW algorithm.
 - single node or for local deployment.
 - No metadata support natively
 - Flat Index: brute force distance measuring between the query vector and other embedded vectors.
 - Inverted File Index: Centroid calculation using k-means forming Voroni cells, it is faster than flat index but less acurate.
 - Locality sensitive hashing: uses hash buckets to calculate nearest neighbors. It is usefull sparse data. it is faster and memory efficient. Search happens in the nearest buckets only.
 - HNSW: see machine learning notes for more details
 - Scaling, metadata support and multi node deployment limitation can be overcome by using Milvus with FAISS as storage engine.
 - [documentation](https://faiss.ai/)
 - [link](https://github.com/facebookresearch/faiss/wiki/). 
 - python package name `faiss-cpu`
---
# Milvus
- distributed production scale system.
- Hybrid search support
---
# chroma db
- runs in standalone mode where client and server runs in same process.
- alternatively it also runs in client-server architecture
- stores the whole document not just vector.
- supports full text search, vector search, metadata filtering and multi-modal retrieval
## Embedding functions
 - module `chromadb.utils` have `embedding_functions` which have lots of different types of embedding functions
   1. embedding_functions.SentenceTransformerEmbeddingFunction
## Chroma client operations
   1. create collection
   ```python
   chromadb.Client().create_collection(name="s", configuration={"hnsw":{...}, "embedding_function": "ef"}, metadata={"description": "", "owner": "", ...})
   ```
   2. get collection for already created collection
   ```python
   collection = chromadb.Client().get_collection(name="s")
   ``` 
## collection API
 - `modify` to update name,metadata and other configuration of your collection. Embedding function and distance metrics cannot be changed once the collection is created.
 
 - get/update/create/query operations take arguments/return data in columnar fashion. Each property of document is a column which is input/return as separate list. E.g. ids, documents etc.

 - `query()` used for semantic searching 
 `
 collection.query(
    query_texts=["cats"],
    n_results=10,
)`
 - `get()`: used for simple operation to do metadata filtering or lexical search. It returns the dictionary result in a columnar fashion e.g ids will give list of all the return ids, documents will be a list of all returned document text.
 - `delete()`
 - `add`: bulk api takes list of `documents`, list of `metadata`, list of `ids`
## Querying
 - `where_document` is an argument to collections' API query/get/delete method. It usually work with operators json like `$contains`/`$not_contains` to search words in document text.
 - `$contains`/`$not_contains` search keywords in the text.

 - `where` is an argument in various collections query/get/delete mehtod.It takes json like syntax definition. e.g. `collection.get(where={"key":"value"})`. It is used for querying metadata of the documents.
 - `$eq` - equal to (string, int, float)
 - `$ne` - not equal to (string, int, float)
 - `$gt` - greater than (int, float)
  - `$gte` - greater than or equal to (int, float)
  - `$lt` - less than (int, float)
  - `$lte` - less than or equal to (int, float)
  - `$and` is a list of smaller queries e.g. 
  ```json 
    "$and" : [
      {"key":  {"$eq": "valyee"}}, {"key2": "value2"}
    ]
  ```
  - `$in` and `$nin` are typical in and not-in operator they take a list as argument against a key field,
---

----

# elastic search

---

# Practice
- see nlp notes on spacy and nltk

# evaluation 
- see rag testing in ai-eval notes

---
# RAG system architecture
  1. 2-step RAG: Retrieval is called before calling LLM.
  2. Agentic RAG: LLM have the independence to call RAG or not or call RAG multiple times.
  3. Hybrid RAG:
  4. Multi document agent: Orchestrator pattern. each agent is sits on a document and its summary index. Main orchestrator agent calls subagent after evaluating user query
  5. Fine tuning
    - Encoder finetuning
    - Reranker finetuning
    - LLM finetuning
      1. [openai finetuning](https://developers.openai.com/api/docs/guides/model-optimization)
      2. [openai finetuning](https://developers.llamaindex.ai/python/examples/finetuning/openai_fine_tuning/)
      3. [RADIT](https://www.llamaindex.ai/blog/improving-rag-effectiveness-with-retrieval-augmented-dual-instruction-tuning-ra-dit-01e73116655d)
      4. RA-DIT paper

---
## Papers and books
- ARAGOG: Advanced RAG Output Grading
- llamaindex: OpenAiAgent class
- multi agent documentation [llamaindex](https://developers.llamaindex.ai/python/framework/understanding/agent/multi_agent/)


---
## Rough
- HotpotQA dataset
- Marginalization: Generator sum of probabilty of all the matching document to generate the answer
- Maximum inner product search: Retriever searches through all document using MIPS
- ColBERT ??

- **caches**  
  - Indexing Structured and Semi-Structured Data: Retrieving structured data (e.g., database tables or multimedia content) using unstructured queries requires specialized techniques. This can include generating embeddings for database rows, images, or even audio files.  

Advanced retrievers go beyond simple vector similarity search to provide more nuanced, context-aware information retrieval through:

    Semantic Understanding: Using embeddings for meaning and context
    Keyword Matching: Precise term-based search for exact specifications
    Hierarchical Context: Maintaining relationships between information levels
    Multi-Query Processing: Generating and combining results from multiple query variations
    Fusion Techniques: Intelligently combining results from different retrieval methods