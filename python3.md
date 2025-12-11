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


## class inheritence
 - ```python
   class subClass(superclass):

 ```
## ergnomics
1. `kwargs` is used to send arbitrary parameter to a function.
2. ``` ``` comments just after function declaration to explain brief about the function, arguments and return type.
3. use `yield` for generator expression instead of list comprehension in case of large data.

## Typical structure of a python project
  1. `requirement.txt`
## python script/main program.

## Libraries
  1. `wikipedia`: python wrapper over wikipedia API.
  2. `mcp`: python SDK over mcp. it is a FastMCP interface. 
  3. `asyncio`- standard library for asynchronus programming.
  4. `shlex`: This library allows us to safely parse user input into parts, handling quoted strings like "Alan Turing" as a single argument. It’s especially useful for parsing command-line style input.
  5. `pypdf2`: for reading pdf files. It does not read tables and images.
  6. `tabula`: for reading pdf tables
  7. `requests`: for making http calls
  8. `flask`: create web application.

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
## Rough
- type `str`, `dict`, `TypedDict`
- The Python eval function takes a string and evaluates it as a Python expression. In the context of semantic search, eval is used to dynamically execute semantic functions stored as strings in the entities collection. This allows new logic to be plugged in at runtime without changing the application code. However, using eval can be risky if the input is not trusted, as it can execute arbitrary code.
