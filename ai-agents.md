# Agent
- Agent is autonomous agent capable to follow ReAct pattern. It reacts to tool response and retry some actions till the desired task is achieved or some errornous condition is breached.
----

# Agentic workflow
 - Static agentic workflow is different from fully autonomous agent, it follows a difinite workflow and unlike AI agent is not dynamic in nature.
 - Controller-worker pattern: LLM act as a controller and chooses from the fixed set of option. Option can be a tool or other LLM worker.
----



## Question
 - how to make LLM specialize in some area of problem statement ?
 - which LLM to choose
 - how to restrict model to answer using context only.


---

# security
 - prompt injection attack
 - access control
 - encryption
 - adhere to HIPPA, GDPR

---

# Authorization

---
# Reliability
---
# Transparency
---
# Evaluation
 - see ai-eval.md
---


# Observability  
## Metrics 
1. Performance
  - Latency
  - agent cost
  - no of avg steps to complete the task
  - per action latency
  - system metrics like latency throughput.  
  - llm performance metrics.
2. Quality metrics
  1. LLM subcomponent
  - llm response quality metrics like faithfulness, response accuracy etc
  - citation quality
  - noise filtering
  - input tokens
  - input token division between think, generation and output formatting
  - output tokens
  - RAGA's library
  2. RAG subcomponent
  - recall and precision metrics using human annotated dataset.
  - contextual relevancy
  - answer relevancy: predicts weather llm is able to use context more effectively or not.
  3. Agent/tool subcomponent
  - Valid plan percentage
  - invalid tool call frequency in last X sec window
  - valid tool call percentage.
  - no of iterations from invalid plan to valid plan.
  - tool wise invocation failures
  - tool response rejection by llm.
  4. Overall system metrics
  - Human feedback with thumb up and down with optional text box for feedback.
  - Response error metrics
  - successful response metrics

### Logging
  - tool invocation failure, input and output   
  - Each stage input/output.
  - plan steps
### Trace
### References
- Phoenix by arize - observability tool.

----

## Agent framework
 - check the planner and tool it supports
 - [no framework cookbook](https://github.com/anthropics/claude-cookbooks/tree/main/patterns/agents)

## Human in the loop
- for complex cases

---
# AI agent
 - Planning:
   - generate plan agent
   - evaluate plan agent: do intent calculation
   - execute plan agent
  - agentic system, basically an LLM empowered with tools, context, and autonomy. 
  - store conversation history or relevant documentation. 
  - conversation provide useful user feedback but in natural language which is harder to extract.
  - Useful for multi-step tasks.
  - Agent is a orchestration layer which repeatedly consult LLM with all the original context alongwith responses to finally produce a response over multiple iterations.
## Streaming
  - streaming is useful in cases of big tasks
## LLM choosing
 - LLMs should be chosen based on task complexity
 - LLMs differ in different tooling invocation  
---- 
## Memory
  - Type
    1. short term session memory: cannot persist over and above a single query
    2. long term user memory: user prefrences from previous conversation
    3. long term application level memory
## Short term session memory
  1. checkpointing by langgraph
  2. Conversation: 
    - OpenAI Response API is powerful api with external tool calling like browsing web etc. It internally maintains conversation. 
    - Conversation can be summarized and stored to reduce memory footprint and remove duplication. It may require a new model to judge whether new conversation should be part of new summary or not. Conversation over a period of time may go out of hands. To manage it we might need to truncate it or send only last N messages. 
  3. It can be a structured storage like RDBMS or queue for conversation
----

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

----  
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
  - Tool documentaion should include examples, corner cases, input format requirement etc  
  - Agent API take input list of tools that llm can use. And tool choice use behaviour setting which are as following
    1. `required`: LLM should use at least one tool.
    2. `none`: LLM should not use any tool.
    3. `auto`: LLM should use tool as they require. 
  - tool error handling: In interceptor we can catch the exception and provide error message in chosen framework class for llm-tool comunication.
  - Internal: Model never actually calls the tool it is the application responsibility. LLM provides the tool name and the arguments.   
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
# Multi agent
- single turn or multi turn


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
8. workflow-Evaluator-optimizer: In the evaluator-optimizer workflow, one LLM call generates a response while another provides evaluation and feedback in a loop.  

---

# Frameworks

## AutoGPT
  - emphasizes fully autonomous, goal-driven agents with minimal supervision, but can face challenges with task consistency. 

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
## Things to learn
 -  OpenAI’s function calling, LangChain’s glue-code agent chains, or Replit’s ghost dev, 
 - open-source Agentic Commerce Protocol developed with Stripe, 
 

---


# Cost control
 - guardrails to check if user is not diverting from the domain.
 - experiment with smaller quantized model.
 - fine tune smaller model to one specific task
 - retrieve fewer document.
 - stricter prompt size
 - At scale switch from cost per token to cost per hour of dedicated hardware by any cloud provider
 - Vector use multi-tenancy database.
 - Dynamic model selection: Based on number of messages in conversation increasing some threshold we can override model fo complex model from same family.

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
  3. System instruction can be of different type based on the task at hand.
      1. Text completion: 
      2. Question Answering:
      3. Entity extraction
https://github.com/bahree/GenAIBook/blob/main/papers/readme.md#chapter-11---scaling-up-best-practices-for-production-deployment-