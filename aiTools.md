## Local model
 - OpenAI-standard API should be supported by opensource llm
 - Quantization helps run large model to run locally. how - It removes the precision bytes from float values of weights of llm and convert them to integer.
   - post training quantization(PTQ)
   - Quatization aware training
   - GPTQ GPT with PTQ technique
   - NF4: uses 4bit precision instead of removing the precision altogether.
   - GGML and GGUF ??
   - bitandbytes: python library  
 - specialized inference emulator

## Tools
1. ollama
  1. `ollama ls`
  2. `ollama run <model:tag>`
  3. `ollama stop <model:tag>`   

2. LM studio
3. vLLM: for non-quantized llm to run on a powerful hardware in your local cloud.
4. LocalAI
5. GPT4ALL

6. llama.cpp 
  ## How to build locally
    1. To use llama.cpp, follow these steps:
      a. Build the Executable: Download the [source code](https://github.com/ggerganov/llama.cpp.) from GitHub and build it using your preferred strategy, such as make, CMake, Zig, or gmake. Advanced build options include Metal, MPI, and BLAS for enhanced performance.
      b. Prepare the Model Weights: Obtain a quantized version of the model (e.g., Mistral-7B-Instruct-v0.2-GGUF) from Hugging Face or generate it using GitHub instructions. Ensure the model fits within your system's disk and RAM capacity.
      c. Run Inference: Execute the inference command, pointing to the quantized model file:
    `./main -m ./models/mistral-7b-instruct-v0.2.Q2_K.gguf -p "How many Greek temples are there in Paestum?" -n 512`



## python
1. how to use llm.cpp 
  1. `pip install llama-cpp-python`
  2. ````
  ### Adapted from official documentation at
### https://github.com/abetlen/llama-cpp-python
from llama_cpp import Llama
llm = Llama(
      model_path="./models/mistral-7b-instruct-v0.2.Q2_K.gguf"
)
output = llm(
      "Q: What are the planets in the solar system? A: ", # Prompt
      max_tokens=32, # Generate up to 32 tokens, set to None to generate up to the end of the context window
      stop=["Q:", "\n"], # Stop generating just before the model would generate a new question
      echo=True # Echo the prompt back in the output
) 
print(output)
     ```` 
2. Using langchain
````
from langchain_community.llms import LlamaCpp
llm = LlamaCpp(model_path="./models/llama-2-7b-chat.ggmlv3.q2_K.bin") 
````

## Sample requests
 1. Requests
````
curl https://localhost:8000/v1/chat/completions   -H "Content-Type: application/json"   -d '{
    "model": "mistralai/Mistral-7B-v0.3",
    "messages": [
    { "role": "system", "content": "You are a helpful AI assistant." },
    { "role": "user", "content": "How many Greek temples are there in Paestum?" }
    ],
    "temperature": 0.7
  }'
````
## Resources
 - [List of open source llms] (https://huggingface.co/spaces/open-llm-leaderboard/open_llm_leaderboard#/?params=0%2C3)
 
## about langgraph
  - used to define the interaction flow as a graph of nodes. Each node represents a reasoning step, such as generating a response or selecting a tool.
  - LangGraph uses a shared state model, where each node can read from and write to a central data structure. For a conversational agent, this state typically includes the chat history—what the user has said, how the assistant has responded, and any tool calls in between.
  - chat node
  - tool node
