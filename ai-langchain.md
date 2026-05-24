 # LangChain 
  - python package `langchain`
   - Rough
   "You start by pulling in text from different sources—files, databases, or websites—and wrapping it into Document objects. Those documents are often split into smaller chunks so they’re easier to handle. Next, each chunk is passed through an embedding model, which turns the text into vectors that capture its meaning. Both the raw chunks and their embeddings are stored in a vector store, which lets you quickly retrieve the most relevant pieces of text based on similarity search. When an LLM app runs a task—say summarization or semantic search—it builds a prompt that combines the user’s question with extra context. That context usually comes from document chunks pulled out of a vector store. Sometimes, though, you’ll also want to bring in information from a graph database. Vector stores are still the backbone of most retrieval-augmented generation (RAG) workflows, but graph databases are becoming more common in apps that need to represent and reason about relationships between entities."
   "With loaders, splitters, embeddings, retrievers, vector store retrievers, and prompt templates, you can focus on application logic instead of boilerplate. The LangChain Expression Language (LCEL) and the Runnable interface then let you chain these pieces together consistently, making pipelines easier to build, debug, and maintain."

   "Additionally, LangChain supports a Fake LLM for unit testing purposes."
   "nowledge Graph databases: Although not a key component of the architecture, LangChain offers client wrappers for leading graph databases to facilitate Knowledge Graph functionality. These databases store entities and their relationships in a graph form."
   "Prompts (6): LangChain provides tools for defining prompt templates"
   "Chain: A composite arrangement guiding LangChain's processing workflow, customized for specific use cases and based on a sequence of the described components.
Agent: This component manages a dynamic workflow, extending a sequential chain."
  - `ChatMessageHistory`: saves only the question using `add_user_message(str)` method and llm response as `add_ai_message(str)`  
---
## LangGraph
### StateGraph API
  - It is stateful, persistent agentic workflow with state saved in graph based execution.
  - Node represents a individual task of the process like calling an API etc. Node are represented with explicit node name which is bound to a python function name through graph API. Uses `StateGraph.add_node`
  - Edge defines the path between the tasks. Simple edge are defined through graph API with first node name as source and second node name as destination. Conditional edges are defined through a python function which returns the alternate node name based on some condition. See `StateGraph.add_edge`
  - State is information that moves between the nodes. It is strongly typed using `TypedDict` from `typing` module.
  - branching edges makes llm take decision dynamically based on the previous state.
  - cyclical workflows makes refinement of work possible.
  - Node types:
    1. Model node - calls an llm
    2. tools node - calls an tool
    3. middleware node: override some aspects of requests
  - Entrypoint to the graph is decided to be some node. see `StateGraph.set_entry_point`
  - `Command` class automatically route with `update` state and next node to `goto`.
### Agent API
 1. `create_react_agent`: to define individual ReAct pattern based agent.
 2. `create_supervisor_agent` : to define supervisor agent which orchestrate complex flow over multiple other agents. Internally it define graph API.
 
---  
 ## LangSmith
  - Tracing feature: Hub provides the templates prompt for most usecases
  - Evaluation: 
    - relevance
    - correctness
    - sensitivity
  - Also provides dataset from various sources for continous and regression testing
 
---
## Lang Chain Expression Language
  - `pipe` operator : syntatic sugar for `RunnableSequence`
  - `Runnable`: all components which are subclasses `Runnable` interface can be part of chain. e.g  `BaseModel` `StrOutputParser`
  - `RunnableLambda` 
  - `BaseModel`
  - `RunnableParallel`: for running parallel task. Takes dictionary of variables mapped to different function like {var1: RunnablePassthrough(), contextVar2: some_custom_fn }. `assign` function
  - `RunnableSequential`: for sequencing runnable task. 
  - If pipes is used in dictionary like structure LangChain Expression language (LCEL) convert each key's values to parallel tasks.
  - function automatically get wrapped with `RunnableLambda`
  - provides async support, parallel execution, simpilfied straming, automatic tracing.
  - RunnablePassthrough
---


## Packages and Classes
  - agent `invoke` api: take context object as an argument.
  - static `create_agent` function:
    - take context schema as an argument
  
  - `@wrap_tool_call`: similar to advisor in spring-ai
  - `@dynamic_prompt`
  - `@before-model`
  - `@after-model`
  - langchain.tools
    1. `@tool` description  
    2. `Tool` class to create tool specify name, function and description.
    
  - langchain.agents
    1. `AgentExecutor` similar to ChatClient in spring ai
    2. `create_react_agent`
  - langchain.vectorstores
    1. Chroma
    2. `InMemoryVectorStore`
    3. `FAISS`
    4. Milvus
    5. pgvector
  - langchain.embeddings
    1. HuggingFaceEmbedding

  - langchain_core.documents

  - langchain_community.document_loaders
    1. TextLoader: loads a text file
    2. CSVLoader: loads a csv file
    3. JSONLoader: loads a json file
    4. WebBasedLoader: loads webpages using BeautifulSoup4 library under the hood.
    5. DoclingLoader: helps in parsing pptx, html, docx, pdf files etc.
    6. UnstructuredLoader: uses `unstructured.io` library to parse any type of document.
    7. DirectoryLoader: uses UnstructuredLoader to load all the files in directory.
  
  - langchain.text_splitter or lanchain_text_splitters
    1. CharacterTextSplitter: splits the text based on provided length.
    2. TokenTextSplitter: works as same as CharacterTextSplitter but works with token instead of characters.
    3. RecursiveCharacterTextSplitter: specified split strings are used to split text and breaks the text further if it increases the specified limit using lower split strings.
    4. SemanticChunker: split text into sentences if it falls beyond some semantic matching threshold
    5. MarkdownHeaderTextSplitter

  
  - langchain_community.document_loaders
  - langchain_core.prompt
    1. PromptTemplate, ChatPromptTemplate, MessagePromptTemplate(AIMessagePromptTemplate, HumanMessagePromptTemplate, SystemMessagePromptTemplate, ChatMessagePromptTemplate), 
    2. Message placeholder: it is useful when you want to insert multiple messages in prompt, fewshot prompt template.
  - langchain_core.output_parser
    1. `JsonOutputParser` takes a `pydantic` object as input and `get_format_instruction` helps generate output instructions to the llm according to object.
    2. `CommaSeparatedListOutputParser` 
 
  - langchain_core.runnables
    RunnablePassthrough
  
  - langchain.storage
     1. InmemoryStore

  - langchain.retriever
    1. ParentDocumentRetriever: prompt is searched in smaller chunk then for each chunk the parent document is fetched and returned as relevant documents. It takes vectordb, document store, parent splitter and child splitter.
    2. Retriever: an interface
    3. VectorBasedRetriever: simply retrieve documents from an underlying database. It is created using `vectordb.as_retriever()`
    4. MultiQueryRetriever: uses LLM to generate multiple different version of prompt. It helps in increasing relevancy and remove any wording related issues from returned documents. It wraps around a retriever to query multi verstion of user prompt.
    5. SelfQueryRetriever: Uses LLM to divide the user prompt into text query (to be semantically searched) and additional metadata that can be used in metadata filtering. It takes LLM, metadata description, vectordb, and documnent description.
    6. MultiVectorRetriever: Takes vector store and doc store in constructor. Vector store will have granular chunks and doc store is for coarse chunk. It allows context expansion. 

  - langchain.chains
    1. LLMChain
    2. CoversationRetrievalChain
    3. RetrievalQA: A chain from langchain.chains that answers questions based on retrieved documents. The RetrievalQA chain combines a retriever with an LLM to generate answers based on the retrieved context.
 
  - langchain.memory
    1. ChatMessageHistory: an abstraction for chat history provides msg like `add_ai_message` and `add_user_message`
    2. ConversationBufferMemory: storage of message and conversation history.
 
  - langchain.messages
  - langchain_community.utilities
    1. sql_databases.SQLDatabase: An wrapper over sql database.
  - langchain_community.agent_toolkit
    1. SQLDatabaseToolkit requies SQLDatabase and llm. `get_tools` returns tools from toolkit.

## Question
- How wikipediaLoader works? parsing and find the relevant pages
- LLMGraphTransformer how it works?
## Rough 
- You can invoke an agent by passing an update to its State. All agents include a sequence of messages in their state; to invoke the agent, pass a new message:  

## References
 - https://docs.langchain.com/oss/python/langchain/overview#text-splitters
 