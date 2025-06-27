# Design Pattern
## Creational design pattern
- Create complex object 
- Create simple object with some constraints.
- create object with some flexibility
- Examples are
  1. Singleton
  2. Factory
    - create different type of object based on the situation.
  3. Abstract factory
    - factory of factory
    - usually exposed via a static method `def XBuilderFactory.newInstance(): XBuilderFactory`
  4. Builder
  5. Prototype:
    - create clone of an object
    - when to use ??

## Structural design pattern
- These patterns helps in object relationships.
- Types
  1. Decorator: Take the instance of same type/abstraction and add more behaviour over it. e.g. `BufferedInputStream`
  2. Facade: hides the complex details of an abstraction and provides only simple abstraction
  3. Adapter: Make two incompatible APIs compatible to each other.
  4. Bridge: Make two part of system independent both part can vary through their definition.  
  5. Proxy: Similar fake object with same properties and method but delegate the calls to real object. It help in reducing the workload. 
  6. Flyweight: Caches the data e.g  `valueof` data in integer and double classes.
  7. Composite: A abstraction that allow deeply nested structure. Composite is an abstraction with two types which can be either composite objects or leaf object. E.g. TreeNode can be a leaf or internal node with different leaf. 

## Behavioural design pattern
- These pattern helps in efficient communication at runtime.
- Types
  1. Chain of responsibility: Loosly coupled objects make the chain. A request is passed across the chain which is either handled finally or filtered/enhanced in the chain classes.
  2. Command: Allow encapsulation of request or operation into separate objects. It maintains queue of request object to provide redo or undo operations.
  3. Iterator: simple interface which allow sequential pass over the collection of objects.
  4. Mediator: a central coordinator which allows communication between different types.
  5. Observer: A central entity that manages observers and send notificaions to observers in case state of observee changes. 
  6. Strategy
  7. State
  8. Momento
  9. Template
  10. Interpretor
  11. Visitor: add extension to a different set of objects

## Architectural Design Pattern
- MVC
- MVP
- MVVM