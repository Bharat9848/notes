# Graph database
## Basics
- Triplet (Entity, relationship entity2)
- entity have attributes
- ontology: schema to define entity, relationships and attributes
- graph: graphical representation of a domain data using entities and relationship b/w them. Node are entity or instances, edges are represented using relationship between nodes, tags are key/value pair associated with node and edges, properties are additional attribute associated with node and edges.

## Knowledge graph
- structured representation of facts using relationship between nodes.



# Examples
- neo4j: ACID compliant, Cypher is neo4j query language
- Apache TinkerPop
- ArangoDb
- SPARQL(SPARQL protocol and RDF query language)
- RDF Triples(Resource definition framework)
- OWL(web ontology language)

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