# Chunks
- chunks are called as node

# Document Loader
- `SimpleDirectoryReader`: support reading md, html, csv, txt, pdf, ppt format files. Provide flexibility to load all files and folder recursively or some specific files or load only some specific format files.
- `DatabaseReader`: queries a database using SQL
- `JSONReader`: to load json data
- `RSSReader`: loads RSS feed.

# Splitter
- `SentenceSplitter`: breaks the text recursively successively using a split string list till it reaches the specified limit. It works on token instead of characters.
- supports different type of NodeParsers
- `SemanticSplitterNodeParser`: split text into sentences if it falls beyond some semantic matching threshold.
- `LangChainNodeParser`: is a wrapper around langchain splitters.

# Vector Store
- `VectorStoreIndex`: is a abstraction to combine storage, nodes and embedding function
- `DocumentSummaryIndex`: generate and summarize the whole document. Chunking will lost the boarder meeting. Suitable for large documents. It returns the large document instead of summary. 
- `KeywordTableIndex`: extracts keywords and maps keywords to specific chunks of content. It enable exact keyword matching and used in rule or hybrid searches.

# Retriever
1. **VectorIndexRetriever**: uses semantic search to find the documents. Search type can be similarity threshold, MMR or simple similarity based.

2. BM25 retriever

3. Document summary Index retriever: uses summary to filter the query but returns the original document. Retrieving part can be llm based or embedding based.

4. Auto-merging retriever. it preserves context by breaking document in parent and child nodes. It retrieves parent node if enough child matches. It helps in broader questions.

5. Recursize retriever: use citation to follow the document chain

6. Query Fusion retriever: query multiple different retriever. Use reciprocal rank fusion or relative score fusion or distribution based fusion. 

7. `SentenceWindowNodeParser` stores adjacent sentences upto `windowsize` from above and below the current sentence. And store it in metadata `window`. 

# Response synthesizer
- A higher level class that do many RAG steps in single command.
- takes the user prompt and matched nodes as argument, then internally do prompt augmentation and calls llm with augmented prompt and returns the response. 

# Query engine
- A higher level class that do many RAG steps in single command.
- Do all the steps of response synthesizer along with retrieving document from vector store. It only take user query as input and return the RAG response from llm.

## Rough
Reciprocal Rank Fusion (RRF)

    Most robust fusion method - combines ranked lists using reciprocal of ranks
    Formula: RRF_score(d) = Σ (1 / (rank_i(d) + k)) where k≈60
    Best for: Default choice for most fusion scenarios, production systems

Relative Score Fusion

    Preserves score magnitudes while normalizing across query variations
    Formula: normalized_score = original_score / max_score
    Best for: When embedding model confidence scores are meaningful

Distribution-Based Score Fusion

    Most sophisticated - uses statistical properties of score distributions
    Methods: Z-score normalization, percentile ranking
    Best for: Complex queries with varying score distributions