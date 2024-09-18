## Books
- Java NIO (O’Reilly)

JAVA Bytecode.


1.aload_0
This opcode is one of a group of opcodes with the format aload_<n>. They all load an object reference into the operand stack. The <n> refers to the location in the local variable array that is being accessed but can only be 0, 1, 2 or 3. There are other similar opcodes for loading values that are not an object reference iload_<n>, lload_<n>, float_<n> and dload_<n> where i is for int, l is for long, f is for float and d is for double. Local variables with an index higher than 3 can be loaded using iload, lload, float, dload and aload. These opcodes all take a single operand that specifies the index of local variable to load.
2.ldc
This opcode is used to push a constant from the run time constant pool into the operand stack.

3.getstatic
This opcode is used to push a static value from a static field listed in the run time constant pool into the operand stack.

4.invokespecial, invokevirtual
These opcodes are in a group of opcodes that invoke methods these are invokedynamic, invokeinterface, invokespecial, invokestatic, invokevirtual. In this class file invokespecial and invokevirutal are both used the difference between these is that invokevirutal invokes a method based on the class of the object. The invokespecial instruction is used to invoke instance initialization methods as well as private methods and methods of a superclass of the current class.

invokestatic / iadd / ireturn /invokevirtual java bytecode command pops from operand stack multiple times based on argument it need to invoke command's method. 

5.return
This opcode is in a group of opcodes ireturn, lreturn, freturn, dreturn, areturn and return. Each of these opcodes are a typed return statement that returns a different type where i is for int, l is for long, f is for float, d is for double and a is for an object reference. The opcode with no leading type letter return only returns void.


iconst_X / iload_X / getstatic java bytecode command store value in operand stack.

istore pop the return value from operand stack and set it to crossponding local variable array location.

## Java Thread
 - Thread states - new, Running, blocked, wait
 - Synchronization prevents reordering of statements by compiler and instruction.
 - Java objects act as mutexs, in addition they have `wait()` and `notify()` to provide a thread a parking area and notification mechanism. Note that `wait()` and `notify` should be only called from synchronized block using same object.
 - sleep()/wait()/join() blocks a thread. To wake up a thread which is blocked on some condition, we should call its interrupt() method, it causes it's blocking method to throw `InterruptedException`. 
 - join() method gives other thread to block on child thread till it completes.
 - `synchronized` allows thread to take a mutex before entering any critical section to prevent race condition. Meanwhile if there is only single call e.g. setting up a flag etc in that case synchronization is unnecessary. Synchronization also ensure visibility among threads.
 - `volatile` allows visibility of a variable among threads. It should only be used for single variable load and store cpu insturctions   
 - `yield` function hints Os to select some other thread but most of the time OS ignores it.
 - **Green thread model** It was old JVM implementation which abstracts out thread without leveraging native OS threading API. For OS java process is a single thread.

### Java Thread schedular
- A typical java thread schedular may use 14 linked list for a thread scheduling purposes - 11 for each thread priority, new state, blocked state and for exit state. Java thread schedular tries to preempts thread of lower prioriy if there is an runnable thread of higher priority. However thread scheduling is in OS hands. It may allow lower priority thread to run before it allows higher priority to run.
- OS have typical features of **priority inheritance** and **complex priority calculation methods** for thread starvation and thread deadlock prevention. Both of these might override java priority.
- Os may use time slicing method to give run thread periodically  irrespective of thread priority. 

### Thread pools
- creating a thread takes few 100 microseconds which might be a performance hindering.
- Thread pools are not necessary for workloads where each thread's output is not independent. 

 ## Wait and notify
 - `wait` and `notify` is a synchronization mechanishm with additional notification mechanism.
 - usecase for wait and notify is to wait by a thread on some condition if it's not met. In time some other thread will make the condition true and notifying the waiting thread. 
 - `wait` being called from synchronization method, synchronization lock is released on just entering in `wait` - prior to waiting and reacquired just before returning from the `wait`. This is required as normal lock does not behave like `Reenterent` lock. 
 - `notify` sends notification any random thread waiting on object while `notifyAll` sends notification to all the threads waiting on object.
 - After waking up from the `wait` thread should again recheck the condition hence `wait` is always called from loop. In case where some other thread got the notification condition for which wait thread was waiting might have changed.  

 ## condition variable
 - It is similar to `wait` and `notify`. It is tied with lock interface where `lock.newCondition` returns new condition variable. `wait` is called `cv.await()` in condition interface and `notify` is called `cv.signal()`. 
 - A thead relinquish it's lock to wait on some data synchronization to happen. Other thread have to signal waiting thread to stop waiting.

 ## Barrier
  - rendezvous point for all thread before they can proceed
 ## Semaphores
  - ??? If a semaphore is constructed with its fair flag set to true, the semaphore tries to allocate the permits in the order that the requests are made—as close to first-come- first-serve as possible. The downside to this option is speed: **it takes more time for the virtual machine to order the acquisition of the permits than to allow an arbitrary thread to acquire a permit.**
 ## Countdownlatch / CyclicBarrier

 # Locks
 ## Best practice
  1. Multiple locks should be acuired in same order.
  2. In case of exception synchronized block automatically release the lock. But for manually lock, lock's release should be done in finally block.
  3. Complex lock usecases should have lock hierarchies.
  4. Use timeout overloaded function of locks in case of multiple lock usecases.

 ## Reader/Writer Lock
  - reader thread allowed to run in parallel but only one write thread is allowed to access critical section.
  - Lock upgrade from read to write is not allowed.
  - Lock upgrade from write to read is allowed.

 ## Deadlocks
  - Single thread runs infinite loop after acquiring a lock.
  - Two threads waiting for each other's already acquired locks.
  - Locks are not properly released some exception has occurred before lock's release call. 	

 ## Java NIO
  - Design: ServerSocketChannel have serverSocket and allow registering of selector with particular mode that are READ|WRITE|LISTEN. Selector is a thread which selects among many sockets whichever is data ready. Selector listens to server socket for any new client connection. ServerSocketChannel.accept returns a new SocketChannel(client connection). we can register same selector to new client socketChannel as well.  SocketChannel get notified whenever ready by selector. SocketChannel have read and write API whenever it's ready to send or recieve in ByteBuffer. 


## Java 7
 - Read about phasers
 - read about fork-join


## JAVA 8
1. Instead of hunting enums usage in your code every time you add new enum constant, move your enum logic in enum class itself as a property (which can be a Method reference) or (abstract) functions. This will prevent any accidental logic left out for your new enum constant.

2. Template Pattern can be replaced with more readable Loan pattern. Loan pattern can be seen as wherein a resource(e.g. File) has passed on to some specific logic to run on it.



## Problems
 - Write deadlock detection algortitm