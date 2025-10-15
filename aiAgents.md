## Question
 - how to make LLM specialize in some area of problem statement ?
 - which LLM to choose
---
## Agentic workflow
 - Agentic workflow is different from fully autonomous agent, it follows a difinite workflow and unlike AI agent is not dynamic in nature.
 - Controller-worker pattern: LLM act as a controller and chooses from the fixed set of option. Option can be a tool or other LLM worker.
---
## LLMs
  - **context-window**: Maximum number of token
  - Types are instruction models GPT-4 series and reasoning model GPT-o series.
  - LLMs can only “remember” a limited chunk of text at a time. 
  - Hallucination: To solve hallucination - RAG, guradrails, validator, human-in-the-loop and Fine tuning
  - Fine tuning llms are costly operation as it requires access to powerful hardware and highly curated domain specific data.
  - Low-Rank Adaption(LoRA) and Reinforcement Learning from human feedback(RLHF) are fine-tuning methods
  - Cost:
    - Pay per API use
    - pay per token 

---
## monitoring
---
## Authorization
---
## Evaluation
---
## LLM Engine
## LLM chatbots 
---
## AI agent
  - agentic system, basically an LLM empowered with tools, context, and autonomy. 
  - store conversation history or relevant documentation.
  - Useful for multi-step tasks.
  - Agent is a orchestration layer which repeatedly consult LLM with all the original context alongwith responses to finally produce a response over multiple iterations.
### Memory
 - Type
    1. short term session memory
    2. long term user memory
    3. long term application level memory
### Short term session memory
  1. checkpointing by langgraph
  2. openAI Response API internally maintains conversation 
### open  
---
## Prompt engineering
 - block of instructions with examples and context
 - **prompt template**
 - **few-shot prompting**
---
## MCP
  - MCP ensures that relevant data flows smoothly between actions, tools, and the language model.   
  - Security: Do not allow AI to do what is outside of their limit like obtaining sensitive information, deleting data etc.
### MCP deployment
  - MCP servers can be run in a serverless setup, storing session and connection info in Redis.??
## MCP protocol
  - **host**: Host is an orchestrator managing sessions, agent lifecycle etc.
  - **client**: Agents uses MCP client to talk to external system
  - **server**: 
    - Server gives MCP response over 
     - prompt: domain specific prompt strategy,
     - resources are to serve static resource like API keys, glossary etc. they are used for - Provide contextual background (e.g., a list of predefined topics), Inject static configuration or preferences and support client-side filtering, choices, or menus.
     - tool/function(invoke some API, run sql query using sql client).
    - Server provides the discovery of functionality in a standard way. So that agent can leverage to learn about the servers capability. `tools/list`, `tools/call` and `resources/list`, `resources/read` are exposed as part of discovery.
    - Each endpoint is detailed out for its capabilities, permissions and data formats.
    - From MCP server to any third party API call, security is applied using either oauth 2.1 flow or API tokens

  - MCP Clients talks to MCP server using Standard Input/Output(STDIO) locally and Http with Server-Sent Event remotely with JSON-RPC 2.0 message formatting. 

---

## Multi-agent patterns
1. primary-worker orchestration
 - shared memory which includes dialogue history, user profile
 - worker agent specific memory includes agent goal.

---
## prompt engineering
 - A well structured prompt includes `Role` or `persona`, `context`, `text`, `tone`, `instructions`, and `output format`
 - `tone`: specify the desired tone of the LLM's answer—formal, informal, witty, enthusiastic, sober, friendly, etc. Combinations are possible.
 - zero shot learning: when llm is able to answer without any examples in the prompts.
 - few-shot examples: whem we provide llm with few `examples` to facilitate different scenarios or augment its knowledge.
 - chain of thought: For reasoning give LLM the `step n` prompt.
 - in-context learning: It includes examples with chain of thought in the prompt to make llm figure out any unknown task.
 - Chain of Thought improves how language models handle complex reasoning by breaking problems into smaller, logical steps. However, it has limitations, such as missing deeper exploration or struggling with messy contexts. Two advanced techniques address these gaps: Tree of Thought (ToT) and Thread of Thought (ThoT): 
 - safety guidelines ??

 - problem type and prompt example

  | type                | example                                                   |
  | ------------------- | --------------------------------------------------------- |
  | Text classification |Classify the following text into one of these categories...|
  | Sentiment analysis | Classify the following text as positive, neutral or negative |
  | Text summarization | Write a 30 word summary for the following text  | 
  | Composing Text     | Write a piece on the ..., mentioning the following facts  |
  | Question answering | read the following and tell me ... | 
  | chat prompt        | ```` ChatPromptTemplate.from_messages(
    [
        ("system", "You are a helpful blah blah. Answer all questions to the best of your ability, but only use what has been provided in the context. If you don't know, just say you don't know. Use three sentences maximum and keep the answer as concise as possible."),
        ("placeholder", "{chat_history_messages}"),
        ("assistant", "{retrieved_context}"),
        ("human", "{question}"),
    ]
)```` |

  - resources: 
    1. [awesome-prompt eng](https://github.com/promptslab/Awesome-Prompt-Engineering)
    2. [samples](https://github.com/dair-ai/Prompt-Engineering-Guide)
    3. [prompt-techniques](https://www.promptingguide.ai/techniques)
    4. [lang community hub]()

-    

---

 # LangChain 
  - `Runnable`: all component which subclass this interface can be part of chain.
  - `RunnableLambda`
  - `RunnableParallel`
  - Loader
  - Splitters
  - embedding model
  - retriever
  - vector stores
   - Rough
   "You start by pulling in text from different sources—files, databases, or websites—and wrapping it into Document objects. Those documents are often split into smaller chunks so they’re easier to handle. Next, each chunk is passed through an embedding model, which turns the text into vectors that capture its meaning. Both the raw chunks and their embeddings are stored in a vector store, which lets you quickly retrieve the most relevant pieces of text based on similarity search. When an LLM app runs a task—say summarization or semantic search—it builds a prompt that combines the user’s question with extra context. That context usually comes from document chunks pulled out of a vector store. Sometimes, though, you’ll also want to bring in information from a graph database. Vector stores are still the backbone of most retrieval-augmented generation (RAG) workflows, but graph databases are becoming more common in apps that need to represent and reason about relationships between entities."
   "With loaders, splitters, embeddings, retrievers, vector store retrievers, and prompt templates, you can focus on application logic instead of boilerplate. The LangChain Expression Language (LCEL) and the Runnable interface then let you chain these pieces together consistently, making pipelines easier to build, debug, and maintain."

   "Additionally, LangChain supports a Fake LLM for unit testing purposes."
   "nowledge Graph databases: Although not a key component of the architecture, LangChain offers client wrappers for leading graph databases to facilitate Knowledge Graph functionality. These databases store entities and their relationships in a graph form."
   "Prompts (6): LangChain provides tools for defining prompt templates"
   "Chain: A composite arrangement guiding LangChain's processing workflow, customized for specific use cases and based on a sequence of the described components.
Agent: This component manages a dynamic workflow, extending a sequential chain."
  - `ChatMessageHistory`: saves only the question using `add_user_message(str)` method and llm response as `add_ai_message(str)`  
 ## LangGraph
  - It is stateful, persistent agentic workflow with state saved in graph based execution.
  - Node represents a individual task of the process like calling an API etc. Node are represented with explicit node name which is bound to a python function name through graph API.
  - Edge defines the path between the tasks. Simple edge are defined through graph API with first node name as source and second node name as destination. Conditional edges are defined through a python function which returns the alternate node name based on some condition.
  - State is information that moves between the nodes. It is strongly typed using `TypedDict` from `typing` module
  - branching edges makes llm take decision dynamically based on the previous state.
  - cyclical workflows makes refinement of work possible.

 ## LangSmith
  - Tracing feature: Hub provides the templates prompt for most usecases
  - Evaluation: 
    - relevance
    - correctness
    - sensitivity
  - Also provides dataset from various sources for continous and regression testing
  -   
---
## AutoGPT
  - emphasizes fully autonomous, goal-driven agents with minimal supervision, but can face challenges with task consistency. 
---
## LlamaIndex
  -  stands out in knowledge retrieval, though its scope is narrower than broader agent frameworks. 
## Microsoft Autogen
  - supports highly customizable multi-agent conversations, but comes with a steeper learning curve. 
## n8n 
  - provides a visual interface and extensive integrations, making it accessible to non-developers, though advanced reasoning may require additional components. 

## Microsoft Semantic Kernel 
 - prioritizes memory and planning and integrates well with Azure services. 

## CrewAI 
  - enables collaborative, multi-agent systems for specialized teams, but is a newer tool with a smaller community.
---
---
## Usecases

 - Text summarization: 
   1. Summarize list of documents
     1. **Map reduce**: Send each document for summarize in parallel and then send list of summaries to llm in a template to generate one final summary. It is good for large volume of data???. Any of the document is very large enough to get fit into context window. 
     2. **Refine**: Or alternatively Start with single doc summary send raw doc and existent summary to llm to generate summary iteratively. It is good to capture the essence of given ideas.  
   2. summarize a very big document.
     1. break the document into chunks
     2. summarize each chunk with using refine strategy.

---
## Rough
  - LLM with stale knowledge
   - pre-agent fix with fine tuning with new data.
   - custom script to train with new data.
   - RAG
  - "agent will be constructed using LangChain for tool-aware logic, LangGraph to manage execution flow, and OpenAI as the underlying LLM that interprets input and selects tools. Although there are multiple ways to build MCP clients—including platforms like Claude Desktop, VS Code agents, or the OpenAI Agents SDK—we’ve selected LangGraph because it provides a programmable, event-driven framework for reasoning, tool usage, and state transitions. Its native support for tool routing, message passing, and memory checkpoints aligns well with MCP’s modular interface, making it a practical and scalable solution for client-side orchestration."
  - agentic principles: assigning roles, aligning goals, coordinating behavior, and learning from experience. 
  - Specifically, MACRS exemplifies a modular agentic architecture that leverages an explicit control loop for dialogue flow, and addresses the inherent coordination costs of multi-agent systems through structured planning and reflection.
  - "With agentic systems, we have unique factors to consider: Probabilistic reasoning means agents may respond differently to the same input, especially as context, memory, or prompt framing changes.
    Task delegation hands the "how" over to the agent. You're defining goals, not writing every step.
    Observability and replay become critical because you can’t just read logs to understand what happened. You need session traces, intermediate thoughts, and decision records.
    Fuzzy reasoning paths replace hard-coded logic. Agents explore solutions instead of following strict workflows — flexible, but harder to control."

--- 
# RAG
  - search the web or query the database.
  - help in grouding answer to prevent halluciation: how ??
  - RAG helps with facts but doesn’t give the LLM memory across conversations or enable planning and automation. ???

## Advanced RAG techniques
  - Shorter context are more efficient but they fail to answer broader questions.
  - **Question transformation**: Rephrasing a vague question can result in more efficient search.
  - **Advanced Indexing**: multiple embeddings for single document.
  - **Question split**: Broad question may not result in pinpoint answer, breaking the question into sub-question might help in overall process of vector search and generation phase.
  - **Multi-store routing**: Vector store can be supplemented with other store like relational databases, table or graph which are presided over LLM to help with individual technology syntax.
  - Ensemble strategy to maximize precision
  - Removal of inaccurate answer.

## vector store
 ## Ingestion phase
  0. embedding functions
    - OpenAIEmbeddings: not free.
  1. text split strategy: 
    - chunk overlap: lose meaning around sentance boundry. Used with fixed size chunking
    - document hierarchy: Documents is break around paragraph, sentence. more accurate in semantic meaning
  2. Advanced embedding strategy
    - Multi vector indexing: The key to these strategies is a two-layer chunk structure. The top layer includes synthesis chunks—the chunks fed into the LLM to generate answers. The lower layer consists of retrieval chunks, smaller segments that create precise embeddings for retrieving the synthesis chunks.
    - medadata indexing
    - combination of metadata and embedding indexing
    - parent/child document indexing: Vector store will store both parent and child embeddings. In case of broader question parent index will be fetched and for detail question child index will be fetched.
    - summaries indexing
    - hypothetical question indexing associated with the chunk 
 ## Retrieval phase
  1. Similarity search algorithms
    -  
  2. search type
    1. `similarity`
    2. `similarity_with_score`
    3. `mmr` Max Marginal Relevance
  3. search expansion:
    - for broader question it is helpful to add smaller chunks with neighbouring sentences to provide broader context.
  4. Indexing Structured and Semi-Structured Data: Retrieving structured data (e.g., database tables or multimedia content) using unstructured queries requires specialized techniques. This can include generating embeddings for database rows, images, or even audio files.  
### tools
 - `faiss`: in-memory vector database, each embedding is associated with unique document identifier. Document is stored somewhere else. [link](https://github.com/facebookresearch/faiss/wiki/
)
 - `milvus` : Image dense vector search. [link](https://milvus.io)
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
---
## Things to learn
 -  OpenAI’s function calling, LangChain’s glue-code agent chains, or Replit’s ghost dev, 
 - open-source Agentic Commerce Protocol developed with Stripe, 
 
