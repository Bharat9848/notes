## Preprocessing
- removal of stop words - stop words are common words like is,the etc which do not carry much meaning. In some poblems this step is not required as they provide meaning to a sentences.
- Stemming - remove the word to its basic form. e.g. swimming will become swim 
- lemmatization - it can morph the word to return it to basic of word called lemma.e.g. ran will become run etc. Unlike stemming lemmatization is more concise so that word do not lost its meaning in the context of a sentence.
- data normalization: remove punctuation, lowercasing and standardizing the format, spelling corrections, remove special characters, digit to words- 2 will become two, remove any encoding like html tags etc.
- data cleaning: removing duplicate and irrelevant data.
- lower caseing every word make the data case agnostic
- punctuation: all different type of punctuation `?!.,` can be replaced with `.`
- Numbers: depending on the problem numbers can be removed or kept as it is or replaced with special tag e.g. `<number>`.
- remove special characters
- special words like emoji or hash tags can be removed or kept as it is.

## Usecase
1. Text classification to predefined categories e.g. sentiment recognition.
2. Information retrieval:
3. Name entity recognition:
4. Machine translation

## Vector space encoding
- Captures the relationship
- captures the meaning - synonym and antonyms are placed closely in vector space.
- coocurrance matrix: matrix to show word vs word and max distance till certain threshold distance, beyond threshold distance words are supposed to not co-occur.
- word by document category frequency tells how relevant a word to a document category

## Basics
- Term
- Grammer
- ontology
- knowledge graph: A data structure that represents concepts and entities as `nodes` and `relationship` betwee nodes to represents any relational information between entities.  

## ML algorithm
- Statistical Language Modeling: text generation, machine translation and speech recognition 
## Deep Learning
- Recurrent Neural Networks and Convolutional Neural Network for language understanding, text summarization and sentiment analysis


## Phases of NLU
1. Tokenization:
2.  
 - stemming: 
 - lemmatization: try to understand the meaning through dictionary. e.g. word Universal and University should not be stemmed to universe.
3. Part Of Speech Tagging(POS Tagging): 
  - used for named entity recoginition, Speech recognition and conference resolution 
4. Named entity reconginition 

## Natural Language Understanding
- subfield of NLP that deals with machine understanding of unstructured sentences
- Translate text into semantic meaninful vectors.
- scikit-learn `Vectorizer`, `token-count vector`, `token frequency vector`, `embedding`
### Semantic search

### paraphrase recognition
### intent classification
### Sentiment analysis
- logistic regression and naive bayes ML algorithm can be used.

### Topic Modeling
### Authorship distribution
### Analogy problem solving
### Reading comprehension
### Extractive summarization and question answering and abstractive question-answering

### Euphemism and pun recognition
### Humor and sarcasm recognition
### Hate speech and troll detection
### Logical entailment and fallacy recognition
### Knowledge extraction
### Jeopardy Question Generation:

### Machine translation with neural networks
 - use vector encoding then uses ANN to do the translation. 

### Spelling and grammar correction
 - Mispelled Word: first find dictionary words using edit distance then using context appropriateness choose the correct word.
 - Even though word is correct but does not fit in overall sentence or context.

 - The goal of our spell check model is to compute the following probability: `𝑃(𝑐|𝑤)=𝑃(𝑤|𝑐)×𝑃(𝑐)𝑃(𝑤)`.The equation above is Bayes Rule: probability of a word being correct 𝑃(𝑐|𝑤)is equal to the probability of having a certain word 𝑤, given that it is correct 𝑃(𝑤|𝑐), multiplied by the probability of being correct in general 𝑃(𝐶) divided by the probability of that word 𝑤 appearing 𝑃(𝑤) in general. Then choose from words from edit distance algorithm with highest `P(c|w)` 
 

## Natural Langauage Generation

    Synonym substitution
    Answering frequently asked questions (information retrieval)
    Autocompleting sentences in emails and messages
    Retrieval-augmented generation
    

    Abstractive summarization and simplification
    
    Sentence paraphrasing
    Therapeutic conversational AI
    Factual question generation
    Discussion facilitation and moderation
    Argumentative essay writing

    Participating in debate on social media
    Automatically summarizing long technical documents
    Composing natural-sounding poetry and song lyrics
    Composing jokes and sarcastic comments
    Composing programming language expressions from natural language descriptions

## Tools
 - Home assistant
 - Mycroft AI

## References
 - 41,42,43

## Practice
  1. python library (nltk)[https://www.nltk.org/data.html]. It comes with lot of data corpus. You can download the corpus by calling `nltk.download()`
  2. python library (spaCy)[https://spacy.io/usage/models/.] for  named entity recognition, chunking text using different linguistic theories, such as phrase structure grammar and dependency grammar.It offers general purpose language model small `en_core_web_sm`, medium `en_core_web_md` and large `en_core_web_lg` use `python -m spacy download en_core_web_sm`
  3. `sentence-transformers`

## Dataset
 - [hotpot QA](https://github.com/hotpotqa/hotpot/blob/master/README.md)
 - [wikimedia](https://dumps.wikimedia.org/)
 - [triviaQA](http://nlp.cs.washington.edu/triviaqa/)
 - Argument retrieval (ArguAna)
 - Climate fact retrieval (ClimateFEVER)
 - Duplicate question retrieval (CQADupstackRetrieval)
 - Entity retrieval (DBPedia)
 - Fact extraction and verification (FEVER)
 - Financial question-answering (FiQA2018)
 - Multi-hop question-answering (HotpotQA)
 - Passage and document ranking (MSMARCO)
 - Fact-checking (NFCorpus)
 - Open-domain question-answering (NQ) 
 - Duplicate-question detection (QuoraRetrieval)
 - Scientific document retrieval (SCIDOCS)
 - Scientific claim verification (SciFact)
 - Argument retrieval (Touche2020)
 - COVID-19-related information retrieval (TRECCOVID)
 - multiple dataset download [link](https://github.com/beir-cellar/beir/wiki/Datasets-available) 
 - books review to rating(https://oreil.ly/7Vx_A)

## Rough
- Term Frequency-Inverse Document Frequency (TF-IDF)
- lucene / BM25 
- lexical search: exact keyword search in sparse vector
- knowledge-intensive tasks in natural language processing (NLP), such as open-domain question answering, fact verification, and natural language inference.

## Books
- Speech and Language Processing 2nd Edition by Jurafsky Daniel, Martin James H., Norvig Peter, Russell Stuart


## ANN implementation
 - take random planes m as row vectors matrix R. Each vector represents a vector perpendicular to plane.
 - calculate `Y_pred = XR - Y`
 - cost function is Frobenius norm of `XR - Y`. since norm applies sqrt to the matrix. To make calculation easy we use square of Frobenius norm as cost function divided by number of planes. 
----

## Part Of Speech Tagging
- helps in understanding the meaning of a sentence
- Tagging is difficult because some words can represent more than one part of speech at different times. We need to understand the context of word in a sentence.
- POS tagging is a technique to help understanding the context of a sentence and help in various NLP categories of problem like entity recognition, speech recognition and confrence resolution
- POS tagging involves tagging lexical term shorts like NN(noun), VB(verb) etc to a input. 
- Probabilities of POS tags is calculated with the help fo Viterbi algorithm  

### Hidden Markov Model (HMM)
- A Directed Graphs representation where node represents states and edge represents the probability of state transitioning. States for POS tagging are lexical tags and one additional start empty state. 
1. Transition Matrix 
- POS State Graph is represented with a adjacency matrix called Transition matrix.
- In Transition matrix current state is represented as rows and columns as next state. 
- Dimensions would be (N+1, N) where N being number of tags and 1 additional row for empty start state. 
- Values represent the transitioning probabilities. 
  1. For each POS tag we calculate number of adjacents other tags to it. It will give count of (tag-1, tag-i) where i is 1 to N, N being number of tag. 
  2. We calculate the probability of current tag to some other tag and start filling the row for the current tag.
  ```math
    Prob(t|ti-1) = (count(ti-1, ti) + epsillon/ sum-all(for j = 1 to N)(count(ti-1, tj)) + N*epsillon
  ````
  3. We apply smoothing to remove division by zero in case e.g. a particular tag is missing in input. Epsillon in numerator and denominator is for smoothing.

2. Emission Matrix - It is calculated with the help of transition matrix and a hidden markov model which use emission probabilities to calculate transition from current POV tag to a specific word. 
```math
  Prob(wi|ti) = (count(ti, wi) + epsillon) / sum-all(for j = 1 to V) Count(ti, wj) + N *epsillon 
  where V is number of words
```
Its dimension are (N, V) where N being number of POS tag and V be number of words in vocab.

### The Viterbi Algorithm
- calculate the most likly POS sequencing of a sentence by maximizing the probability at each word of sentence.
- It uses two intermediate matrix one that traces the last position it come from and one where it holds the max probability. Both intermediate matrix are of dimensions (pos, words)
- Roughly for veterbi algorithm steps are as follows to calculate a sentence highest probability
  - prevPos = start state
  - For each position
     `overallProb *=  (prevPOS, currentPOS) transitioning probability * emission probability of current POS to current word.` 
 
----

## N gram language model
- based on calculating probability of N gram in a corpus.
- Probability of a sentence
  ```math
  # sequence probability - w1 followed by w2 then w2 followed by w3
  # Notations 
    P(w1, w2, w3) ~ P(w1^3) # starting from w1 count 3 words
  # Formula
    P(w1, w2, w3) = P(w1)*P(w2|w1)*P(w3|w1,w2) # Chain rule and conditional probability   
    P(w3|w1, w2) = Count(w1, w2, w3) / sumall(x)(count(w1, w2, x)) ~ Count(w1, w2, w3) / count(w1, w2) # summation will nullnify x's effect 
  ```
- practically it requires lot of RAM and space instead RNN is used in industry.  
- **Markov assumption** 
  - Since longer the sentences it is very likely the occurance of whole sentence occuring in corpus is zero makes the whole probability of a sentence zero.
  - Instead using Markov assumption we can approximate the probability of sentence by rewriting conditional probability of longer subsequence to check only few previous words instead of whole prefix.
  ```math
    # Markov assumption
    P(w4| w3, w2, w1) ~ P(w4|w3) # bigram check only previous word.
    P(w4|w3. w2, w1) ~ P(w4|w3,w2) # trigram check only two previous words.
    P(wn|wn-1, wn-2, wn-3....) ~ P(w|wn-N+1^N) # N-gram check only N previous words
  ```
- Sequence probability after Markov assumption
```math
  # sequence probability - w1 followed by w2 then w2 followed by w3

  # previous Formula
    P(w1, w2, w3, w4) = P(w1) * P(w2|w1) * P(w3|w1,w2) * P(w4|w3,w2,w1)    
  # New formula using bigram Markov assumption 
    P(w1, w2, w3, w4) = P(w1) * P(w2|w2) * P(w3|w2) * P(w4|w3)
  ```
- Simplification of N-gram probability formula 
  - Assumes there is a starting tag `<s>` and ending tag `</s>` after each sentence.
  ```math  
  P(w1, w2, w3) = P(<s>, w1, w2, w3, </s>) = P(w1|<s>) *  P(w2|w1) * P(w3|w2) * P(</s>|w3) = ProductAll(i)(P(wi| wi-1))       # for seq probability with bigram 
  P(w1, w2, w3) = P(<s>,<s>, w1, w2, w3, </s>) = P(w1|<s>, <s>) *  P(w2|w1,<s>) * P(w3|w2, w1) * P(</s>|w3, w2) = ProductAll(i)P(wi|wi-1, wi-2)
  # for seq probability with trigram 
  ```
- N-gram language model
  1. calculates probility of N gram using `probability matrix`
  2. Probability matrix calculation
    1. create count matrix
    ```math
      # Rows represents all N-1 word sequence occur in corpus
      # Column represent all the unique words
      Count(i,j) = count(i,j) + 1 # when ith row subsequnce is followed by jth column representing word while iterating over corpus
    ```
    2. create probability matrix by dividing each cell in count matrix with row sum. 
  3. use `probability matrix` for various task like sentence completion, sentence probability calculation, sentence generation etc.

- Out of vocabulary words 
  - words might occur in test set/ real world which model have not seen in training set.
  - Create vocabulary based on following herusitics
    - in training set consider words to consider vocabulary which have some minimum frequency and mark other as `<UNK>`
    - fix the size of vocabulary and choose words with highest frequency till vocubulary size limit breached.  
  - After creating vocabulary mark words in training set which are outside vocabulary with `<UNK>` and train the model.

- How to handle missing N-grams in training corpus
  1. Interpolation:
    - it takes the weighted average of higher order N-gram to lower order N gram down till unigram.
    - ```math
        P(wn|wn-2 wn-1) = lambda1 * P(wn|wn-2 wn-1) + lamdba2*P(wn|wn-1) + lambda3*P(wn)
        sumAll(1 to N)(lambdai) = 1 
      ``` 
  2. Backoff
    - If N-gram is missing then use N-1 gram probability, if N-1 gram probabilty is missing then use N-2 gram probabilty and so on till unigram probability. Backoff distorts the probability therefore they are used with discounting also called **katz backoff**.
    - **Stupid backoff** if higher order N-gram probability is missing then lower order N-gram is multiplied by a constant. `0.4` as discounting factor has shown the good result.
  3. Smoothing: 
    - add 1 smoothing 
    - add K smoothing: make the probability distribution less spiky 


- Evaluation of N-gram language model
  - always compare models with same vocabulary size.
  1. divide the data into training, validation and test data. For smaller corpus data split in 80,10 and 10 percent for traing, validation and test data percentage respectively. For bigger corpus data split in 98, 1 and 1 percent for traing, validation and test data percentage respectively.
  2. Calculate Probability score for test data sentences.
  3. Use **perplexity** to measure complexity of for each sentence in test set and multiply them.
     - perplexity formula
       ```math
          PerplexityScore = P(sentence)^(1/(-m)) # m is number of word in sentence
       ```  
     - or use log perplexity
        
----

## Word embedding
- Training data consist of not just vocabulary but the whole context which gives meaning to words in vocabulary.
- embedding model can be machine learning model but there are other type of models as well.
"""
  Classical Methods

    word2vec (Google, 2013)

    Continuous bag-of-words (CBOW): the model learns to predict the center word given some context words.

    Continuous skip-gram / Skip-gram with negative sampling (SGNS): the model learns to predict the words surrounding a given input word.

    Global Vectors (GloVe) (Stanford, 2014): factorizes the logarithm of the corpus's word co-occurrence matrix,  similar to the count matrix you’ve used before.

    fastText (Facebook, 2016): based on the skip-gram model and takes into account the structure of words by representing words as an n-gram of characters. It supports out-of-vocabulary (OOV) words.

Deep learning, contextual embeddings

 In these more advanced models, words have different embeddings depending on their context. You can download pre-trained embeddings for the following models. 

    BERT (Google, 2018):

    ELMo (Allen Institute for AI, 2018)

    GPT-2 (OpenAI, 2018)
"""
### Continous Bag Of Word Model (CBOW)
- corpus is divided into window. Each `window` will have a `centered word` and n/2 words before and after centered word as `context`.
- Neural network for CBOW
  - X is average of all context vectors, Y is the predicted centered word. X,Y are of vocabulary size.
  - One hidden layer with chosen embedding size.
  - input to hidden layer activation function is ReLU and hidden to output layer is softmax.
- Evaluation
  1. Intrinsic evaluation checks for semantic(meaning) and syntatic(grammer) relationships between words. 
  2. Extrinsic evaluation use actual task for evaluation like named entity recognition etc.


----
## Infromation extraction
- using LLM
----

## Entity resolution
- resolution of an entity represented using different spelling variation etc.
- using 
  1. clustering algorithm
  2. String matching
  3. Machine learning
