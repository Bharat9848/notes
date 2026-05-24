# Model Context Protocol

## About
- MCP ensures that relevant data flows smoothly between actions, tools etc and the language model.   
- Security: Do not allow AI to do what is outside of their limit like obtaining sensitive information, deleting data etc.

## MCP deployment
- MCP servers can be run in a serverless setup, storing session and connection info in Redis.??

## MCP Resource Type
1. Tools: Query/Modify to effect dynamic data sources like databases, API etc. Tools execution is controlled by LLM. However there might be scenario where users permission is necessary - there are various mechanism through which LLM can obtain user permission. Some are as following
  - Displaying tools through UI and explicit allow tools per conversation.
  - Approval prompted to user for tool execution by LLM
  - Through setting to allow/disallow certain tools.
  - Passively log all the tool interactions.  

2. Prompts: "Pre-built instruction templates that tell the model to work with specific tools and resources." User driven.
3. Resources: Passive data sources include reading API documentation, database schemas, files etc. Application controls the resource access, it can decide what to send to the model- processing with embedding then search on it or passes the whole document.

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
#### MCP Client Features
 1. **Elicitation**: Its for extra information/feature that server can offer to the user. It is more dynamic and responsive workflows.
 2. **Roots**: Specialized directories on host system that server can access. It is recommended to use `file://` URI. LLM can create some directories in root structure and store some files which server can access. 
 3. **Sampling**: Allow server to request LLM completion. For some of the tasks like user permission. Server can invoke smapling primitives to allow client to have complete control and handle the task on server behalf. It occur in context of other operation and processed as separate Model call. Sampling is designed for human-in-the-loop control client can show the whole LLM server request to the user to approve or deny any application. Client should also do rate limiting on server. 

### MCP Server 
  - Server gives MCP response using 
    - prompt: domain specific prompt strategy,
    - resources are to serve static resource like API keys, glossary etc. they are used for - Provide contextual background (e.g., a list of predefined topics), Inject static configuration or preferences and support client-side filtering, choices, or menus.
     - tool/function(invoke some API, run sql query using sql client).
    - Server provides the discovery of functionality in a standard way. So that agent can leverage to learn about the servers capability. `tools/list`, `tools/call` and `resources/list`, `resources/read` are exposed as part of discovery.
  - Each endpoint is detailed out for its capabilities, permissions and data formats.

## Layers

### Session layer
 - MCP client session 
 - MCP server session


### Transport Layer
 - Defines transfer specific connection estabilishment, message framing and authorization  
 - JSON-RPC messages serialization and deserialization.
#### Streamable HTTP: 
 - stateful and stateless
 -  optional Server Side Event(SSE) for streaming capability
#### STDIO
 - standard input/output stream for local process communication.

### Data layer
 - defines json-rpc protocol for 
   1. lifecycle managment - it includes connection initialization, capability negotiation, connection termination
   2. Specification for server to expose various tools, resources, prompts as context to AI. They are defined using MCP primitives.
   3. Client features: Enables servers to ask the client to sample from the host LLM, elicit input from the user, and log messages to the client ???
   4. Notifications for real-time updates and progress tracking for long-running operations. It is usually one way message which would requires no reply. 

#### Lifecycle Management
 - initialization sequence. 
   - Client starts initialization sequence with method `initialize` alongwith its own capabilities, protocol version, client info, messageId etc.
   - Server sends similar response with same id and similar information.
   - protocol version of client and server should be compatible. 
   - Server should declares its primitive and notification cababilities. 
    - `"tools": {"listChanged": true}` declares server supports tools primitive and it will send `listChanged` notification in case of any modification/create/delete of existing tools.
    - `"resources": {}` means server supports resources primitive which have `resources\list` and `resources\read` calls. 
   - client should declare elicitation capabilities. 
     - `"elicitation": {}` declares client support elicitation permitive and server can call `elicitation/create`. Server can user data by sending elicitation request to the client which further asks the user through LLM for more data.
   - Client info and server info to exchange their identity information.
   - After sucessful handshake. Client sends intialization complete notification.
 - Client/server stores each other capabilities for later use.
 - Client then sends `tools/list` request for tool related information given server send supports tools during initialization exchange. 

### MCP Primitives
#### Tools primitive
   1. `tools/list` API for tools discovery. 
    - It returns tools array with each element representing json which specifies `name`, `title`, `description` and `inputSchema` json. 
   2. `tools/call` for a specific tool execution. It requires json input which specifies `name` and `arguments` json for tool invocation. Its response is `content` array containing objects of various media type like text, image, video etc.
   Each content object declare its `type`. Response can also be strutured output

#### Resource Primitive
 - for returning any static information like file content, database schema etc. Each resource have unique URI and it also declares its MIME type for application/llm understanding. Resouce URI can also be template based e.g. `travel://activities/{city}/{category}`
 - `resources/list`
 - `resources/template/list`: Each resource template will having following schema- uriTemplate, name, title, description and mimeType.
 - `resources/read`
 - `resources/subscribe`

#### Prompt Primitive
 - Sampling primitive: Allow server to use language model completion via `sampling/complete`
 - Elicitation primitive: For any user's additional information, server can invoke `elicitation/request` which will cause LLM to ask for more information from the user.
 - Logging primitive: exposed by server to send log messages to LLM.
 - Primitive can be manipulated via 
   1. `prompt/get` to get prompt
   2. `prompt/list` lists all the prompt avaiable via MCP server.
#### Notification primitive
 - `notifications/tool/list_changed` 


### Notification
 - one way communication from either sides which allows real time synchronization between server and client capabilities. Consequently notification messages are without any `id` field.
 - Usecases
   - any tool related changes: Given server declares `listChanged:true` capability during initialization, server can do `notifications/tool/list_changed` method invocation when required.  
   - progress on tasks 

### Elicitation Primitive
 - `elicitation/create` server invokes this primitive on the MCP client to find any missing information. Client further asks the information from the user. LLM is not involved here.  `params` are sent in the request which have `message` and `schema` object. Elicitation is not for password and API keys.

### Roots Primitive
 - `roots/list_changed` sends notification to server when roots directory changed.
### Sampling Primitive
 -  `sampling/createMessage`
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