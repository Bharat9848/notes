# Deploy
`docker run \
    --restart always \
    --publish=7474:7474 --publish=7687:7687 \
    --env NEO4J_AUTH=neo4j/your_password \
    --volume=/path/to/your/data:/data \
    neo4j:2026.02.2`

# Vector index


# CYPHER Query
- Query a node with specific property value
    `Match (t: <NodeLabel> {<propertyName>: <queryvalue'>} Return t`
