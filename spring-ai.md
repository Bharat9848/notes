
## properties
-  for multimodel usecases you need to disable the `ChatClient.Builder` autoconfiguration by setting the property `spring.ai.chat.client.enabled=false`.

##  Abstractions
1. **ChatClient**
   - spring automatically create using some settings defined in yaml/properties file
   - holds ChatModel,
   - 
2. **ChatModel**: exposes call method.
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
5. **ChatClient.Builder**
  - ChatOptions: Model specific chat options for all the requests.
  - Function: act as a tool for model invocation whenever needed.
  - Functions: declared bean functions to be used as tools
  - System: 
  - User
  - Advisors  
6. ChatMemory
  - interface to add message to coversation, get conversation history and to clear chat history.
  - MessageWindowChatMemory: Stores last N number of messages.
  - ChatMemoryRepository: binds MessageWindowChatMemory with different storage implemtation like InMemoryChatMemoryRepository, JdbcChatMemoryRepository, Neo4jChatMemoryRepository, CassandraMemoryCPPhatMemoryRepository. 
7. VectorStore
8. ChatClientRequest:
   - `mutate`: for advisors to enhance request/response.
   - `ChatOptions`: for specifying model specific option.
9. ChatClientResponse
10. Prompt: 
    - abstracts over a list of `Message`
    - Assitant type messages have llm answers to previous queries.
    - `ChatOptions`: request specific model option which will override `ChatClient` chat options. 
11. Message 
    - Each Message have a type - System, User, Tool, Assitant
    - Message also have content
    - Message also have metadata  
12. ChatOptions: 
    - `getModel`
    - `getFrequencyPenalty`
    - getMaxTokens();
    - getPresencePenalty();
    - getStopSequences();
    - getTemperature();
    - getTopK();
    - getTopP();
    - copy()    
13. ChatResponse:
    - Generation: represent a single instance of a conversation with llm. 
      - output
      - Metadata
      - AssistantMessage
      - ChatGenerationMetadata
    - ChatResponseMetadata