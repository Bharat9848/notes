# python



## Virtual environment
- How to setup virtual env
  `pip install virtualenv`
  ```shell
   # setting current directory for virtual environment
   python3 -m venv venv
   # starting virtual env
   source ./venv/bin/activate
   # stop virtual env
   deactivate
  ```
- to run jupyter notebook run `python3 -m notebook`
- logging
```python
import logging

logging.basicConfig()
logging.getLogger("langchain.retrievers.multi_query").setLevel(logging.INFO)
```

## pip commands  
- `pip install`
  1. `-r requirement.txt`
  2. `--upgrade`: upgrades lib to latest version
  3. `lib==x.y.z`: for pinning lib version
  4. `--user` ?
  5. `-no-cache-dir`? 
  6. `--force-reinstall`?
- `pip list`
- `pip freeze`  
---- 
# Fun python
 - `[a, b] * 2` will become `[a, b, a, b]`
 - `(a, b) + (c,)` will become `(a, b, c)`

----

# class

## class inheritence
 - ```python
   class subClass(superclass):

 ```
## python Java analogy
 - `__init__(self, ....)` constructor of a class
 - `self` is analogus to `this` in java
 - `__str__(self)` is analogus to `toString`
 - any class method should have `self` as first argument and use `self.classVariable` to access any class level variable 

-----  

# Serialization
 - modules to load various kind of files
   `json`, `csv`, `yaml` 
 - pydantic library
   class will subclass `BaseModel` then use `obj.model_dumps_json()` serialize object into json. `Class.model_validate_json(json_str)` deserialize json into class object. 
 - In deserialization to get `class` definition from class name which passed as string use - `cls = getattr(sys.modules[__name__], class_name)`    
----

## ergnomics
1. `kwargs` is used to send arbitrary parameter to a function.
2. ``` ``` comments just after function declaration to explain brief about the function, arguments and return type.
3. use `yield` for generator expression instead of list comprehension in case of large data.
4. `pass` keyword ???

## Typical structure of a python project
  1. `requirement.txt`
## python script/main program.

## Python native packages
 - `re`, 
 - `collections.Counter`: returns word counts in sorted freq descending order.
## Libraries
  1. `wikipedia`: python wrapper over wikipedia API.
  2. `mcp`: python SDK over mcp. it is a FastMCP interface. 
  3. `asyncio`- standard library for asynchronus programming.
  4. `shlex`: This library allows us to safely parse user input into parts, handling quoted strings like "Alan Turing" as a single argument. It’s especially useful for parsing command-line style input.
  5. `pypdf2`: for reading pdf files. It does not read tables and images.
  6. `tabula`: for reading pdf tables
  7. `requests`: for making http calls
  8. `flask`: create web application.
  9. `gradio`: create ui application. see gradio notes
  10. `torch`: deep learning library. it also helps in vector operation
  11. `lark` is a general-purpose parsing library for Python.
  12. `tqdm`for showing progression of tasks etc.
  13. `dataset` for standardizing and manipulating wide variety of datasets.
  14. `pickle`: serialization library
---
# Flask
- Build in web server. `flask run` command runs the server
- has a debugger
- use standard python logging
- has build-in unit testing
## classes 
  1. Flask, 
  2. request- `request.json` 
  3. jsonify static function `jsonify(map)`
- flask-extensions
  1. flask-alchemy: relational object mapper
## Syntax
```python 
  @app.errorhandler(500)
  def server_error(error):   
     return {"message": "Something went wrong on the server"}, 500
```  
---
## Pydantic
 - if your class is subclass of `pydantic.BaseModel` which provides `model_json_schema()` which returns subclass json output schema definition. `model_dump()` returns serialized json output of an object. `validate_object(json)` deserialize the json to object.
---
## Performance
 - decorate on a function `@memory_profiler.profile(precision=4)`. It shows memory usage and increments line by line
 
- ## Resources and books
 - Raymond Hettinger - youtube videos
---
## Rough
- `type annotation feature in Python 3.9+ messages:Annotated[Sequence[BaseMsg], operator.add]`
- type `str`, `dict`, `TypedDict`
- The Python eval function takes a string and evaluates it as a Python expression. In the context of semantic search, eval is used to dynamically execute semantic functions stored as strings in the entities collection. This allows new logic to be plugged in at runtime without changing the application code. However, using eval can be risky if the input is not trusted, as it can execute arbitrary code.

 
 `**kwargs` 


    tensorflow: The core library for TensorFlow, required for working with the Universal Sentence Encoder.
    tensorflow-hub: A library that makes it easy to download and deploy pre-trained TensorFlow models, including the Universal Sentence Encoder.
    faiss-cpu: A library for efficient similarity search and clustering of dense vectors.
    numpy: A library for numerical computing, which we will use to handle arrays and matrices.
    scikit-learn: A machine learning library that provides various tools for data mining and data analysis, useful for additional tasks like data splitting and evaluation metrics.



    youtube-transcript-api for extracting transcripts from YouTube videos.
    faiss-cpu for efficient similarity search.
    langchain and langchain-community for text processing and language models.
    ibm-watsonx-ai and langchain-ibm for integrating IBM Watson services.
    streamlit for building the web application interface.
