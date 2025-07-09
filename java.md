## Books
- Java NIO (O’Reilly)
- Netty in action (Manning)

## Exceptions
- It helps in distinguish control flow from business logic. Try/catch block separates out the business logic in try part where catch is supposed to handle exception's logic.

1. Checked exception: 
 - These type of exception should be used in case of recoverable situations.
 - It should be used sparingly as they clutter the code.
 - Sometimes use of checked exception is depending on the product requirement. It is decided upon whether we want to force our user to take a recovery exception or there is alternate mechanism available to recover from the error.

2. Unchecked exception
 - Errors and RuntimeException are not supposed to be recoverable and hence should not be catched.
 - Validation exception should be non-recoverable.

# Library
  - `Awaitability`
  - `Arch-unit`
  - `joccoo test`
  - `pittest`
  - `testcontainers`
  - `gatling`
  - `openrewrite`


## Java Thread
 - **Thread Groups** are hierarchial. Root thread group is system thread group. System has one child called main thread group. `main` thread which starts the process belongs to `main` thread group. All thread groups which are created part of executor services are child of main thread group.
 - Thread group's `interrupt` function interrupt all the threads of thread group.
 - **Security Manager** authorizes certain operation done by a thread to another thread like interrupt using `checkAccess(thread)`.  
 - Thread/ Thread group have `UncaughtExceptionHandler` to catch all exception thrown during run execution. By default `UncaughtExceptionHandler` prints exception.
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
  - `FileChannel` have `transferTo` method which avails linux zero-copy functionality. It allows data to be transfered to socket without crossing kernel to user space for file reading and then again user to kernel space for socket writing.
 
 ## JVM Parameter
  - `-Xss` specifies stack size for threads.
 
 ## Just In-Time compilation
  - It does most of the performance optimization in few minutes or equivalent of 10000 cycle of an operation.  
  - It inline more and more methods for long running programs
  - Unroll loops: JIT compilation unrolls a loop to make it sequential.

## Java 7
 - Read about phasers
 - read about fork-join


## JAVA 8
1. Instead of hunting enums usage in your code every time you add new enum constant, move your enum logic in enum class itself as a property (which can be a Method reference) or (abstract) functions. This will prevent any accidental logic left out for your new enum constant.

2. Template Pattern can be replaced with more readable Loan pattern. Loan pattern can be seen as wherein a resource(e.g. File) has passed on to some specific logic to run on it.


## Java performance tools
 - Jprofiler - CPU, thread, and memory usage
 - yourkit
 - VisualVM - realtime monitoring for GC, heap dump and memory usage
 - Actuator with micrometer - application metrics
 - Zipkin/elastic APM - distributed tracing tools

## File operations:
 - upload large file in chunks in parallely

## Problems
 - Write deadlock detection algortitm
 - How lock prevent variable visibility and contention problem internally across multiple core
 - infinite loop in atomic variables.

## Build tools
### Gradle
- have captured the inspiration of`convention over configuration` from maven.
- DSL based tool using groovy or kotlin
- files for specification
1. `build.gradle` it is just like `pom.xm1`.
2. `settings.gradle` it is for setting up multiproject