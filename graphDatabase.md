# Graph database

# Examples
- neo4j
- Apache TinkerPop
- ArangoDb
- SPARQL
- RDF Triples.

# Existing knowledge graph as plugin
- ConceptNet
- DBpedia
- Any LLM
- Yago

# Tools
- Python-based spaCy library: ships with state-of-the-art statistical neural network models for part-of-speech tagging, dependency parsing, text categorization, and named-entity recognition.
````
def extract_relationships(text, lang_model, coref_model):
  resolved_text = resolve_coreferences(text, coref_model)
  sentences = get_sentences(resolved_text, lang_model)
  return resolve_facts(sentences, lang_model)

text = """
Data Scientists build machine learning models. They also write code.
Companies employ Data Scientists.
Software Engineers also write code. Companies employ Software Engineers.
"""
lang_model = spacy.load("en_core_web_sm")
coref_model = spacy.load("en_coreference_web_trf")
graph = extract_relationships(text, lang_model, coref_model)
print(graph)
````