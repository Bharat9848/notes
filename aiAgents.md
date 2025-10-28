## Question
 - how to make LLM specialize in some area of problem statement ?
 - which LLM to choose
 - how to restrict model to answer using context only.


---


## Agentic workflow
 - Agentic workflow is different from fully autonomous agent, it follows a difinite workflow and unlike AI agent is not dynamic in nature.
 - Controller-worker pattern: LLM act as a controller and chooses from the fixed set of option. Option can be a tool or other LLM worker.


---

# security
 - prompt injection attack
---


## LLMs
  - Inference service hosted by **Model API**
  - **Model distillation**
  - A language model encodes statistical information about one or more languages.
  - Type
    1. Masked language model: try to predict the missing information in between of a sentence. "well-known example of a masked language model is bidirectional encoder representations from transformers, or BERT (Devlin et al., 2018)". Used for sentiment analysis, text classification.
    2. Autoregressive language model: try to predict next word. They are also called **Generative model**
  - **Multimodel**: An llm that trained on different type of input other than text like image, audio etc.
  - **Embedding Model**:
  - **Foundational model**: From specific task to general purpose model.
  - **Test-time compute**: Allocating more compute which allows LLM to generate multiple outputs which can be further sampled using some strategies.
  - LLM trained from the input itself using self-supervision - without explicit labeling of data.    
  - The set of all tokens a model can work with is the model’s vocabulary.
  - model configurations
    1. Temperature
      - higher temperature decrease the probabilities of common words and increase the probabilities of rare words. Hence increase the creativity of responses.
      - its value range from 0 to 2. 0.7 is the recommendation for sweet spot in creativity and predicatability. 

  - **Model properties**
    - **context-window**: Maximum number of token
    - model size
    - vocabulary
    - model parameters: 
      1. increasing model parameter increasing its capacity to learn. 
      2. `model parameter * parameter size` gives the GPU memory needed to make inference
      3. Model parameter is not good enough in case model is sparse means most of the parameters are zero.
    - model generation: signifies new version of model.
    - training dataset: 
      - measured in number of token to gauge the potency of dataset. 
      - Quantity, quality and diversity of token is proxy of potency of a model.
    - FLOPs: floating point operations required is a measure of the model cost.
     
  - Types are instruction models GPT-4 series and reasoning model GPT-o series.
  - LLMs can only “remember” a limited chunk of text at a time. 
  - Hallucination: To solve hallucination - RAG, guradrails, validator, human-in-the-loop and Fine tuning
  - Fine tuning llms are costly operation as it requires access to powerful hardware and highly curated domain specific data.
  - Low-Rank Adaption(LoRA) and Reinforcement Learning from human feedback(RLHF) are fine-tuning methods
  - Cost: 100 tokens is approximately 75 words.
    - Pay per API use
    - pay per token 
  - autoregressive model
  - Reinforcement learning model
  - self reflection and error correction
  - plan generation vs reflection
  - Tool selection: no foolproof quide
  - Mixture of expert model: Model diviedes parameter into groups called expert and while inferencing only one expert is activated. Mixtral 8x7B means there are 8 experts each of 7B size.  
## Post-training
  - It have a goal to tune the model to have conversation and removed any racist,sexist commentary from its internet
  - alignment training
  - Supervised finetuning(SFT)
  - Preference finetuning based on reinforcement learning from human feedback (RLHF) or Direct Preference Optimization(DPO)
## Model architecture
  - transformer
  - AlexNet
  - Seq2Seq
  - Generative Adversarial Networks
## Refrences
  - [reasoning with language model](https://arxiv.org/abs/2305.14992)
  - [ReAct](https://arxiv.org/abs/2210.03629)
  - [ReAct2](https://arxiv.org/abs/1809.09600)
  - [reflexion](https://arxiv.org/abs/2303.11366)
  - [AlexNet](https://oreil.ly/XG3mv)
  - [Huyen blog](https://huyenchip.com/blog/)
  - [historical english language model](https://oreil.ly/G_HBp)
  - [Masked LLM](https://arxiv.org/abs/1810.04805)
  - [supervised learning](https://oreil.ly/WEQFj)
  - [foundational models](https://arxiv.org/abs/2108.07258)
  - [Clip](https://oreil.ly/zcqdu)
  - [superNeural instruction benchmark](https://arxiv.org/abs/2204.07705)
  - [Rise of AI engineer](https://oreil.ly/OOZK-)
  - [common crawl](https://oreil.ly/wf2Lw)
  - [colossal common crawl](https://arxiv.org/abs/1910.10683v4)
  - [transformer architecture](https://arxiv.org/abs/1706.03762)
  - [seq2seq architecture](https://arxiv.org/abs/1409.3215)
  - [neuralmachine translation](https://arxiv.org/abs/1409.0473)
  - [model understanding](https://oreil.ly/j4wwW)
  - [transformer on TPU](https://oreil.ly/ON55d)
  - [mixture of expert](https://arxiv.org/abs/1701.06538)
  - [Biasness in model](https://arxiv.org/abs/2212.09251)
  - [ higher improvemets](https://oreil.ly/kO41d)
  - [LLM emergent abilities](https://arxiv.org/abs/2206.07682, https://oreil.ly/kuG3J)


---


# Fine-tuning
- Finetuning API
- partial finetuning
- full finetuning

---

## Authorization
---


## Evaluation
 - Evaluation API
 - When logprobs are available, use them. Logprobs can be used to measure how confi‐
dent a model is about a generated token.
### Evaluation pipeline
 - selecting new model
 - regression
 - monitor
 - user feedback
 - What
   1. Evaluation can happen at different levels: per task, per turn, and per intermediate output.
   2. per turn should evaluate quality to each output.
   3. per task should evaluate no of iterations model took to solve the problem.
   4. define what inputs are out of the scope of your application, how to detect them, and how your application should respond to them. 
   5. test queries, ideally real user queries test on relvance, factual correctness and safety.
   6. On this scoring system, create a rubric with examples. What does a response with a score of 1 look like and why does it deserve a 1? Validate your rubric with humans: yourself, coworkers, friends, etc. 
   7. business metrics
 - Human feeback [linkedin](https://www.linkedin.com/blog/engineering/generative-ai/musings-on-building-a-generative-ai-product)
 - [examples](https://arxiv.org/abs/2306.09479) 
### Model selection
 - prompt engineering might start with the strongest model overall to evaluate feasibility and then work backward to see if smaller models would work.
 - If you decide to do finetuning, you might start with a small model to test your code and move toward the biggest model that fits your hardware constraints (e.g., one GPU).
- When looking at models, it’s important to differentiate between hard attributes (what is impossible or impractical for you to change) and soft attributes (what you can and are willing to change).
- Check public benchmarks: Benchmark results help you identify promising models for your use cases. Aggregating benchmark results to rank models gives you a leaderboard. 
- references 
  1. [benchmark link](https://github.com/EleutherAI/lm-evaluation-harness/blob/master/docs/task_table.md)
  2. [huggingface leaderboard](https://oreil.ly/-uhru)
  2. [stanford leaderboard](https://oreil.ly/CQ52G)


### General
- Evaluation criteria based on application
  1. domain specific capability
    - MCQ for close ended applications. 
    - MCQ using part of the application data that can test model knoledge and reasoning.
  2. generationg capability
    - **fluency**: grammatically correct and natural sounding. measured by perplexity
    - **coherence**: structure of the text. It can be measured by perplexity
    - **faithfulness**:
    - **relevance**:
    - **Local factual consistency**: 
      - response is checked against the locally provided context.
      - factual consistenct[1](https://oreil.ly/HnIVp)
      - factual consistenct[2](https://arxiv.org/abs/2303.15621)
      - truthfulQA[3](https://oreil.ly/xvYjL)
      - selfcheckGPT [4](https://arxiv.org/abs/2303.08896)
      - knowledgeAugmentedVerification [5](https://arxiv.org/abs/2403.18802)
      - **textual entailment**: Given a premise (context), it determines which category a hypothesis (the output or part of the output)falls into: 1. Entailment: the hypothesis can be inferred from the premise. 2. Contradiction: the hypothesis contradicts the premise. 3.Neutral: the premise neither entails nor contradicts the hypothesis.
    - **Global factual consistency**
  3. instruction following capability
|instruction group| instruction| description|
|---------------|-----------|-------------|
|  Keywords | Include keywords | Include keywords {keyword1}, {keyword2} in your response | 
|  Keywords | Keyword frequency | In your response, the word {word} should appear {N} times.|
|  Keywords | Forbidden words | Do not include keywords {forbidden words} in the response.|
| Keywords |Letter frequency | In your response, the letter {letter} should appear {N} times.|
| Language | Response language | Your ENTIRE response should be in {language}; no other language is allowed. |
|Length constraint | Number paragraphs | Your response should contain {N} paragraphs. You separate paragraphs using the markdown divider: *** |
| Length constraints |Number words | Answer with at least/around/at most {N} words. |
| Length constraints | Number sentences | Answer with at least/around/at most {N} sentences. |
| Length constraints | Number paragraphs +first word in i-th paragraph | There should be {N} paragraphs. Paragraphs and only paragraphs are separated from each other by two line breaks. The {i}-th paragraph must start with word {first_word}. |
|Detectable content |Postscript | At the end of your response, please explicitly add a postscript starting with {postscript marker}.|
| Detectable content | Number placeholder | The response must contain at least {N} placeholders represented by square brackets, such as [address]. |
| Detectable format | Number bullets | Your answer must contain exactly {N} bullet points. Use the markdown bullet points such as: * This is a point. |
| Detectable format | Title |Your answer must contain a title, wrapped in double angular brackets, such as <<poem of joy>>. |
| Detectable format | Choose from |Answer with one of the following options: {options}. |
| Detectable format |Minimum number highlighted section |Highlight at least {N} sections in your answer with markdown, i.e. *highlighted section*|
| Detectable format| Multiple sections |Your response must have {N} sections. Mark the beginning of each section with {section_splitter} X.| 
| Detectable format | JSON format| Entire output should be wrapped in JSON format. |

  4. cost
  5. latency

1. Functional correctness
  - Need to do fact check
  - need to check reasoning
  - need to check domain expertise
  - Solutions
    1. **AI as a judge** 
      - can compare reference answer, two different answer and do naive comparison. 
      - Experiment on different criteria prompts with each prompt a separate call. 
      - cost can be reduced if responses are sampled.
      - Asynchronously evaluating the answers
      - Different AI tools e.g. as below judge on various criteria.
        | AI Tools | Built-in criteria|
        |-----------|----------|
        | Azure AI Studio | Groundedness, relevance, coherence, fluency, similarity | 
        | MLflow.metrics  | Faithfulness, relevance |
        | LangChain Criteria Evaluation | Conciseness, relevance, correctness,    coherence, harmfulness, maliciousness, helpfulness,controversiality, misogyny, insensitivity, criminality  |
        | Ragas | Faithfulness, answer relevance|
      - which model to use
        1. self evaluation and nudging for answer correction ?
    2. Human as a judge: Already we are at a stage where we require an expert to judge AI result.
    3. deterministic tests
    4. Similarity search with exact, lexical and semantic scores on generated answer when compared with referenced answer.
- deploy or not deploy
- benchmark progress
- model selection
  1. cross entropy: see cross entropy in machineLearningMaths.md
  2. perplexity: exponential of cross entropy. perplexity measures the amount of uncertainty it has when predicting the next token. Perplexity is 2^(cross-entropy). Structured data, simple text like children book and context length have lower perplexity. Post-Training and quantization increase the perplexity.
  3. small set of go-to prompts
  4. Bit-per-character: How much bits language model uses for a training set character.
  5. Bit-per-byte: How much bits language model uses for a training set byte.
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
  1. incosistency: model generates different output on slightly different or same prompts. It happens due to sampling technique used in model itself.
  2. hallucination: responses are not based on the facts. It happens due to many possible reason- model takes its output and considered it as a fact. Model is trained on non-factual data etc.
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
  - input tokens
  - input token division between think, generation and output formatting
  - output tokens
- Logging
  - tool invocation failure, input and output   
  - Each stage input/output.
  - plan steps

---

## Agent framework
 - check the planner and tool it supports
 - [no framework cookbook](https://github.com/anthropics/claude-cookbooks/tree/main/patterns/agents)

## Human in the loop
- for complex cases

---

## LLM Engine
## LLM chatbots 


---


# AI agent
  - agentic system, basically an LLM empowered with tools, context, and autonomy. 
  - store conversation history or relevant documentation. 
  - conversation provide useful user feedback but in natural language which is harder to extract.
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
  3. It can be a structured storage like RDBMS or queue for conversation
## structured output
  - prompting: instructs the LLM to generage output in desired format.
  - post-processing: write scripts to correct some common occurring errors.
  - constraint-sampling: Constraint sampling is a technique for guiding the generation of text toward certain constraints. It is typically followed by structured output tools. It increases model latency and its non trivial
  - finetuning:
### references
  - [guidance](https://github.com/guidance-ai/guidance?tab=readme-ov-file#features)
  - [outlines](https://github.com/dottxt-ai/outlines)
  - [instructor](https://github.com/instructor-ai/instructor)
  - [llama.cpp](https://github.com/ggerganov/llama.cpp/discussions/177)

### Tools 
  - types
   1. knowledge augmentation: contextual information through internal API, internet search etc.
   2. Capability extension: Access to tools like calculator, code interpretor etc that makes it more efficient at its job.
   3. Write tools that let you act upon the environment.
  - Tool documentaion should include examples, cornor cases, input format requirement etc  
  - LLM chat APIs take input list of tools that llm can use. And tool choice use behaviour setting which are as following
    1. `required`: LLM should use at least one tool.
    2. `none`: LLM should not use any tool.
    3. `auto`: LLM should use tool as they require. 
 - Planning:
   - generate plan agent
   - evaluate plan agent: do intent calculation
   - execute plan agent
### Safety
  - Biasness and toxicity
  - openAI content moderation API[1](https://oreil.ly/ZRwVI)
  - llama guard paper[2](https://arxiv.org/abs/2312.06674)
### Factual consistency     
### Reference
  - [SWE-agent](https://arxiv.org/abs/2405.15793)
  - [Chameleon](https://arxiv.org/abs/2304.09842)
  - [sample code](https://github.com/aie-book)
  - [tools calling benchmark](https://oreil.ly/lKB61)
  - [tools calling benchmark](https://github.com/AgentOps-AI/agentops)
  - [travelPlanner benchmark](https://github.com/OSU-NLP-Group/TravelPlanner)
  - [langchain report](https://oreil.ly/7Fkh-)
  - [Ai as a judge](https://arxiv.org/abs/2306.05685)
  - [self correction1](https://arxiv.org/abs/2210.03350)
  - [self correction1](https://arxiv.org/abs/2305.11738)
  - [self correction1](https://arxiv.org/abs/2310.08118)
  - [strong vs weak judge](https://arxiv.org/abs/2306.05685)


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
  4. [](https://modelcontextprotocol.io/docs/develop/build-client#building-mcp-clients)
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
3. Evaluator model which gives score to user query and final agent output.
4. workflow-Prompt-chaining: Sequence of LLM nodes working on sequential LLM outputs 
5. workflow-Routing: suited for task that can be categorized into different task each handled by separate LLM.
6. workflow-parallelization: Many LLM pitch in some substask
  1. sectioning: aggregation needs to aggregate subsection response 
  2. voting: Aggregation require choosing the best one.
7. workflow-orchestrator-workers: In the orchestrator-workers workflow, a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.
8. workflow-Evaluator-optimizer:In the evaluator-optimizer workflow, one LLM call generates a response while another provides evaluation and feedback in a loop.  
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


# Usecases
 - Text summarization: 
   1. Summarize list of documents
     1. **Map reduce**: Send each document for summarize in parallel and then send list of summaries to llm in a template to generate one final summary. It is good for large volume of data???. Any of the document is very large enough to get fit into context window. 
     2. **Refine**: Or alternatively Start with single doc summary send raw doc and existent summary to llm to generate summary iteratively. It is good to capture the essence of given ideas.  
   2. summarize a very big document.
     1. break the document into chunks
     2. summarize each chunk with using refine strategy.
## refrences
  - [uses](https://oreil.ly/Dz1HE)  

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
 - [embedding model](https://github.com/UKPLab/sentence-transformers)
 - [massive text embedding benchmark](https://arxiv.org/abs/2210.07316)

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


## AI applications
  - GPT engineer
  - talk to your docs
  - screenshot-to-code
  • Extracting structured data from web pages and PDFs (AgentGPT)
• Converting English to code (DB-GPT, SQL Chat, PandasAI)
• Given a design or a screenshot, generating code that will render into a website
that looks like the given image (screenshot-to-code, draw-a-ui)
• Translating from one programming language or framework to another (GPT-
Migrate, AI Code Translator)
• Writing documentation (Autodoc)
• Creating tests (PentestGPT)
• Generating commit messages (AI Commits)


---


## Rough
- self critique.
- "Note that while the increased context length impacts the model’s memory footprint, it doesn’t impact the model’s total number of parameters."
