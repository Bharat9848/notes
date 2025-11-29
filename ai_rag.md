# Retrieval Augmented Generation

## RAG Usecases
Following are some of the usecases of RAG
- search the web for latest data. 
- query the database for internal private data. 
- help in grouding answer to prevent hallucination: relevant search is provided as a context to LLM alongwith user's question
- RAG helps with facts but doesn’t give the LLM memory across conversations or enable planning and automation.

## vector store

### Ingestion phase
1. embedding functions
  - `OpenAIEmbeddings`: not free.
2. text split strategy: 
  - chunk overlap: without chunk overlap chunks lose meaning around sentance boundry, chunk overlap allow chunks to overlap some part with each other. It is used along with fixed size chunking.
  - document hierarchy: Documents is break around paragraph, sentence. more accurate in semantic meaning.
3. token based chunking: "You can also chunk documents using tokens, determined by the generative model’s tokenizer, as a unit. Let’s say that you want to use Llama 3 as your generative model. You then first tokenize documents using Llama 3’s tokenizer. You can then split documents into chunks using tokens as the boundaries. Chunking by tokens makes it easier to work with downstream models. However, the downside of this approach is that if you switch to another generative model with a different tokenizer, you’d need to reindex your data." ??  
4. Semantic chunking: Each sentence is vectorized and consequtive sentences are checked for semantic similarity, if they are similar enough then they are part of same chunks otherwise different chunks.
5. Language based chunking: LLM are given task to intelligently break the document into semantically coherent subparts.
6. context aware chunking: It can be added over and above any kind of above strategies. It generates a summary of chunk and add it back as context.
7. Multi vector indexing: The key to these strategies is a two-layer chunk structure. The top layer includes synthesis chunks—the chunks fed into the LLM to generate answers. The lower layer consists of retrieval chunks, smaller segments that create precise embeddings for retrieving the synthesis chunks.
8. medadata indexing
9. combination of metadata and embedding indexing
10. parent/child document indexing: Vector store will store both parent and child embeddings. In case of broader question parent index will be fetched and for detail question child index will be fetched.
11. hypothetical question indexing associated with the chunk 

## Retrieval phase
- **Question transformation**: Rephrasing a vague question can result in more efficient search. It requires an LLM to remove unnecessary details, use synonyms from the domain to better query matching and clear the ambiguity phrases
- Named entity recognition: takes the prompt before the retriever and extracts the entity metadata like person, books, date, company etc. entity metadata can be used in enriching the prompt or can be used in metadata filtering.
- Hypothetical Domcument embedding(HyDE): LLM generates an hypothetical document that will match the user query and then generated document is used as query to be searched in vector store.
- **Cross-Encoder**
  - each document and prompt is given to an encoder which returns the matching score.
  - It is better result than normal BiEncoder but it is extermely slow as it requires linear calls to cross encoder.
  - It can be used in reranker as the number of potential matches from first search are not many.
- ColBERT ??
- sparse vector search
  - also called term-based search and lexical search.
  - `fuzzy match` tries to gauge two sentences similarilty by measuring edit distance.
  - `N-gram match` strategy tries to gauge similarity by doing exact match by breaking sentences in N-gram.
  - keyword exact search

- Dense vector search
  - also called embedding-based search
  
- Hybrid search
  - involves invocation of term based and embedding based search in parallel then using algorithm like [reciprocal rank fusion](https://oreil.ly/3xtwh) to calculate final score. 
  
- search type
  1. `similarity`
  2. `similarity_with_score`
  3. `mmr` Max Marginal Relevance
  
- search expansion:
  - for broader question it is helpful to add smaller chunks with neighbouring sentences to provide broader context.
  
- **Reranker**
  - It can be done using cross encoder or LLM.
  - After retrieving relevant documents, each document and user prompt is given to cross-encoder/LLM to give final score.
  - It is needed if the number of documents increasing the context length or decrease the number of input token.

- **caches**  
  - Indexing Structured and Semi-Structured Data: Retrieving structured data (e.g., database tables or multimedia content) using unstructured queries requires specialized techniques. This can include generating embeddings for database rows, images, or even audio files.  

### Retriever performance
 - Context precision: Document retrieved from the search how relevant they are to query.
 - context recall: of all the documents that are relevant to query, how many of those are fetched
 - Mean Average Precision(MAP@K): sum of scores of relevant document only, divided by number of relevant documents.
 - Reciprocal rank measure the position of first relevant document and is calculated by `1/position`.
 - Mean Reciprocal Rank: average of many reciprocal ranks.

### Vector DBs / tools
 - "In general, vector databases organize vectors into buckets, trees, or graphs. Vector search algorithms differ based on the heuristics they use to increase the likelihood that similar vectors are close to each other. Vectors can also be quantized (reduced precision) or made sparse. The idea is that quantized and sparse vectors are less computationally intensive to work with."

#### References
 - `faiss`: in-memory vector database, each embedding is associated with unique document identifier. Document is stored somewhere else. [link](https://github.com/facebookresearch/faiss/wiki/). python package name `faiss-cpu`
)
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

## Advanced RAG techniques
- Shorter context are more efficient but they fail to answer broader questions. The longer the context, the more likely the model is to focus on the wrong part of the context.
- **Advanced Indexing**/**contextual indexing**: 
    - multiple embeddings for single document. 
    - additional keywords indexing
    - Metadata indexing can help in giving footlinks to the user.
- **Question split**: Broad question may not result in pinpoint answer, breaking the question into sub-question might help in overall process of vector search and generation phase.
- **Multi-store routing**: Vector store can be supplemented with other store like relational databases, table or graph which are presided over LLM to help with individual technology syntax.
- Ensemble strategy to maximize precision
- Removal of inaccurate answer.
- Multimodel embedding model like [CLIP](https://arxiv.org/abs/2103.00020) is used when you have query as text but embedding data is a image.

---

# Practical RAG

## RAG testing
 - check for relevancy when asked broader question
 - check for relevancy when asked specific question 
