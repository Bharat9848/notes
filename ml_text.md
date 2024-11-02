# Text
## Problems
 1. sentences with different structure have same meanings.
 2. text is unstructured
 3. What should be the different feature extraction strategy
 4. words ordering is important in a sentence but might get lost after feature extraction.
 5. Balancing problem - higher frequency word across all documents should be factored down.
 6. Balancing problem - bigger document should be normalized. 

## Feature extraction

- **common steps**
  - remove stop words like a, an, the, and etc
  - **unigram/Digram/trigram/ngram** associate two/three/N consequetive words for any strategy that follows. 
- **bag of words** strategy: count the unique word across all the documents after words removal.

## balancing problem.
 - Higher frequency word across all documents should be factored down by using **inverse-document frequency**. Its calculated using formula `log(len(docs)/freq)`