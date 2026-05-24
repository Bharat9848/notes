## Lingo
- pre-trained seq2seq transformer ~ LLM
- a pre-trained neural retriever ~ embedding model
- Knowledge-intensive tasks—tasks that humans could not reasonably be expected to perfor without access to an external knowledge source.
- Marginalized: weighing of different option before taking decision

## Model
 - RAG sequence model: For each retrieved document generate the whole output. Then marginalize over generated outputs.
 - RAG token model: For each retrieved document generate singe next output token and marginalize over generated token generated per document.
 - Retriever is based on DPR uses BERT(base) document/query encoder
 - Generator is based on BART-large(pretrained seq2seq transformer with 400M parameter)
 - Training is done for retriever and generator -  ("Given a fine-tuning training corpus of input/output pairs `(xj, yj)`, we minimize the negative marginal log-likelihood of each target, `summation(− log p(yj |xj)` using stochastic
gradient descent with Adam [28]"). 
 - Decoding 
   1. Standard beam decoder used for per-token model.
   2. For per-sequence model, generated hypotheses using standard beam decoder
    - "This yields a set of hypotheses Y , some of which may not have appeared in the beams of all documents."  ???
    - "To estimate the probability of an hypothesis y we run an additional forward pass for each document z for which y does not appear in the beam, multiply generator probability with pη (z|x) and then sum the probabilities across beams for the marginals. We refer to this decoding procedure as \“Thorough Decoding.\”" ???

## Rough
- Ask LLM to explain
  - We compare two RAG formulations, one which conditions on the same retrieved passages across the whole generated sequence, and another which can use different passages per token.
  - Calculating top-k(pη (·|x)), the list of k documents z with highest prior probability pη (z|x), is a Maximum InnerProduct Search (MIPS) problem, which can be approximately solved in sub-linear time [23].

## Reference
- 20, 26, 48
- 33 59, 39
