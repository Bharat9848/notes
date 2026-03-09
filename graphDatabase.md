# Graph database
## Data model
- Triplet (Entity, relationship entity2)
- entity have attributes
- **Ontology**: schema to define entity, relationships and attributes. they are represented using semantic network. It is a type of organizing principle

- graph: graphical representation of a domain data using entities and relationship b/w them. Node are entity or instances, edges are represented using relationship between nodes, tags are key/value pair associated with node and edges, properties are additional attribute associated with node and edges.
- organizing principle as a conceptual map or metadata layer overlaying the data and relationships in the graph.

## CYPHER query language
- Depth parameter: specify minimum and maximum number of hops wanted to reach from one node to another. Help in increasing query performance by preventing deep graph traversal.
- example query syntax
`MATCH path = (variableX:NodeTypeX)-[:RelationshipTypeX*<depth_parameter>]->(variableY: NodeTypeY)-[:RelationshipTypeY*<depth_parameter>]->(variableZ:NodeTypeZ)
WHERE variableX.name = 'Tim Cook'
RETURN variableX, variableY, variableZ, path;`


## Knowledge graph
- structured representation of facts using relationship between nodes.

## Property graph
## RDF
- This model does not support relationships with properties or multiple same-typed relationships between entities. 


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
- Wikidata
- freebase



# Tools
- Python-based spaCy library: ships with state-of-the-art statistical neural network models for part-of-speech tagging, dependency parsing, text categorization, and named-entity recognition.
````python
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

## Books and refrences
- The Practitioner's Guide to Graph Data: Applying Graph Thinking and Graph Technologies to Solve Complex Problems (Greyscale Indian Edition
- Building Knowledge Graphs: A Practitioner's Guide (Greyscale Indian Edition) 
- Knowledge-graphs[link](https://kgbook.org/)
- Knowledge Graphs: Fundamentals, Techniques, and Applications (Adaptive Computation and Machine Learning series)
- [courses](https://graphacademy.neo4j.com/)
- [podcast neo4j](https://github.com/jbarrasa/goingmeta/blob/main/README.md)

## Rough
- Leveraging Elastic’s ability to stack boolean queries, we check if the relation store contains at least one connection between any element linked to the first entity and any element linked to the second entity.?