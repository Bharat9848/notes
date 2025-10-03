## Question
 - how to make LLM specialize in some area of problem statement ?
 - which LLM to choose
---
## LLMs
  - Types are instruction models GPT-4 series and reasoning model GPT-o series.
  - LLMs can only “remember” a limited chunk of text at a time. 
  - Hallucination: To solve hallucination - RAG, guradrails, validator, human-in-the-loop and Fine tuning
  - Fine tuning llms are costly operation as it requires access to powerful hardware and highly curated domain specific data.
  - Low-Rank Adaption(LoRA) and Reinforcement Learning from human feedback(RLHF) are fine-tuning methods
  - Cost:
    - Pay per API use
    - pay per token 
---
## RAG
  - search the web or query the database.
  - help in grouding answer to prevent halluciation: how ??
  - RAG helps with facts but doesn’t give the LLM memory across conversations or enable planning and automation. ???
---
## LLM Engine
## LLM chatbots 
---
## AI agent
  - agentic system, basically an LLM empowered with tools, context, and autonomy. 
  - store conversation history or relevant documentation.
  - Useful for multi-step tasks.
  - Agent is a orchestration layer which repeatedly consult LLM with all the original context alongwith responses to finally produce a response over multiple iterations.

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
 - extensive context: instructions on how to use dialogue history and user profiles (e.g. Analyze `[DIALOGUE_HISTORY]` and `[USER_PROFILE]` to identify gaps and avoid redundant questions.
 - few-shot examples
 - chain of thought



 
 - persona definitions with role specification
 - safety guidelines
 - specific output formatting requirements.
---
 # LangChain 
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
 ## LangGraph
 ## LangSmith
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


## Things to learn
 - vector database
 -  OpenAI’s function calling, LangChain’s glue-code agent chains, or Replit’s ghost dev, 
 - open-source Agentic Commerce Protocol developed with Stripe, 
