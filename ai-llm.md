# LLMs
## Table of content
- [1. TransformerModel architecture](#1)
    - [1.1 Encoder](#1-1)
    - [1.2 Decoder](#1-2) 
- [2. LLM tuning](#2)

----
<a id="1"></a>
## Transformer Model architecture

Self-attention mechanism: It analyze entire sentence at once.
Input embedding: text is converted to a vector.
<a id="1-1"></a>
1. Encoder:
  - Tries to understand the deep meaning of input provided
  - **multi Attention head**: tries to understand different type of relationship between the words. It provides parallel reasoning over multiple relationship.
  - **Feed-forward networks**: "The Feed-Forward Networks consist of two linear transformations with a ReLU activation. It is applied independently to each position in the sequence." Capture complex non-linear patterns and relationships 
  - **Position vector**: "Unlike RNNs, transformers lack an inherent understanding of word order since they process data in parallel. To solve this problem Positional Encodings are added to token embeddings providing information about the position of each token within a sequence."
  - **Meaning guess vector**

<a id="1-2"></a>  
2. Decoder
  - chooses the next word based on encoder understanding

3. text is tokenized and vectorized.

4. `probability vector`: llm response is an indexed vector, where each index values specifies the likelihood probability of token at that index.   
 
- AlexNet ? 
- Seq2Seq ? 
- Generative Adversarial Networks ?

----
<a id="2"></a>
## LLM Tuning configurations

  1. Temperature
    - it further adjusts the llm response probability vector by increasing or decreasing the probability of some of the token which have implication of creativity adjustment. Using formula `adjusted_probability(𝑝𝑖)=exp(log(𝑝𝑖)/temperature)/SumAll(exp(log(𝑝𝑖)/temperature))`
    - higher temperature decrease the probabilities of common words and increase the probabilities of rare words. Hence increase the creativity of responses.
    - its value range from 0 to 2. 
    - 0.7 is the recommendation for sweet spot in creativity and predicatability.
    - **Greed decoding**- choosing temparature 0 which increases the probability of top word very high.
     
  2. Top-p
  3. Top-k
  4. Repeation-penalty: It penalises on repeating words or phrases.
  5. logit biasing
  6. max_token: LLM stops generating response till some special token is generated or `max_token` limit is reached.

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

----
## Model quality
  - Benchmarks - Automated, human graded and LLM as a judge.
----
## Model API
- Inference service hosted by **Model API**

## Model distillation?
- A language model encodes statistical information about one or more languages.

## Type
  1. Masked language model: try to predict the missing information in between of a sentence. "well-known example of a masked language model is bidirectional encoder representations from transformers, or BERT (Devlin et al., 2018)". Used for sentiment analysis, text classification.
  2. Autoregressive language model: try to predict next word. They are also called **Generative model**
  3. **Multimodel**: An llm that trained on different type of input other than text like image, audio etc.
  4. **Embedding Model**:
  5. **Foundational model**: From specific task to general purpose model.
  6. Reasoning model: generate reasoning token then returns the output.

## Basic  
1. Test-time compute - Allocating more compute which allows LLM to generate multiple outputs which can be further sampled using some strategies.
2. LLMs are trained from the input itself using self-supervision - without explicit labeling of data.    
3. The set of all tokens a model can work with is the model’s vocabulary.
 
     
  - Types are instruction models GPT-4 series and reasoning model GPT-o series.
  - LLMs can only “remember” a limited chunk of text at a time. 

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
  - Built-in JSON: Native support for JSON output.
  - Local deployment: Whether the model can be run locally.
  - OpenAI API Compatibility: If the model is compatible with OpenAI’s API.
  - Caching: claude model supports caching of system, user, tools messages it prevents cached prompt to token conversion. Hence it helps in saving tokens and letency.  

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


---


# Fine-tuning
- Domain specific training to create more specialized llms.
- Fine tuning llms are costly operation as it requires access to powerful hardware and highly curated domain specific data.
- Finetuning API
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

## Rough 
- single head attention model
- multi head attention model