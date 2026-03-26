
## properties
-  for multimodel usecases you need to disable the `ChatClient.Builder` autoconfiguration by setting the property `spring.ai.chat.client.enabled=false`.

##  Abstractions
1. **ChatClient**
    - Spring automatically create `ChatClient` using some settings defined in yaml/properties file
    - holds ChatModel
    - **ChatClient.Builder**
        - ChatOptions: Model specific chat options for all the requests.
        - Function: act as a tool for model invocation whenever needed.
        - Functions: declared bean functions to be used as tools
        - System: 
        - User
        - Advisors  
   
2. **ChatModel**: 
    - exposes call method.
    - abstraction for model specific arguments. Implementation can be of various type depending on Spring's different LLM integrations.

3. **PromptTemplate**
   - Strings with variables in curly braces. Prompt have multiple text input System,User,Assitant etc. see prompt engineering notes.
   - works hand-in-hand with **TemplateRenderer**
   - `render` is akin to toString which materializes the prompt text as String. It is usually called after providing all the params.
   - `template` method takes a template string with placeholders.
   - `params` methodhelps in runtime filling of plaeholder keys with values.

4. **Advisor**
    - modify the llm request and response. It can be used to create/modify final prompt.
    - Advisor ordering is important as they run sequentially e.g. conversational advisor should come before RAG advisor.
    - Use the adviseContext to share state between advisors when necessary.
    - Types
      
      - **MessageChatMemoryAdvisor**: adds conversation history to the chat.
      - PromptChatMemoryAdvisor : add memory to system text.
      - VectorStoreChatMemoryAdvisor: add memory to system text.
      
      - **SimpleLoggerAdvisor**: to log llm request response. It should be added in the last of advisors chain. It also requires `logging.level.org.springframework.ai.chat.client.advisor=DEBUG`
      
      - **QuestionAnswerAdvisor**: implements RAG by appending context in user input.
      - **RetrievalAugmentationAdvisor**:

      - SafeGuardAdvisor: prevents harmful content.

      - BaseAdvisor
      - CallAdvisor
5. ChatMemory
  - interface to add message to coversation, get conversation history and to clear chat history.
  - MessageWindowChatMemory: Stores last N number of messages.
  - ChatMemoryRepository: binds MessageWindowChatMemory with different storage implemtation like InMemoryChatMemoryRepository, JdbcChatMemoryRepository, Neo4jChatMemoryRepository, CassandraMemoryCPPhatMemoryRepository. 
6. VectorStore:
    - abstraction over storing documents and semantic search
    - Spring offer various vector store provider integration classes for VectorStore implementation.
    - it extends DocumentWriter and VectorStoreRetriever interfaces.
    - delete method is overloaded with list of ids, filter expression and default string filter expression.
    - provide default getNativeClient
7. ChatClientRequest:
   - `mutate`: for advisors to enhance request/response.
   - `ChatOptions`: for specifying model specific option.
8. ChatClientResponse
9. Prompt: 
    - abstracts over a list of `Message`
    - Assitant type messages have llm answers to previous queries.
    - `ChatOptions`: request specific model option which will override `ChatClient` chat options. 
10. Message 
    - Each Message have a type - System, User, Tool, Assitant
    - Message also have content
    - Message also have metadata  
11. ChatOptions: 
    - `getModel`
    - `getFrequencyPenalty`
    - getMaxTokens();
    - getPresencePenalty();
    - getStopSequences();
    - getTemperature();
    - getTopK();
    - getTopP();
    - copy()    
12. ChatResponse:
    - Generation: represent a single instance of a conversation with llm. 
      - output
      - Metadata
      - AssistantMessage
      - ChatGenerationMetadata
    - ChatResponseMetadata
13. Document: 
    - abstraction for documents have property of content and metadata.
14. DocumentReader
    - Supplier of list of Document.
15. DocumentTransformer: 
    - BiFunction which transforms list of documents to list of documents.
16. DocumentWriter
    - Consumer of list of document.
17. VectorStoreRetriever
    - provide similarity search method for a query.
18. SearchRequest embodies the 
    - query for semantic search
    - additional filter for metadata filtering
    - success matching criteria like topK, similarity threshold
19. BatchingStrategy: abstracts the maximum token limit of embedding model, it coverts list of documents into subbatches and return List of List of Document.
    - TokenBasedBranchingStrategy: configured to your embedding models context window size. it throws an error in case a document exceeds the max limit. Internally it uses TokenCountEstimator interface to count number of tokens. By default it uses JTokkitTokenCountEstimator
20. `@Tool` annotation over a method expose the method as a tool to LLM. `@Tool` have `description`, `name`, `retunDirect`(if set to true return the tool response directly to callee, not the llm), `resultConverter`(convert tool result to string to send it back to llm) and `input schema`  
21. `ToolCallback` interface: spring-ai automatically create `MethodToolcallback` from the method annotated with `@Tool`. ChatModel implementation dispatch the call from LLM to tool via `ToolCallingManager` which calls `ToolCallback::call` method. `ToolCallingManager` manages the tool execution lifecycle, first it resolves tool llm wants to call using `ToolCallbackResolver` interface. 
22. `@ToolParam` `description`can be used to describe any condition about the argument and `required` for whether it is optional or mandatory
23. tools can be added to specific chatclient, specific request or across chatclient.builder, chatmodel
24. `ToolContext` extra input parameter to the tool which is additional to LLM imput. It is a Map of key and values. 
25. `ToolCallExecutionResult` maintain toolconversation history.
26. Exception handling: all runtime exceptions message are sent to LLMs. CheckException are thown and not sent to LLM
27. Observability:
