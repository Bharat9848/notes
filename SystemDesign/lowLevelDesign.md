# General
- you will be judged on gathering requirementsm, scope down the problem and design using OOP design principles and SOLID.
- First figure out the primary use cases in first few minutes.
- Design should be shown in some form of UML diagrams and well defined classes with SOLID design and ood priciples
- extra points for thinking scalability, extensibility and maintainability beforehand.

# OOP Design priciple
- Object oriented analysis requires requirement gathering and recognize objects require to model the system.
- Object oriented design entails further details out the objects by finding more contraints and detailing object interactions with the help of UML diagrams.
- Object oriented analysis and design are not to include any implementation details.
- **Encapsulation**: Mask the internal details of object representation from outside
- **Abstraction**: Provide simple contractatual methods to outside world which decreases the overall complexity of the system by hiding complex details inside the implementation.
- **Inheritance**:
- **Polymorphism**

# SOLID principle
- Single responsibility
- Open-closed principle
- L
- Interface segragation
- Dependency

## UML
- UML is composed of three main building blocks: things, relationships, and diagrams. 
- **UML Things** can be structural which includes. classes, objects, use case, interface, actor, component and node. Behavioural things include state activity and interaction diagram.  
- Structural diagram category includes class diagram, package diagram, object diagram and composite structure diagram. 
- Structural Implementation diagram category includes component and deployment diagram.
- Behavioural interaction diagram category includes sequence, communication, interaction overview and timing diagram.
- Behavioral diagram category includes usecase, activity and state machine diagram.

## Usecase diagram
 - It is used to depict flow and objective of all the usecases.
 - **Actor** interacts with the system, it can be human, hardware/machine and other external system. Primary actor interacts with the system. Any secondary actor is put on the right side of the system while primary is put on the left side of diagram.
 - **Usecase** it is typically mentioned in an oval shape
 - **package**: groups different elements and it is represented through a folder icon. 
 - **Notes**
 - Relationship between usecases
  1. **Include** relationship: to include a usecase in other usercase
  2. **Generalization** relationship: ??
  3. **Extends** relationship: a usecase extends other usecase e.g. Cash withdrawal extends transaction usecase.

## Class diagram
 - it is used to show static representation of classes for their roles and responsibities.
 - Class have three section - name, attributes and methods
 - abstract classes have `<<abstract>>` above its name.  
 - enum have `<<enumeration>>` above its name.  
 - interface have `<<interface>>` above its name.
 - annotations have `<<annotations>>` above its name.  
 - attributes can be prefixed with `+`, `-` and `#` to represent public, private and protected members.
 - Class relationship can be inheritance (an empty arrow towards the superclass), association (an arrow to holded class), composition (filled diamond arrow towards the aggregator) and aggregation ( empty diamond arrow towards the aggregator), two way association with simple line without any arrow.	

## Sequence Diagram
 - `lifeline`, `activation bar` 
 - `object`/`actor` it can be a user, logical object like transaction in ATM domain, physical object like ATM, cash dispenser in ATM
 - Synchronus send messages are shown with solid line and filled arrow while asynchronus send messages are solid line with an open arrowhead.
 - Synchrounus reply messages are shown with dotted line with filled arrow.
 - object creation flow can be shown with new object box at the send message arrow.
 - object deletion flow can be shown with `X` mark in object timeline at the end of activation bar.
 - **fragment frame**
   1. `alt` for if-else flow. if block is separated from else block using horizontal dashed line encompassing whole frame. Conditions should be mentioned near the `alt` section.
   2. `loop`
   3. `par` for parallel flow.
   4. `opt` for single if block.

## Activity/ Flow Chart Diagram 
  - More coarse than sequential diagram as activity encompasses small message interaction between few objects.
  - `init` `end` circle for happy flow
  - `circle with X` can be used to represent error flow.
  - `action` in activity rectangle. It can be decision activity
  - `diamond` to represent divergence of a path to `yes/no` path. 
  - `diamond` to represent merge paths
  - **Fork and join** two solid line vertical bars can be used to show concurrent and parllel activity.  


# Practice question
 - Design tic-tac-toe: Classes - GamePlay
 - Design elevator system:
   -- see elevator repo
 - Design sudoku:
 - Design parkinglot
   -- see workspace repo parking lot.
 - Design ATM
   -- see workspace repo ATM 






