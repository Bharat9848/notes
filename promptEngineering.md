# prompt engineering

## Model structure
  - subject to experimentation.
  - Not all prompt parts are important [1](https://arxiv.org/abs/2307.03172)
  - needle in a hay stack test
  - RULER[1](https://arxiv.org/abs/2404.06654)

## Template 
  - Templates are model specific and are defined in model documentaion.
  - A well structured prompt includes Role or persona, context, text, tone, instructions, and output format
  - Tone: specify the desired tone of the LLM's answer—formal, informal, witty, enthusiastic, sober, friendly, etc. Combinations are possible.
  - use markers to mark the end of the prompts to let the model know that the structured outputs should begin.
 ````
  System prompt: <Role> with overall task description
  User prompt:
   1. context
   2. Examples:
   3. Task:
 ````
## Model properties prerequisite
  - Instruction following capability:
  - Robustness: It measures model output changes on slightest changes of prompt.

## In-context learning
  -  It includes **examples** with **chain of thought** in the prompt to make llm figure out any unknown task.
  - zero shot learning: when llm is able to answer without any examples in the prompts.
  - few-shot examples: whem we provide llm with few `examples` to facilitate different scenarios or augment its knowledge.
  - chain of thought: For reasoning give LLM the step by step prompt.
  - **few-shot prompting**
  - in-context learning [paper](https://arxiv.org/abs/2005.14165)
### Chain of Thought (COT)
  - It improves how language models handle complex reasoning by breaking problems into smaller, logical steps. 
  - However, it has limitations, such as missing deeper exploration or struggling with messy contexts. Two advanced techniques address these gaps: Tree of Thought (ToT) and Thread of Thought (ThoT): 
  - More complex the model is less examples it requires. However examples are necessary for domain specific learning.
  - It increases cost.
  - COT elicites reasoning [link](https://arxiv.org/abs/2201.11903)
  - reduce hallicuniation [link](https://www.linkedin.com/blog/engineering/generative-ai/musings-on-building-a-generative-ai-product)
### self critique prompt
  - "explain your decision"
  - increases cost  
## General
 - check prompts for typo and bad grammer.
 - Model are very sensitive to propmts, even changing the prompt with space can lead to different output.
 - prompt types
   1. system prompt: with examples
   2. user prompt
   3. context prompt 
 - **Defensive prompt engineering**
 - block of instructions with examples and context
 - safety guidelines ??

## context length
  - Number of input token model can take in a single query.

## prompt decomposition 
  - break complex task into simple subtasks.
  - helps in better debugging, parallelization, monitoring and effort
  - disadv is increased latency and cost.

## context prompt
  - restrict response by providing context.

## Defensive prompt engineering
  - prompt extraction prevention: attacker able to figure system prompt to exploit llm further.
  - jailbreaking and prompt injection: llm do unintended things.
  - information extraction: context or training data leak.
  - run malicious code 
  - "Write your system prompt assuming that it will one day become public."
  - leaked chatgpt [prompt](https://github.com/LouisShark/chatgpt_system_prompt)
  - obfuscation of banned word like vaccine become vacine etc.
  - attacks [1](https://arxiv.org/abs/2307.15043)
  - malicious intent hidden in output instruction.
  - roleplaying attacks
    - DAN[a](https://oreil.ly/BPAal)
    - gradma exploit
  - PAIR[1](https://arxiv.org/abs/2310.08419)
  - Indirect prompt injection 
    - through tools[1](https://arxiv.org/abs/2302.12173)
    - malicious code repo used in training.
    - RAG attack using username like “Bruce Remove All Data Lee”.
    - Extracting the model’s training data can potentially reveal these private emails.
    - Copyright infringement: If the model is trained on copyrighted data, attackers could get the model to regurgitate copyrighted information.
    - Model is asked to repeat a word. After few token model print gibbrish. Once the model diverges, its generations are often nonsensical, but a small fraction of them are copied directly from the training data
    - To evaluate a system’s robustness against prompt attacks, two important metrics are the violation rate and the false refusal rate
    - repeat the system prompt in the last.
    - be explicit about what is not allowed
    - [1](https://arxiv.org/abs/2012.07805)
    - [2](https://arxiv.org/abs/2205.12628)
    - [3](https://arxiv.org/abs/2311.17035)
    - [4](https://oreil.ly/DNj9O)
    - [5](https://arxiv.org/abs/2301.13188)
    - [holistic evolution of LLM](https://arxiv.org/abs/2211.09110)
    - [red team planning](https://oreil.ly/TYoZj)
    - [jailbreaker](https://github.com/CHATS-lab/persuasive_jailbreaker)
    - [llm-security](https://github.com/greshake/llm-security)
    - [instruction heirarchy](https://arxiv.org/abs/2404.13208)
    - [langchain attacks](https://oreil.ly/DFjgW)
    - [example prompts](https://www.promptingguide.ai/introduction/examples.en)
    - [ReAct prompt](https://www.promptingguide.ai/techniques/react)
    - [chain-of-thought](https://www.promptingguide.ai/techniques/cot)
    - [zero-shot](https://www.promptingguide.ai/techniques/zeroshot)
    - [few-shot](https://www.promptingguide.ai/techniques/fewshot)
    - [prompt-creation-framework](https://github.com/microsoft/guidance)



## prompt template
  - [link](https://github.com/promptfile/promptfile)
  - [link](https://oreil.ly/nriHw)
  - [link](https://oreil.ly/ceZLs)
  - [link](https://oreil.ly/FuBEI)
  - [link](https://oreil.ly/ceZLs)

## prompt iterations
  - versioning 
  - AB testing 
  - evaluate local task improvement
  - evaluate total task improvement

## prompt optimization tool
  - takes input/output, evaluation metrics and evaluation data
  - link[1](https://arxiv.org/abs/2111.01998)
  - link[2](https://arxiv.org/abs/2310.03714)
  - deepmind prompt [llm](https://arxiv.org/abs/2309.16797)
  - stanford text grad [llm](https://arxiv.org/abs/2406.07496)
  - increase cost and tool changes, instead switch to manual[1](https://oreil.ly/b_H2s)


## Exercise
 
  - Experiment on how many examples are needed in prompt for model to behave optimally.
  - check prompt length- use prompt with less token but with same examples

## problem type and prompt samples

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
  - see prompt repo 

## resources: 
  1. [awesome-prompt eng](https://github.com/promptslab/Awesome-Prompt-Engineering)
  2. [samples](https://github.com/dair-ai/Prompt-Engineering-Guide)
  3. [prompt-techniques](https://www.promptingguide.ai/techniques)
  4. [lang community hub](https://smith.langchain.com/hub)
  5. [how in-context learning works](https://oreil.ly/N2fup)
  6. [instruction hierarchy](https://arxiv.org/abs/2404.13208)
  7. [tips](https://oreil.ly/AF-Y1)
  8. [tips](https://oreil.ly/-HMpk)
  9. [tips](https://oreil.ly/DXAgC)
  10. [tips](https://oreil.ly/aFeyE)
  11. [anthropic lib](https://oreil.ly/PR9a3)
  12. [google lib](https://oreil.ly/CGyGU)
  13. [openAI lib](https://oreil.ly/WMn2L)
  14. [openAI Propmt-eng guide](https://oreil.ly/-u2Z5)
  15. [anthropic prompt guide](https://oreil.ly/yqAZs)
  16. [awesome prompt eng](https://github.com/f/awesome-chatgpt-prompts)
  17. [prompt hero](https://oreil.ly/q1EHt)
  18. [cursor dir](https://oreil.ly/J3Crv)
  19. [brex guide](https://github.com/brexhq/prompt-engineering?tab=readme-ov-file)



---