# python

## Virtual environment
- How to setup virtual env
  ```shell
   # setting current directory for virtual environment
   python3 -m venv .
   # starting virtual env
   source ./bin/activate
   # stop virtual env
   deactivate
  ```

## class inheritence
 - ```python
   class subClass(superclass):

 ```
## ergnomics
1. `kwargs` is used to send arbitrary parameter to a function.
2. ``` ``` comments just after function declaration to explain brief about the function, arguments and return type.

## Typical structure of a python project
  1. `requirement.txt`
## python script/main program.

## Libraries
  1. `wikipedia`: python wrapper over wikipedia API.
  2. `mcp`: python SDK over mcp. it is a FastMCP interface. 
  3. `asyncio`- standard library for asynchronus programming.
  4. `shlex`: This library allows us to safely parse user input into parts, handling quoted strings like "Alan Turing" as a single argument. It’s especially useful for parsing command-line style input.

## Rough
- type `str`, `dict`, `TypedDict`
- The Python eval function takes a string and evaluates it as a Python expression. In the context of semantic search, eval is used to dynamically execute semantic functions stored as strings in the entities collection. This allows new logic to be plugged in at runtime without changing the application code. However, using eval can be risky if the input is not trusted, as it can execute arbitrary code.
