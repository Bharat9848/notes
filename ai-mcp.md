# Model Context Protocol
## Glossary
1. Host: host typically is LLM host. It can interacts with multiple clients. Multiple clients can help in security and isolation concern for interaction with mutiple MCP server. 
2. Client:
3. Server:
4. MCP protocol: stateful session protocol, context exchange and sampling coordination

## About
- MCP ensures that relevant data flows smoothly between actions, tools etc and the language model.   
- Security: Do not allow AI to do what is outside of their limit like obtaining sensitive information, deleting data etc.
## MCP deployment
- MCP servers can be run in a serverless setup, storing session and connection info in Redis.??
## MCP protocol
- **host**: Host is an orchestrator managing sessions, agent lifecycle etc.
- **MCP client**: 
Agents uses MCP client to talk to external system. Agent does the following
1. Protocol version negotiation
2. Message transportation
3. capability negotiation
- **MCP server**: 
  - Server gives MCP response over 
    - prompt: domain specific prompt strategy,
    - resources are to serve static resource like API keys, glossary etc. they are used for - Provide contextual background (e.g., a list of predefined topics), Inject static configuration or preferences and support client-side filtering, choices, or menus.
     - tool/function(invoke some API, run sql query using sql client).
    - Server provides the discovery of functionality in a standard way. So that agent can leverage to learn about the servers capability. `tools/list`, `tools/call` and `resources/list`, `resources/read` are exposed as part of discovery.
    - Each endpoint is detailed out for its capabilities, permissions and data formats.
    - From MCP server to any third party API call, security is applied using either oauth 2.1 flow or API tokens

  - MCP Clients talks to MCP server using Standard Input/Output(STDIO) locally and Http with Server-Sent Event remotely with JSON-RPC 2.0 message formatting. 

### Session layer
- MCP client session 
- MCP server session
### Transport layer  
- Streamable HTTP: stateful and stateless
- HTTP/SSE
- STDIO
- JSON-RPC messages serialization and deserialization.
### mcp inspector
  - to run locally `docker run --rm --network host -p 6274:6274 -p 6277:6277 ghcr.io/modelcontextprotocol/inspector:latest`
### Resources
  1. list of mcpservers
    - [](https://mcpservers.org/)
    - [](https://smithery.ai/)
    - [](https://mcp.so/)
    - [](https://github.com/modelcontextprotocol/servers)
  2. [specification](https://modelcontextprotocol.io/specification/versioning)
  3. [python MCP SDK](https://github.com/jlowin/fastmcp) and [documentation](https://gofastmcp.com/getting-started/welcome)
  4. [](https://modelcontextprotocol.io/docs/develop/build-client#building-mcp-clients)
### Rough
  - OpenAI’s API natively supports tools provided by public MCP servers via the Responses API. Not only can you discover and reference these tools, but OpenAI will also execute them for you—eliminating the need for manual client code in many cases.
  - langchain `MultipleServerMCPClient`    


# Spring ai MCP annotations
1. for protocol documentation see ai-mcp.md
2. server annotaions:
   1. `@McpTool`
   2. `@McpResource`
   3. `@McpPrompt`
   4. `@McpComplete`
3. Client annotation
   1. `@McpLogging`
   2. `@McpSampling`
   3. `@McpElicitation`
   4. `@McpProgress`
   5. Client initialization ?
   6. client metadata name,version,enabled, request timeout, type, tool callback
4. Special Parameters
    1. McpSyncServerExchange, 
    2. McpAsyncServerExchange, 
    3. McpTransportContext, 
    4. McpMeta
5. Root change notificaition ??
6. tool callback