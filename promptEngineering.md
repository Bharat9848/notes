# prompt engineering
----
## Best practices
  1. Beware of many new reasoning models often struggles with in-context learning and examples in prompt. They requires clear goals and strict format
  2. Repeat the important instruction above and bottom of prompt as llm tends to forgot older prompt.  LLM have quadratically scaling attention-bias mechanism due to which llm are not performative on longer prompts.Repeat important aspects. Experiments have shown that llm put good attention to the top and bottom of the prompt and it is lost in the middle.
  3. Be specific rather than adding not-to-do instructions in the prompt e.g. We want summarization or we want step by step guides.
  4. Prompt grammer
    - Adding and removing keywords like adjectives etc.  
    - Try changing and rephrasing words:
    - rearranging words:
    - Clear syntax involves using good verbs to explain intent precisely.
    - combining and splitting words: Breaking down complex task.
    - check prompts for typos and bad grammer in prompt.
  5. Instruct for exit path for unclear situation.
  6. Output generation syntax should be clean and demarcated. Using separator in different part of prompt. Using markdown markation to define section and subsection.
 
----

## Context window management 
 - convesation history can run out of context window. Techiques like conversation pruning e.g. to include only last N messages or summarize the conversation through llm.
 - turn off reasoning.
 - keep track of input and output token length.
----
## Prompt structure 
  - Templates are model specific and are defined in model documentaion.
  1. System prompt
    - A well structured prompt includes Role or persona, context, text, tone, instructions, and output format
    - Instruction can be the one or more from the following
      1. answer in great details
      2. answer succinctly or concisely.
      3. use only context to answer the question.
      4. cite sources in the response
    - Tone: specify the desired tone of the LLM's answer—formal, informal, witty, enthusiastic, sober, friendly, etc. Combinations are possible.
    - Instruct output using examples - use markers to mark the end of the prompts to let the model know that the structured outputs should begin, following the example. e.g `3*8 = 24\n4*8 = 32\n` followed by question `5*8=`
  2. Prompt type can be `System`, `User` or `Assistent`. 
----

## Prompt template  
 ````
 # System Instruction
 ## Role or Persona
 ## Higher level action
 ## Rules
  - how to use tools/example/context 

 ## examples
 ## conversation history
 [if conversation_history exists]
 User: [message_1]
 Assitant: [response_1]
 User: [message_2]
 Assitant: [response_2]

 ## Retrieved Information
 [Document 1]
 [chunk_1_text]
 source:[chunk1_1_source]

 ## Output format

 # User prompt
 User: [user query]
 ````

## Model properties prerequisite
  - Instruction following capability:
  - Robustness: It measures model output changes on slightest changes of prompt.


---


## In-context learning
It includes **few-shot learning** with **chain of thought** in the prompt to make llm figure out any unknown task.
### Few shot learning  
  - zero shot learning: when llm is able to answer without any examples in the prompts.
  - few-shot examples: whem we provide llm with few `examples` to facilitate different scenarios or augment its knowledge.
  - selecting random labels and input text from true distribution is more effective than using uniform examples.
  - Structure and format of example is also very important.
  - in-context learning [paper](https://arxiv.org/abs/2005.14165)

### Chain of Thought (COT)
  - **few shot COT**: different examples form problem space with answer explaining using COT before giving final answer.
  - It improves how language models handle complex reasoning by breaking problems into smaller, logical steps. 
  - However, it has limitations, such as missing deeper exploration or struggling with messy contexts. Two advanced techniques address these gaps: Tree of Thought (ToT) and Thread of Thought (ThoT): 
  - More complex the model is less examples it requires. However examples are necessary for domain specific learning.
  - It increases cost.
  - COT elicites reasoning [link](https://arxiv.org/abs/2201.11903)
  - reduce hallicuniation [link](https://www.linkedin.com/blog/engineering/generative-ai/musings-on-building-a-generative-ai-product)
### self critique prompt
  - "explain your decision"
  - increases cost  
### Self consistency prompt
 - asks llm to generate multiple different answer and explanation and then choose the most consistent output.
---

## prompt decomposition
  - Alternative to chain-of-thought learning, we break complex task into simple subtasks can lead to better result than to give one complex task.
  - helps in better debugging, parallelization, monitoring and effort
  - disadvantages are increased latency and cost.

---  
## Prompt Testing

  - Testing prompts against
    1. biases:llm reflect biases of ther training data.
    2. Quantifying quality:
    3. overfitting: model response is echoing more on the lines of prompt rather than some novel answer.
    4. Limitation model token
    5. prompt sensitivity: slight change in prompt have catastrophic effect on llm responses.

### use case type and prompt samples

  | type                | example                                                   |
  | ------------------- | --------------------------------------------------------- |
  | Text classification |Classify the following text into one of these categories...|
  | Sentiment analysis | Classify the following text as positive, neutral or negative |
  | Text summarization | Write a 30 word summary for the following text  | 
  | Composing Text     | Write a piece on the ..., mentioning the following facts  |
  | Question answering | read the following and tell me ... | 
  | plan generation | Think step by step               |
  | Reflection      | verify if your answer is correct |
  - see prompt repo 

---

## context prompt (RAG prompt)
  - Strictly use context for any factual infomation.
  - return citation after end of each factual response.
  - use external tools like contextcite to evaluate response based on context.

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
    - Not all prompt parts are important [1](https://arxiv.org/abs/2307.03172) 
    - needle in a hay stack test
    - RULER[1](https://arxiv.org/abs/2404.06654)

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

## Image prompting
1. content:
2. art form: water-colored or pixed art
3. style: lightening, color and lighting or more information about content

---