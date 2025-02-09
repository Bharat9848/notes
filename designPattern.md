# Design pattern
## Creational

## Structural
- **Proxy** placeholder for another object and contol the access to real object.
- **Adapter**
- **Facade**
- **Decorator**


## Architectural

## Behavioral pattern
- Filter chain
- **Command** 
  - E.g. Runnable
- Iterator
- **Mediator**: an interface/abstract that takes other interface/abstract type and delegate or use it e.g. Executor::execute takes Runnable and use it. 
- **Observer**: to subscribe to an event. 
- **Template**: 
- **State**
- **Dispatcher**: calls function based on runtime type of called object.
- **Visitor**

- **Model-View-Controller**: View is the UI. Model is business logic of the system. Controller translate any action on UI to model related activity. It promotes separtion of concern and prevent spilling of business logic on UI. If system changes its state from the backend then controller should update the view using Observer pattern in case system is a single process or Publisher-subscriber pattern in case system is a set of distributed processes.

- **Observer**: Subject is the entity being observed. Observer should register itself to observe the subject. Whenever state of subject changes the observer should get notified. It can be lead to memory leak if observer does not deregister.

- **Memento**: It have three main components: originator, caretaker and the memento. Caretaker save the state of the origintor and send it back to originator in case of undo. The state is called memento. Caretaker sends event to the originator. Before changing the state of originator, caretaker asks for a memento.
  - It is used for undo usecases. 


