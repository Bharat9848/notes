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
  


### Ingestion phase
- Metadata can help in giving storing source links.
- increasing vector dimension for richer semantic details.
- combination of metadata and embedding indexing
- parent/child document indexing: Vector store will store both parent and child embeddings. In case of broader question parent index will be fetched and for detail question child index will be fetched.
- hypothetical question indexing associated with the chunk 
- Compression techniques: 1. Quantization 2. Pruning
- check the embedding model used in LLM to encode user query. E.g. text-embedding-ada-002 is used by OpenAI model
#### embedding functions
  - `OpenAIEmbeddings`: not free.

#### Chunking strategies  
1. text split strategy: 
  - chunk overlap: without chunk overlap chunks lose meaning around sentance boundry, chunk overlap allow chunks to overlap some part with each other. It is used along with fixed size chunking.
  - document hierarchy: Documents is break around paragraph, sentence. more accurate in semantic meaning.
2. token based chunking: "You can also chunk documents using tokens, determined by the generative model’s tokenizer, as a unit. Let’s say that you want to use Llama 3 as your generative model. You then first tokenize documents using Llama 3’s tokenizer. You can then split documents into chunks using tokens as the boundaries. Chunking by tokens makes it easier to work with downstream models. However, the downside of this approach is that if you switch to another generative model with a different tokenizer, you’d need to reindex your data." ??  
3. Semantic chunking: Each sentence is vectorized and consequtive sentences are checked for semantic similarity, if they are similar enough then they are part of same chunks otherwise different chunks.
4. Language based chunking: LLM are given task to intelligently break the document into semantically coherent subparts.
5. context aware chunking: It can be added over and above any kind of above strategies. It generates a summary of chunk and add it back as context.
6. Multi vector indexing: The key to these strategies is a two-layer chunk structure. The top layer includes synthesis chunks—the chunks fed into the LLM to generate answers. The lower layer consists of retrieval chunks, smaller segments that create precise embeddings for retrieving the synthesis chunks.

--- 
## Retrieval phase
- Shorter context are more efficient but they fail to answer broader questions. The longer the context, the more likely the model is to focus on the wrong part of the context.
### Search type
User query is converted into query vector and then it was searched in relevant indexes based on semantic, lexical or hybrid approaches. 
1. Metadata filtering further filter out irrelevant search.
2. Semantic search
  -- It uses ANN algorithm see ANN in machine learning notes
  - it is also called dense vector/ embedding search
3. lexical/sparse vector search
  - also called term-based search and lexical search.
  - `fuzzy match` tries to gauge two sentences similarilty by measuring edit distance.
  - `N-gram match` strategy tries to gauge similarity by doing exact match by breaking sentences in N-gram.
  - keyword exact search
4. hybrid search 
  - involves invocation of term based and embedding based search in parallel then using algorithm like [reciprocal rank fusion](https://oreil.ly/3xtwh) to calculate final score. 
### Similarity measure
1. Which similarity measure to use: It is important to use the same metric on which the underlying foundational model has been trained. For example, in the case of the OpenAI GPT class of models, the distance function is cosine similarity.
2. L2 Norm/Euclidean distance: good for spatial dataset.
3. Cosine similarity: ideal for text as it is suitable to ignore doc length
4. Dot product: recommendation system where degree and magnitude of vector both are important.
5. Manhatten distance/ L1 norm:
6. Hamming distance: used for categorical/binary data.

### Retrieval optimization
- Hypothetical Domcument embedding(HyDE): LLM generates an hypothetical document that will match the user query and then generated document is used as query to be searched in vector store.

#### Query preprocessing
1. **Question transformation**: Rephrasing a vague question can result in more efficient search. It requires an LLM to remove unnecessary details, use synonyms from the domain to better query matching and clear the ambiguity phrases.
2. Named entity recognition: takes the prompt before the retriever and extracts the entity metadata like person, books, date, company etc. entity metadata can be used in enriching the prompt or can be used in metadata filtering.

- **Search expansion:**
  - for broader question it is helpful to add smaller chunks with neighbouring sentences to provide broader context.

- **Reranker**
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

- **Question split**: Broad question may not result in pinpoint answer, breaking the question into sub-question might help in overall process of vector search and generation phase.
- **Multi-store routing**: Vector store can be supplemented with other store like relational databases, table or graph which are presided over LLM to help with individual technology syntax.
- Ensemble strategy to maximize precision
- Removal of inaccurate answer.
- Multimodel embedding model like [CLIP](https://arxiv.org/abs/2103.00020) is used when you have query as text but embedding data is a image.


### Retriever performance
 - Context precision: Document retrieved from the search how relevant they are to query.
 - context recall: of all the documents that are relevant to query, how many of those are fetched
 - Mean Average Precision(MAP@K): sum of scores of relevant document only, divided by number of relevant documents.
 - Reciprocal rank measure the position of first relevant document and is calculated by `1/position`.
 - Mean Reciprocal Rank: average of many reciprocal ranks.
 - map retrieval performance with different indexing algorithm like IVF, FlatL2, HNSW etc.

---

# vector store
It is best suited for unstructured data.

### Vector DBs / tools
 - "In general, vector databases organize vectors into buckets, trees, or graphs. Vector search algorithms differ based on the heuristics they use to increase the likelihood that similar vectors are close to each other. Vectors can also be quantized (reduced precision) or made sparse. The idea is that quantized and sparse vectors are less computationally intensive to work with."
 - search retrun theme
  1. `similarity`: return search without score
  2. `similarity_with_score`: return search results with score
  3. `mmr` Max Marginal Relevance: also checks diversity in documents 

#### References
 - `faiss`: in-memory vector database, each embedding is associated with unique document identifier. Document is stored somewhere else. [link](https://github.com/facebookresearch/faiss/wiki/). python package name `faiss-cpu`

 - `milvus` : Image dense vector search. [link](https://milvus.io)
 - Google ScaNN: scalable [link](https://oreil.ly/faJqj)
 - spotify annoy: [link](https://github.com/spotify/annoy)
 - Hnswlib: [link](https://github.com/nmslib/hnswlib)
 - `pinecone`: [link](https://github.com/facebookresearch/faiss/wiki/)
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
 - [Hierarchical Navigable Small World](https://github.com/nmslib/hnswlib)
 - [product quantization](https://oreil.ly/VaLf4)
 - [Inverted file Index](https://oreil.ly/9BcYN)
 - [Approximate nearest neighbour oh yeah](https://github.com/spotify/annoy) 
 - [embedding model](https://github.com/UKPLab/sentence-transformers)
 - [massive text embedding benchmark](https://arxiv.org/abs/2210.07316)


---

# Practice
- see nlp notes on spacy and nltk

---

## RAG testing
 - check for relevancy when asked broader question
 - check for relevancy when asked specific question 

---
## RAG system architecture
  1. 2-step RAG: Retrieval is called before calling LLM.
  2. Agentic RAG: LLM have the independence to call RAG or not or call RAG multiple times.
  3. Hybrid RAG:
---

## Rough
- Marginalization: Generator sum of probabilty of all the matching document to generate the answer
- Maximum inner product search: Retriever searches through all document using MIPS
- ColBERT ??

- **caches**  
  - Indexing Structured and Semi-Structured Data: Retrieving structured data (e.g., database tables or multimedia content) using unstructured queries requires specialized techniques. This can include generating embeddings for database rows, images, or even audio files.  