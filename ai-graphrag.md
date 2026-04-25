- see paper notes kg-guided rag
 - ref[1](https://medium.com/neo4j)(https://medium.com/@oskarhane)(https://bratanic-tomaz.medium.com/)

 - steps
   1. node and relation extraction
      spacy
      LLM prompt
   2. Vector index building
      - triplet can be linearized and embed using same embedding model
      - Graph clustering summarization is linearized and store as embedding   
   3. Query preprocessing
      - plain query is transformed in triplets based Cypher query language through llm using Named Entity Recoginiton(NER) pipeline. 
   4. Querying 
      - simple query: how many hops to reach from the subject of the query
      - multi entities query: below flowchart for the process. and also limit the worst case scenario of repeat process to 3 (based on research every person is related to other through a path of length 6).
      ```mermaid
          flowchart TB
            Start --> id1{Direct relationship b/w main entities A and B?}
            id1 --yes--> Result
            id1 --"no"--> B[Find related entities of A and B using filter queries]
            B --> C{Related entities of A connected to related entities of B ?}
            C --yes--> Result
            C --"no"--> D[Repeat process using direct neighbour of A and B]
            D ---> Start
            Result --> End
      ``` 
      - result is subgraph which requires further size reduction
        1. select nodes that are on shortest path b/w interested parties
        2. apply graph pruing algorithm to reduce relations futher.
           - not to reduce number of short path.
           - maintain diversity in the result.  
    5. Graph text linearization
      - Pseudo documents are created using path linearization between entities.
      - collect most relevant entities from the graph linked to asked entities by using a filtered ES KNN approach.


## References
 - [neo4j text2cypher](https://huggingface.co/neo4j) 
 - [text2cypher fine tuning](https://medium.com/neo4j/introducing-the-fine-tuned-neo4j-text2cypher-2024-model-b2203d1173b0)

----

# Data Pipeline

## Knowledge preparation
1. Infromation extraction
  - Using LLM: Unstructured data to structured data(json|yaml) using defined data model with the help of llm.
2. Using structured data then translate to KG ontology specification.

----

