# Model Context Protocol
## Glossary
1. Host: host typically is LLM host or an AI application which can interacts with multiple MCP server via multiple client each server. 
2. Client:
3. Server:
4. MCP protocol: stateful session protocol, context exchange and sampling coordination

## About
- MCP ensures that relevant data flows smoothly between actions, tools etc and the language model.   
- Security: Do not allow AI to do what is outside of their limit like obtaining sensitive information, deleting data etc.

## MCP deployment
- MCP servers can be run in a serverless setup, storing session and connection info in Redis.??
----
# MCP Protocol
## MCP entities
### MCP Host  
- Host is an orchestrator managing sessions, agent lifecycle etc.
- Host uses MCP clients to talk to external system. Host does the following
1. Protocol version negotiation
2. Message transportation
3. capability negotiation

### MCP Client
- Maintain connection with MCP server
- Maintain context from server to get used by host. 

### MCP Server 
  - Server gives MCP response using 
    - prompt: domain specific prompt strategy,
    - resources are to serve static resource like API keys, glossary etc. they are used for - Provide contextual background (e.g., a list of predefined topics), Inject static configuration or preferences and support client-side filtering, choices, or menus.
     - tool/function(invoke some API, run sql query using sql client).
    - Server provides the discovery of functionality in a standard way. So that agent can leverage to learn about the servers capability. `tools/list`, `tools/call` and `resources/list`, `resources/read` are exposed as part of discovery.
  - Each endpoint is detailed out for its capabilities, permissions and data formats.

----

# Layers

## Session layer
 - MCP client session 
 - MCP server session


## Transport Layer
 - Defines transfer specific connection estabilishment, message framing and authorization  
 - JSON-RPC messages serialization and deserialization.
### Streamable HTTP: 
 - stateful and stateless
 -  optional Server Side Event(SSE) for streaming capability
### STDIO
 - standard input/output stream for local process communication.

## Data layer
 - defines json-rpc protocol for 
   1. lifecycle managment - it includes connection initialization, capability negotiation, connection termination
   2. Specification for server to expose various tools, resources, prompts as context to AI. They are defined using MCP primitives.
   3. Client features: Enables servers to ask the client to sample from the host LLM, elicit input from the user, and log messages to the client ???
   4. Notifications for real-time updates and progress tracking for long-running operations. It is usually one way message which would requires no reply. 
### Lifecycle Management
 - initialization sequence. 
   - Client starts initialization sequence with method `initialize` alongwith its own capabilities, protocol version, client info, messageId etc.
   - Server sends similar response with same id and similar information.
   - protocol version of client and server should be compatible. 
   - Server should declares its primitive and notification cababilities while client should declare elicitation capabilities.
   - Client info and server info to exchange their identity information.
   - After sucessful handshake. Client sends intialization complete notification.
 - Client/server stores each other capabilities for later use.
 - Client then sends `tools/list` request for tool related information given server send supports tools during initialization exchange. 

### MCP Primitives
 - Tool primitive
 - Resource primitive for returing any static information like file content, database schema etc.
 - Prompt primitive
 - Sampling primitive: Allow server to use language model completion via `sampling/complete`
 - Elicitation primitive: For any user's additional information, server can invoke `elicitation/request` which will cause LLM to ask for more information from the user.
 - Logging primitive: exposed by server to send log messages to LLM.
 - Primitive can be manipulated via 
   1. `tools/list` API for discovery. 
   2. `/get` to get resources or prompt
   3. `/call` for tool execution
 - `tools/list` method response from server contains the list of all available tools information. Each tool response object should have `name`, `title`, `description` and `inputSchema`.  
 - After registering available tools, client invokes `tool/call` with `params` containing tool `name` and its `arguments`. Server sends the response in `result` with `content` array which further specifies content `type` and actual content. `type` can be text, image, video  
### Notification
 - any tool related changes: Given server declares `listChanged:true` capability during initialization, server can do `notifications/tool/list_changed` method invocation when required. Notification messages are without any `id` field. 
 - progress on tasks 
 - one way communication from either sides which allows real time synchronization between server and client capabilities.  

----

# MCP Security
 - From MCP server to any third party API call, security is applied using either oauth 2.1 flow or API tokens.

### MCP Inspector
  - to run locally `docker run --rm --network host -p 6274:6274 -p 6277:6277 ghcr.io/modelcontextprotocol/inspector:latest`

### Resources
  1. list of mcpservers
    - [](https://mcpservers.org/)
    - [](https://smithery.ai/)
    - [](https://mcp.so/)
    - [](https://github.com/modelcontextprotocol)
  2. [specification](https://modelcontextprotocol.io/specification/versioning)
  3. [python MCP SDK](https://github.com/jlowin/fastmcp) and [documentation](https://gofastmcp.com/getting-started/welcome)
  4. [](https://modelcontextprotocol.io/docs/develop/build-client#building-mcp-clients)
### Rough
  - OpenAI’s API natively supports tools provided by public MCP servers via the Responses API. Not only can you discover and reference these tools, but OpenAI will also execute them for you—eliminating the need for manual client code in many cases.
  - langchain `MultipleServerMCPClient`    
  - mcp manifest

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