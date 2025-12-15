
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