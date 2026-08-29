# LLMs
## Table of content
- [1. Model architecture](#1)
    - [1.1 Encoder](#1-1)
    - [1.2 Decoder](#1-2) 
- [2. LLM tuning](#2)

----
<a id="1"></a>
## Model architecture
### Seq2Seq Model
  - It is Recurrant Neural Network
  - Encoder takes the input and updates it internal state - called Thought vector.
  - Decoder take the Thought vector and generates the output in a recurrent manner - next output token takes input of last generated token alongwith thought vector.
  - Disadvantage: Thought vector is fixed in size so for longer text model tend to forget important part of the input. 

### Transformer model
Self-attention mechanism: It analyze entire sentence at once.
Input embedding: text is converted to a vector using token embedding model.
<a id="1-1"></a>
1. Encoder:
  - Tries to understand the deep meaning of input provided
  - **multi Attention head**: tries to understand different type of relationship between the words. It provides parallel reasoning over multiple relationship.
  - **Feed-forward networks**: "The Feed-Forward Networks consist of two linear transformations with a ReLU activation. It is applied independently to each position in the sequence." Capture complex non-linear patterns and relationships 
  - **Position vector**: "Unlike RNNs, transformers lack an inherent understanding of word order since they process data in parallel. To solve this problem Positional Encodings are added to token embeddings providing information about the position of each token within a sequence."
  - **Meaning guess vector**
  - Masked multi head attention
  - Positional encoding
  - input embedding
  - output embedding

<a id="1-2"></a>  
2. Decoder
  - chooses the next word based on encoder understanding

3. text is tokenized and vectorized.

4. `probability vector`: llm response is an indexed vector, where each index values specifies the likelihood probability of token at that index.   
#### Analogy for transformer model
- each token in a prompt is given to a minibrain. Minibrain knows token and position where it sits. Each minibrain build knowledge about the word and position in some series of steps called **layers**. During the knowledge build it receives information from minibrain to its left. At each series step except the last one it share information to its left. In last step it is tasked to generate a next token, but the token is already generated with some minibrain sitting over it except the last minibrain. Each minibrain goes through same steps and sharing results and in last generate next token - only input is different.
- Attention mechanism: is the intermediate layer output from minibrain which it shared with the minibrain next to it on right. Attention mechanism is controlled to prevent information explosion. As each minibrain can receive information from any minibrain which is left to it. Each layer represents different type of information gathering ???
- Information flows from left to right(minibrain info exchange) and from bottom to top(layerwise). Each step in any layer needs information from the left side minibrain on same layer level and information from the below layer in its own minibrain.


### Generative Pre-trained Tranformer model
 - Same as transformer model except encoder is missing.
 - Earlier version of GPT-2 have to specifically fine tuned for specific task to get good performance. But GPT-2 which is scaled up version of GPT was not required to fine tuned because of sheer data training volume and model parameter.

### Generative Adversarial Networks 
it have adversarial loop between its components that continues till satisfactory performance is achieved.
#### Generator:
- generates a sample and send it to discriminator
#### Discriminator  
- compare the sample from generator with the real data and return a score.

### Recurrent Neural Network
- suitable for sequential and time series data analysis.
- built-in loop help in model to remember

### Variational Auto encoder
#### Encoder:
- learns the pattern in data
#### Decoder
- decoder generate new data using learned encoded pattern.

### Diffusion model
- learn to remove noise and reconstruct distorted examples
- it relies on statistical properties 

----

## Model type
1. Instruct Model:
 - The RLHF model were called instruct models. They are confused with completion mode or instruct mode. Plain user question were confused to be either completed like completion model or return answer by assuming model in instruct mode. 

2. Chat Model
 - Sets a clear demarcation of instructions and chat in `system`, `user`, `assitant` and `function` message.
 - Tuned for to and fro kind of chats.
 - internally different message are translated to a markup language which makes llm easier to understand and fill.
 - Not mixing System and User messages in a single message prevents prompt injection. 

3. Completion model
 - Tuned to complete a sentence. 
 - e.g. `gpt-40`, `gpt-3.5-turbo-instruct` 

4. Reasoning model

5. Execution API: OpenAI will call external API interjects the API response in next prompt message. And call LLM again with new information.

 6. **Masked language model**(MLM): try to predict the missing information in between of a sentence. "well-known example of a masked language model is bidirectional encoder representations from transformers, or BERT (Devlin et al., 2018)". Used for sentiment analysis, text classification.
  Both REALM and ORQA are built on a clever combination of two components: A Masked Language Model (MLM) and A Differentiable Retriever — a component that fetches relevant documents from a large knowledge source (like Wikipedia) when given a question. The word "differentiable" is key — it means this retriever is not a hard-coded search engine, but a learnable component that improves through training alongside the language model.
  7. Autoregressive language model: try to predict next word. They are also called **Generative model**
  8. **Multimodel**: An llm that trained on different type of input other than text like image, audio etc.
  9. **Embedding Model**:
  10. **Foundational model**: From specific task to general purpose model.
  11. Reasoning model: generate reasoning token then returns the output.

----

## LLM Tuning configurations

  1. Temperature
    - it further adjusts the llm response probability vector by increasing or decreasing the probability of some of the token which have implication of creativity adjustment. Using formula `adjusted_probability(𝑝𝑖)=exp(log(𝑝𝑖)/temperature)/SumAll(exp(log(𝑝𝑖)/temperature))`
    - higher temperature decrease the probabilities of common words and increase the probabilities of rare words. Hence increase the creativity of responses.
    - Its value range from 0 to 2. 
    1. 0: Setting temperature to zero makes the model deterministic.
    2. 0.1-0.4: Useful when you want 2-3 different completion and each one are highly probable and you want to chose the best one. Or maybe you want single solution but which is creative at the same time.  
    3. 0.5-0.7 is the recommendation for sweet spot in creativity and predicatability. Some completion might be inaccurate. If you want large range of different solution.
    4. 1 : Makes the model return mirror of training set probabilities
    5. >1 : Make the model more random just trying to follow word after another. 
    - **Greed decoding**- choosing temparature 0 which increases the probability of top word very high.
     
  2. Top-p
  3. Top-k
  4. Repeation-penalty: It penalises on repeating words or phrases.
  5. logit biasing: Override some tokens probability and make model biased to the token.
  6. max_token: LLM stops generating response till some special token is generated or `max_token` limit is reached.
  7. `n`: for number of completion you want from the model. Default is 1.
  8. `stream`: returns the token as they are generated. It helps in good user experience.
  9. `stop`: a list of string which makes model stop producing anymore token once it generated any of the stop string.
  10. `top_log probs`: for each token generated return the top candidate and their respective log probs.
  11. `logprobs`: return the probability of each token generated.
  12. `echo`: return the log probability of prompt as well alongwith log probabilities of completion answwer.

----

## Model properties
  - **context-window**: Maximum number of token llm can process across input and output.
  - Model size: Number of parameters which defines model. Small model have 1-10 billion parameter while large one have 100-500 billion.
  - model parameters: 
    1. increasing model parameter increasing its capacity to learn. 
    2. `model parameter * parameter size` gives the GPU memory needed to make inference
    3. Model parameter is not good enough in case(for what ??) model is sparse means most of the parameters are zero.
  - model generation: signifies new version of model.
  - training dataset: 
    - measured in number of token to gauge the potency of dataset. 
    - Quantity, quality and diversity of token is proxy of potency of a model.
  - FLOPs: floating point operations required is a measure of the model cost.
  - Cost: fixed set of cost per million tokens.
  - Performance metrics:
    1. time to first token
    2. token per second.
  - Training cutoff date
  - When logprobs are available, use them. Logprobs can be used to measure how confident a model is about a generated token.


----
## Model quality
  - Benchmarks - Automated, human graded and LLM as a judge.
----
## Model API
- Inference service hosted by **Model API**

## Model distillation?
- A language model encodes statistical information about one or more languages.

----
# Training
1. Pretraining: training on lot of data.
2. Supervised Finetuning: training on high quality data
3. Reward modeling: Model learns to distinguish between good and bad answer.
4. Reinforcement learning: Refining of responses based on human feedback.

## Basic  
1. Test-time compute - Allocating more compute which allows LLM to generate multiple outputs which can be further sampled using some strategies.
2. LLMs are trained from the input itself using self-supervision - without explicit labeling of data.    
3. The set of all tokens a model can work with is the model’s vocabulary.
 
     
  - Types are instruction models GPT-4 series and reasoning model GPT-o series.
  - LLMs can only “remember” a limited chunk of text at a time. 

 
  - Cost: 100 tokens is approximately 75 words.
    - Pay per API use
    - pay per token 
  - autoregressive model
  - Reinforcement learning model
  - self reflection and error correction
  - plan generation vs reflection
  - Tool selection: no foolproof quide
  - Mixture of expert model: Model diviedes parameter into groups called expert and while inferencing only one expert is activated. Mixtral 8x7B means there are 8 experts each of 7B size. 

---
## Hallucination: 
1. To solve hallucination - RAG, guradrails, validator, human-in-the-loop and Fine tuning.
2. Detect hallucination: 
   - check factual information in the response after checking same question answer repeatedly.  
3. Hallucination focused benchmark.
4. Check llm response against knowledge-graph
----  


## Model in-built high level features
  -  Multimodality: The types of input the model can process (e.g., text, image, audio, video).
  - Tools/Function Calling: Whether the model supports function calling or tool use.
  - Streaming: If the model offers streaming responses.
  - Retry: Support for retry mechanisms.
  - Observability: Features for monitoring and debugging.
  - Native structured output support:
    - Built-in JSON: Native support for JSON output.
  - Local deployment: Whether the model can be run locally.
  - OpenAI API Compatibility: If the model is compatible with OpenAI’s API.
  - Caching: claude model supports caching of system, user, tools messages it prevents cached prompt to token conversion. Hence it helps in saving tokens and letency. E.g. Anthropic provides system message caching. 

----

## Post-training
  - It have a goal to tune the model to have conversation and removed any racist,sexist commentary from its internet
  - alignment training
  - Supervised finetuning(SFT)
  - Preference finetuning based on reinforcement learning from human feedback (RLHF) or Direct Preference Optimization(DPO)

----

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
  - [model quality optimization](https://developers.openai.com/api/docs/guides/model-optimization)
  - [fine tuning](https://developers.openai.com/api/docs/guides/supervised-fine-tuning#distilling-from-a-larger-model)
  - [chatgpt supervised learning](https://www.youtube.com/watch?v=bZQun8Y4L2A)


---


# Fine-tuning
- Domain specific training to create more specialized llms.
- Fine tuning llms are costly operation as it requires access to powerful hardware and highly curated domain specific data. HuggingFace provides friendly platform to host and train the model
- loss masking: Masking to allow only specific part of the document rather than other part of the document which can be fluff, background, history around the work.
- Finetuning API
- **Model Alignment** is process of fine tuning base-model to meet user expected behaviour - tone, less abusive etc.
## Supervised Fine Tuning
- The training method is similar to base model training. It adjust weights of the model.
- Training data is of very small size but teaches model to obey human instruction.
- **Alignment tax** The final RLHF model is dumber than the base model. To fix this some of the data from original training set is used while training RLHF.
## Reward Model
- It involves procured data set and SFT trained LLM is to complete on document. The model is asked to generate multiple completion on a higher temperature. Then human team judges the completions from best to worst. This ranked data is served as training data for reward model.
- Next the reward model is asked to chose the best among the two responses. It changes model weights as it learns the nuances of human judgement rules.
## RLHF
- Starting from SFT model, it is tasked to complete the prompts. Then the generated answer were judged by the reward model. Based on the score RLHF model weighs are tuned.
- To stop model to learn nuances on reward model Proximity Policy Optimization algorithm, which involve check that allow score to be used to change weighs only if the answer is not significantly diverged from SFT model output.
- RLHF model teaches model on how to be uncertain and certain on some answer it generates rather than always certain. 
## Low-Rank Adaption(LoRA) 
 - Does not change all the model parameters, instead focus on some key parameter matrices.
 - LORA dimension: A degree of freedom to the diff you train.
 - It changes already existing original model capability in certain way which are nuanced to the problem domain.
 - It requires hundred to thousands of examples.

## Soft Prompting:
 - using machine learning to learn new model weights. 
 - It requires hundred of examples.
 
## Dataset prep
- supervised fine-tuning:
  - Data with examples responses
  - instruction tuning to teach task following behaviour
## Type
- partial finetuning
- full finetuning

---
# Quantization
- reduces Model's parameters precision from 16 bit to 8 bit or 4 bit.
- It sacrifices little quality but gain the more latency and less memory.
- its also applied to embedding vectors namely in 1-bit vector embedding model combined with 
- Matryoshka quantization used in embedding models???
---
# LLM examples
- GPT: act as a decoder, adept in generating text and used in chatbot.
- BERT: utilize encoder only transformer architecture. understands word context in the sentence. used for sentiment-analysis and question answering
- BART/T5: follows both encode and decoder architecture. 
---

# LLM benchmarks
  1. Artificial Analysis LLM Performance Dashboard [at](https://artificialanalysis.ai/)
  2. chat bot arena
  3. Massive Multitask Language Understanding(MMLU) for domain specific reasoning
  4. Multi-Turn Benchmark (MT Branch)
  5. Open LLM Leaderboard - tracks open source language model on various NLU and generation task
  6. AI2 Reasoning challenges for complex scientic reasoning
  7. HellaSwag for common sense reasoning
  8. TruthfulQA for generative and informative responses
  9. WinoGrade for common sense reasoning
  10. Grade School Math 8k (GSM8K) for mathematical reasoning.
  11. [MTEB](https://huggingface.co/spaces/mteb/leaderboard): helps in model selection have metrics on llm perfromance on diverse tasks and domains.


---
# Foundation Model
# General 
- LLM suffered from **truth bias** - if you feed it wrong or false facts in the prompt it will assume the information provided is true and start to build on it.
- Though typos in the prompt can be easily handled by the LLM. But tokenizer will give different translation compared to the correct words.
- all capital words and all smallcase words are tokenized differently.
- End-of-text token are special reserved tokens for LLM to stop producing anymore text.
- LLM are autoreggresives mean last token is input for next input generation. It have two consequences - one Once LLM is committed to some token it can't take back. It will continue to extend on already generated token even though they can be wrong. Second is that if LLM generates a pattern by chance then it will continue to repeat the pattern for quite some time as the next most probable token for pattern token is continue the pattern.
- **Sampling**: process of choosing the next token given the all the candidate tokens with their probabilities.  
- **Beam search**: It is a kind of sampling. Before choosing next token it checks whether choosing the token make the next token afterwards more difficult.  In other words it takes few tokens to be generated into account before selecting current token. 

## Limitation
- Cannot answer facts which occurs after the training.
- Hard to return facts which are rarely mentioned in training corpus

## Usage
- Language Modeling Task
- Question-Answer Task

---
## Rough 
- single head attention model
- multi head attention model
- LLMs excel in language generation, requiring metrics tailored to natural language like BLEU, ROUGE, and perplexity.  
- AlexNet ? 
- Seq2Seq ?
- unlike previous methods that processed text linearly, transformers can handle words in parallel, capturing nuances in language through attention mechanisms.
- Both the inner architecture of the LLM (which encourages it to abstract from concrete examples) and the training procedure (which tries to feed it diverse, nonrepetitive data and measures success on unseen data) are supposed to prevent this defect.
- So when you want to know how a given prompt might be completed, don’t ask yourself how a reasonableperson would “reply” to the prompt but rather how a document that happens to start with the prompt might continue.