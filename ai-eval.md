# Evaluation
----
## General

### Offline evaluation
  - Test suite

### Online evaluation
  - Telemetry
  - Tracing with sampling
  - User feedback
    - Thumbs up and down (with feedback form)
    - It has disadvantage of users generally do not give feedback
  - Implicit Feedback
    - Acceptance of Agent answer by the user by some kind of telemetry

----
## Agent Evaluation
- complex to test so it also required LLM tracing

## Metrics
 - **correctness**: llm answer is based on a fact.
 - **relevance**: llm able to interpret the input and return answer which is informative and concise.
 - **semantic similarity**
 - **hallucination**: llm fakes the answer.

 - **responsible metrics**

 - **Agent Completion**
 
 - **custom task specific metrics**: 
 1. Task Completion: 
  - requires tracing input to LLM as a judge
  - [tracing](https://deepeval.com/docs/evaluation-llm-tracing)
  - [task completion](https://deepeval.com/docs/metrics-task-completion)
 2. Plan Quality
  - requires tracing input to LLM-as-a-judge
  - checks for agent reasoning and soundedness for task completion
 3. Plan Adherence:
  - checks whether LLM is adhering to its plan
 4. Step Efficiency:
  - checks for any redundant steps.
    
- **Tool related metrics**: 
 1. Argument Correctness
  - Based on LLM input argument generation for tool call was correct or not.
  - tested using LLM as a judge

 2. Tool correctness metrics
  - deterministic test whether LLM was able to choose the right tool. 

## Testing type
- End to End
- component level testing: valid only in case of multi agent design
  
## Testing scenarios
- fault tool call
- infinite loops
- hallucination
- instruction drift
- wrong tool selection

----

## LLM Evaluation
 - LLM Metrics 
  1. cohrence - collective quality of all sentences in the actual output.
  2. consistency
  3. Fluency
  4. Relevance
  5. AVG

----

## RAG Evaluation
### Metrics
- Answer-Relevance: Answer is relevant to the user question. LLM will act as evaluator behind the scene. IT will return additional chain of thought reasoning behind the score. Scores are in b/w 0-1.
- Groundedness: answer is based on the context provided
- Context-Relevance: It checks if context is relevant to user query. Each chunk is evaluated against the user input. Final score would be mean of all relevance scores. 
 - **RAG Faithfulness** ??
### General Testing Guidelines
- generate a high quality dataset - labeled by human,statistically significant,Data diversity
- check for relevancy when asked broader question. 
  1. Questions that can span multiple documents.
- check for relevancy when asked specific question 

### Component Testing
1. Retriever testing
 - context-relevance measures the context suitness with the user query
 - Context precision/Hit rate: Document retrieved from the search how relevant they are to query.
 - context recall: of all the documents that are relevant to query, how many of those are fetched
 - Mean Average Precision(MAP@K): sum of scores of relevant document only, divided by number of relevant documents.
 - Reciprocal rank measure the position of first relevant document and is calculated by `1/position`.
 - Mean Reciprocal Rank: average of many reciprocal ranks.

2. Generator testing
  - see LLM benchmark in ai-llm.md
  - groundedness/Faithfulness: answer is based on the context provided
  - answer-relevance: overall answer and context matches the query.

3. Embedding Model testing
 - to catch domain specific nuances.
 - Test to see if open source embedding model worthy that cloud provider one.  
 - map retrieval performance with different indexing algorithm like IVF, FlatL2, LSH, HNSW etc.
 - embedding model benchmarking
   - ANN Benchmarking 

4. Vector store benchmarking
   - Benchmarking IR (BEIR)[link](https://github.com/beir-cellar/beir)

5. end-to-end 
  - answer-correctness: Answer is compared to grounded truth
  - answer-similarity: semantic similarity between grounded truth and answer
### Process to generate RAG testing dataset
1. for each document/chunk generate question using following prompt
```
"Context information is below.\n"
    "---------------------\n"
    "{context_str}\n"
    "---------------------\n"
    "Given the context information and not prior knowledge, "
    "generate only questions based on the below query.\n"
    "Query: You are a Teacher/Professor. Your task is to setup {num_questions_per_chunk} questions for an upcoming quiz/examination. The questions should be diverse in nature across the document. Restrict the questions to the context information provided.\n"
    "Answer: "
```
2. Generate reference answer using following prompt
```
"Context information is below.\n"
    "---------------------\n"
    "{context_str}\n"
    "---------------------\n"
    "Given the context information and not prior knowledge, "
    "answer the below query.\n"
    "Query: {question}\n"
    "Answer: "
```
3. store the following tuple 
   `Question, reference answer, context` 


----

# Scorer 
### statistical based
- BiLingual Evaluation Understudy(BLEU): N-gram expection strings searched in LLM answer. Expections are based on ground truth which are expected in the answer.
- Recall-Oriented Understudy for Gisting Evaluation(ROGUE): calculates recall by comparing overlap of N-gram matching b/w llm output and expected answer
- Metric for Evaluation of Translation with Explicit Ordering: calculates recall and precision using N-gram matching. It uses WordNet dataset for synonym matching.
- Levenshtein distance: minimum insertion/replace/delete required to exact match b/w two text. It is used for precise alignment or spelling related task. 
 
### Model based
1. Natural Language Inference (NLI) scorer measures entailment, contradictory or irrelevant b/w llm answer and given reference text.
2. BiLingual Evaluation Understudy with Representation from Transformer: uses pre-trained BERT model to score LLM and some reference text
3. G-Eval framework:
4. DAG based framework: useful in usecases where some kind of order or priortization of output feature. High priority output feature are tested before and based on success output is evaluated of lower priority feature of output. Finaly each leaf node is marked with hardcoded score that was returned.
5. Prometheus: Uses reference text and score ruberic to return final score. 

### Statistical and model based
- BERTScore: compares reference text and llm output.
- MoverScore: calculate score by measuring minimum distance between reference text and llm output.
- QAG score: Very useful for calculating faithfulness. First it generates all the claims from the output and generate close ended question for each claim. Claim is then checked against given grounded truth for its existance.
- GPTScore: see paper
- SelfCheckGPT: see paper. Can only be used for hallucination detection

----

## Evaluation pipeline
 - Not to use more than 5 LLM evaluation metrics in your evaluation pipeline. Otherwise you will be measuring lot of things which will good as not measuring at all.
  - use 1-2 custom metrics (G-Eval or DAG) that are use case specific
  - 2-3 generic metrics (RAG, agentic, or conversational) that are system specific
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

## Evaluation testing framework
### Data model
- Eval: it is a specific test with definition of llm_output_schema and verifying_criteria
- verifying_criteria
- llm_output_schema
- test dataset: consist of input prompt and expected output. It exists independent of eval.
- Run: it will take application api against which you want to run your eval with input from test dataset. It will generate a report. It is asynchronous and notified via webhook on completion,failed and cancelled events.

### Ragas library
#### TestsetGenerator class
  - generate question types
    1. simple : straightforward question based on provided documents
    2. multi-context: question that span over multi related section to formulate an answer
    3. reasoning: requires reasoning skill to answer effectively
#### Evaluate function


--- 
# Refrences
 - BLEU
 - ROGUE
 - [G-eval](paper)(https://www.confident-ai.com/blog/g-eval-the-definitive-guide)
 - [LLM testing](https://www.confident-ai.com/blog/llm-testing-in-2024-top-methods-and-strategies)
 - [LLM as a judge](https://www.confident-ai.com/blog/why-llm-as-a-judge-is-the-best-llm-evaluation-method)
 - [deep eval](https://deepeval.com/docs/metrics-llm-evals)
 - [fineTuning](https://github.com/run-llama/finetune-embedding/blob/main/evaluate.ipynb)
 - [trulens](https://www.trulens.org/getting_started/core_concepts/feedback_functions/)
 - [SelfcheckGPT](paper)
 - [GPTScorer](paper)

 ---
