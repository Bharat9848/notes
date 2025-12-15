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

## Natural Langauage Generation

    Synonym substitution
    Answering frequently asked questions (information retrieval)
    Autocompleting sentences in emails and messages
    Retrieval-augmented generation
    Spelling and grammar correction

    Abstractive summarization and simplification
    Machine translation with neural networks
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


## Rough
- Term Frequency-Inverse Document Frequency (TF-IDF)
- lucene / BM25 
- lexical search: exact keyword search in sparse vector
- knowledge-intensive tasks in natural language processing (NLP), such as open-domain question answering, fact verification, and natural language inference.



