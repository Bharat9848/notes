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
 - access control
 - encryption
 - adhere to HIPPA, GDPR

---

## Authorization
---


# Evaluation

## Evaluation API
### Data model
- Eval: it is a specific test with definition of llm_output_schema and verifying_criteria
- verifying_criteria
- llm_output_schema
- test dataset: consist of input prompt and expected output. It exists independent of eval.
- Run: it will take application api against which you want to run your eval with input from test dataset. It will generate a report. It is asynchronous and notified via webhook on completion,failed and cancelled events.


### Evaluation pipeline
 - regression suite to test all the functionalities.
 - user feedback of like/dislike if possible with detail rejection reasoning.
 - What
   1. Evaluation can happen at different levels: per-task, per-turn and per-intermediate output.
   2. per-turn should evaluate quality to each output.
   3. per-task should evaluate no of iterations model took to solve the problem.
   4. define what inputs are out of the scope of your application, how to detect them and how your application should respond to them. 
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
#### model selection metrics
  1. cross entropy: see cross entropy in machineLearningMaths.md
  2. perplexity: exponential of cross entropy. perplexity measures the amount of uncertainty it has when predicting the next token. Perplexity is 2^(cross-entropy). Structured data, simple text like children book and context length have lower perplexity. Post-Training and quantization increase the perplexity.
  3. small set of go-to prompts
  4. Bit-per-character: How much bits language model uses for a training set character.
  5. Bit-per-byte: How much bits language model uses for a training set byte.



### Model quality framework
- Evaluation criteria based on application
  1. domain specific capability
    - MCQ for close ended applications. 
    - MCQ using part of the application data that can test model knowledge and reasoning.
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


1. Functional correctness
  - Need to do fact check, reasoning, check domain expertise
  - Solutions
    1. **AI as a judge** 
      - can compare reference answer, two different answer and do naive comparison. 
      - Experiment on different criteria prompts with each prompt a separate call. 
      - cost can be reduced if responses are sampled.
      - LLM-as-judge evaluations should use well-defined rubrics and discrete scoring rather than arbitrary continuous scores that are difficult to trace or justify.
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
    5. custom evaluation by preparaing customr dataset. It can be component level e.g. reranker, rewriter or RAG or it can be whole system level.
- deploy or not deploy
- benchmark progress

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

- Regression
  - model should be consitent in its answering.

### Prompt Tuning
- parallelize testing of prompt
steps to follow below
1. initial/update prompt
2. evaluate prompt is working 
3. if not go to step 1
4. evaluate 
   
---
# Agent evaluations
## Testing type
- End to End
- component level testing: valid only in case of multi agent design
## Testing scenarios
- fault tool call
- infinite loops
- hallucination
- instruction drift
- wrong tool selection

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
  2. previous messages in the conversation: 
    - openAI Response API internally maintains conversation 
    - conversation can be summarized and stored to reduce memory footprint and remove duplication. It may require a new model to judge whether new conversation should be part of new summary or not.
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
