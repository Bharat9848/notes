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
- knowledge graph

## Phases of NLU
1. Tokenization:
2.  
 - stemming: 
 - lemmatization: try to understand the meaning through dictionary. e.g. word Universal and University should not be stemmed to universe.
3. part of speech tagging
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
### Extractive summarization and question answering
### Euphemism and pun recognition
### Humor and sarcasm recognition
### Hate speech and troll detection
### Logical entailment and fallacy recognition
### Knowledge extraction

### Machine translation with neural networks
 - use vector encoding then uses ANN to do the translation. 

### Spelling and grammar correction
 - Mispelled Word: first find dictionary words using edit distance then using context appropriateness choose the correct word.
 - Correctly spelled word but does not fit in overall sentence.


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

