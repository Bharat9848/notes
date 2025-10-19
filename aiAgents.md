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
  - autoregressive model
  - Reinforcement learning model
  - self reflection and error correction
  - plan generation vs reflection
  - Tool selection: no foolproof quide

## Refrences
  - [reasoning with language model](https://arxiv.org/abs/2305.14992)
  - [ReAct](https://arxiv.org/abs/2210.03629)
  - [ReAct2](https://arxiv.org/abs/1809.09600)
  - [reflexion](https://arxiv.org/abs/2303.11366)



---

## monitoring
---
## Authorization
---


## Evaluation
- Debugging:
  - context percentage usage of short-term memory and long-term memory
  - conversation importance of first vs last message. Both can be important based on the query
- Functional problems: 
  1. Generate a plan
     - plan fail to take constraint into considration
     - plan fail to achieve the overall goal.
     - missing tool for plan completion 
     - solution: evaluate it with one more model. Evaluating model should have a comprehensive heuristic to invalid plan. E.g. reject plans with more than X steps. 
  2. input tool calling should need to be evaluated.
    - invalid tool selection
    - tool invocation problems: invalid parameter, invalid parameter value
  3. reject invalid queries
  4. reflection failure: insisting on plan is complete 
- Behavioural
- Performance
  - Latency problems
  - agent cost
  - no of avg steps to complete the task
  - per action latency
- Regression
  - model should be consitent in its answering.
- Metrics
  - Valid plan percentage
  - invalid tool call frequency in last X sec window
  - valid tool call percentage.
  - no of iterations from invalid plan to valid plan.
  - tool wise invocation failures
- Logging
  - tool invocation failure, input and output   
  - Each stage input/output.
  - plan steps


---

## Agent framework
 - check the planner and tool it supports

## Human in the loop
- for complex cases

---

## LLM Engine
## LLM chatbots 


---


# AI agent
  - agentic system, basically an LLM empowered with tools, context, and autonomy. 
  - store conversation history or relevant documentation.
  - Useful for multi-step tasks.
  - Agent is a orchestration layer which repeatedly consult LLM with all the original context alongwith responses to finally produce a response over multiple iterations.
## LLM choosing
 - LLMs should be chosen based on task complexity
 - LLMs differ in different tooling invocation  
## Memory
  - Type
    1. short term session memory: cannot persist over and above a single query
    2. long term user memory: user prefrences from previous conversation
    3. long term application level memory
## Short term session memory
  1. checkpointing by langgraph
  2. previous messages in the conversation: 
    - openAI Response API internally maintains conversation 
    - conversation can be summarized and stored to reduce memory footprint and remove duplication. It may require a new model to judge whether new conversation should be part of new summary or not.
  3. It can be a structured storage like RDBS or queue for conversation
 - structured output
### Tools 
  - types
   - knowledge augmentation: contextual information through internal API, internet search etc.
   - Capability extension: Access to tools like calculator, code interpretor etc that makes it more efficient at its job.
   - Write tools that let you act upon the environment. 
  - LLM chat APIs take input list of tools that llm can use. And tool choice use behaviour setting which are as following
    1. `required`: LLM should use at least one tool.
    2. `none`: LLM should not use any tool.
    3. `auto`: LLM should use tool as they require. 
 - Planning:
   - generate plan agent
   - evaluate plan agent: do intent calculation
   - execute plan agent
### Reference
  - [SWE-agent](https://arxiv.org/abs/2405.15793)
  - [Chameleon](https://arxiv.org/abs/2304.09842)
  - [sample code](https://github.com/aie-book)
  - [tools calling benchmark](https://oreil.ly/lKB61)
  - [tools calling benchmark](https://github.com/AgentOps-AI/agentops)
  - [travelPlanner benchmark](https://github.com/OSU-NLP-Group/TravelPlanner)

---

---


# MCP
  - MCP ensures that relevant data flows smoothly between actions, tools, and the language model.   
  - Security: Do not allow AI to do what is outside of their limit like obtaining sensitive information, deleting data etc.
## MCP deployment
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
### mcp inspector
  - to run locally `docker run --rm --network host -p 6274:6274 -p 6277:6277 ghcr.io/modelcontextprotocol/inspector:latest`
### Resources
  1. list of mcpservers
    - [](https://mcpservers.org/)
    - [](https://smithery.ai/)
    - [](https://mcp.so/)
    - [](https://github.com/modelcontextprotocol/servers)
  2. [specification](https://modelcontextprotocol.io/specification/versioning)
  3. [python MCP SDK](https://github.com/jlowin/fastmcp) and [documentation](https://gofastmcp.com/getting-started/welcome)
### Rough
  - OpenAI’s API natively supports tools provided by public MCP servers via the Responses API. Not only can you discover and reference these tools, but OpenAI will also execute them for you—eliminating the need for manual client code in many cases.
  - langchain `MultipleServerMCPClient`    
---

---


## Multi-agent patterns
1. primary-worker orchestration
 - shared memory which includes dialogue history, user profile
 - worker agent specific memory includes agent goal.
 - Planning module, translation module
2. weaker model do simple task e.g. translation while complex tool will do high level planning and detailing 
3. Evaluator model which gives score to user query and final agent output

---


## prompt engineering
 - prompt types
   1. system prompt: with examples
   2. user prompt
   3. context prompt 
 - **Defensive prompt engineering**
 - block of instructions with examples and context
 - **prompt template**
 - **few-shot prompting**
 - A well structured prompt includes `Role` or `persona`, `context`, `text`, `tone`, `instructions`, and `output format`
 - `tone`: specify the desired tone of the LLM's answer—formal, informal, witty, enthusiastic, sober, friendly, etc. Combinations are possible.
 - zero shot learning: when llm is able to answer without any examples in the prompts.
 - few-shot examples: whem we provide llm with few `examples` to facilitate different scenarios or augment its knowledge.
 - chain of thought: For reasoning give LLM the step by step prompt.
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
   | plan generation | Think step by step               |
   | Reflection      | verify if your answer is correct |

  - resources: 
    1. [awesome-prompt eng](https://github.com/promptslab/Awesome-Prompt-Engineering)
    2. [samples](https://github.com/dair-ai/Prompt-Engineering-Guide)
    3. [prompt-techniques](https://www.promptingguide.ai/techniques)
    4. [lang community hub]()


---


 # LangChain 
  - `Runnable`: all component which subclass this interface can be part of chain.
  - `RunnableLambda`, `BaseModel`
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
  - search the web or query the database  - 
  - help in grouding answer to prevent halluciation: relevant search is provided as a context to LLM alongwith user's question
  - RAG helps with facts but doesn’t give the LLM memory across conversations or enable planning and automation. ???
## Advanced RAG techniques
  - Shorter context are more efficient but they fail to answer broader questions. The longer the context, the more likely the model is to focus on the wrong part of the context.
  - **Question transformation**: Rephrasing a vague question can result in more efficient search.
  - **Advanced Indexing**/**contextual indexing**: 
    - multiple embeddings for single document. 
    - additional keyword indexing
    - Metadata indexing can help in giving footlinks to the user.
  - **Question split**: Broad question may not result in pinpoint answer, breaking the question into sub-question might help in overall process of vector search and generation phase.
  - **Multi-store routing**: Vector store can be supplemented with other store like relational databases, table or graph which are presided over LLM to help with individual technology syntax.
  - Ensemble strategy to maximize precision
  - Removal of inaccurate answer.
  - Multimodel embedding model like [CLIP](https://arxiv.org/abs/2103.00020) is used when you have query as text but embedding data is a image.

## vector store
 ## Ingestion phase
  1. embedding functions
    - `OpenAIEmbeddings`: not free.
  2. text split strategy: 
    - chunk overlap: lose meaning around sentance boundry. Used with fixed size chunking
    - document hierarchy: Documents is break around paragraph, sentence. more accurate in semantic meaning.
    - "You can also chunk documents using tokens, determined by the generative model’s tokenizer, as a unit. Let’s say that you want to use Llama 3 as your generative model. You then first tokenize documents using Llama 3’s tokenizer. You can then split documents into chunks using tokens as the boundaries. Chunking by tokens makes it easier to work with downstream models. However, the downside of this approach is that if you switch to another generative model with a different tokenizer, you’d need to reindex your data."  
  3. Advanced embedding strategy
    - Multi vector indexing: The key to these strategies is a two-layer chunk structure. The top layer includes synthesis chunks—the chunks fed into the LLM to generate answers. The lower layer consists of retrieval chunks, smaller segments that create precise embeddings for retrieving the synthesis chunks.
    - medadata indexing
    - combination of metadata and embedding indexing
    - parent/child document indexing: Vector store will store both parent and child embeddings. In case of broader question parent index will be fetched and for detail question child index will be fetched.
    - summaries indexing
    - hypothetical question indexing associated with the chunk 

 ## Retrieval phase

  - sparse vector search
    - also called term-based search and lexical search.
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
    - used with hybrid search.
    - It is needed if the number of documents increasing the context length or decrease the number of input token.

  - **caches**  
  - Indexing Structured and Semi-Structured Data: Retrieving structured data (e.g., database tables or multimedia content) using unstructured queries requires specialized techniques. This can include generating embeddings for database rows, images, or even audio files.  

### Vector DBs / tools
 - "In general, vector databases organize vectors into buckets, trees, or graphs. Vector search algorithms differ based on the heuristics they use to increase the likelihood that similar vectors are close to each other. Vectors can also be quantized (reduced precision) or made sparse. The idea is that quantized and sparse vectors are less computationally intensive to work with."
 - Context precision: Document retrieved from the search how relevant they are to query
 - context recall: of all the documents that are relevant to query, how many of those are fetched
 - context precision and context recall are used to check the performance of retriever.
#### References
 - `faiss`: in-memory vector database, each embedding is associated with unique document identifier. Document is stored somewhere else. [link](https://github.com/facebookresearch/faiss/wiki/
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


---
## Things to learn
 -  OpenAI’s function calling, LangChain’s glue-code agent chains, or Replit’s ghost dev, 
 - open-source Agentic Commerce Protocol developed with Stripe, 
 
---

# Guardrail
- Usage
  - tool level check to prevent unauthorized which led to data modification
  - routing stage check: check if model doing right tool orchestration and block invalid tool orchestration.
  - block invalid input to LLM.
  - block invalid LLM output.
- Post guardrail failure: request can be rejected or user can be asked for more clarification or request can be guided to more safer path.  
- Implementation
  1. Model based: compact classification or moderation model access intent, safety and adherence on model output and input 
  2. rule based: checking some blacklisted keywords or regexes against model IO.
  3. Retrieval based: checked with data source audit.
- router level guardrail for faster broader rejection
- agent level guardrail for domain specific rejection
- post model guardrail usecases includes: remove PII data, validate model output format, fact check or enforcing brand style

---


# Cost control
 - guardrails to check if user is not diverting from the domain.


---



---


## Rough
- self critique.
