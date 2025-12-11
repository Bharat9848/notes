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

# Retriever
- `index.as_retriever()`

# Response synthesizer
- A higher level class that do many RAG steps in single command.
- takes the user prompt and matched nodes as argument, then internally do prompt augmentation and calls llm with augmented prompt and returns the response.

# Query engine
- A higher level class that do many RAG steps in single command.
- Do all the steps of response synthesizer along with retrieving document from vector store. It only take user query as input and return the RAG response from llm.
