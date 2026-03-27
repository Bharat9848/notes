## Books and references
 1 Software architecture in practice.
  - On safety - a sensor is important to determine whether a state is safe or unsafe, that sensor should be replicated.    
 - Software Fundamentals: Collected Papers by David L. Parnas
 - Pattern-Oriented Software Architecture [Buschmann 96 and others]
 - George Fairbanks’ Just Enough Software Architecture [Fairbanks 10], 
 - Woodsand Rozanski’s Software Systems Architecture [Woods 11],
 - Martin’s Clean Architecture: A Craftsman’s Guide to Software Structure and Design [Martin 17].
 - The Software Architect Elevator: Redefining the Architect’s Role in the Digital Enterprise by Gregor Hohpe
 - Software Systems Architecture: Working With Stakeholders Using Viewpoints and Perspectives
 - (Optimizing compute across cluster) [https://www.uber.com/en-IN/blog/compute-cluster-management/?ref=highscalability.com]

### Performance
 - Foundations of Software and System Performance Engineering: Process, Performance Modeling, Requirements, Testing, Scalability, and Practice [Bondi 14].
 - Software Performance and Scalability: A Quantitative Approach [Liu 09].
 - Performance Solutions: A Practical Guide to Creating Responsive, Scalable Software[Smith 01].
 - Real-Time Design Patterns: Robust Scalable Architecture for Real-Time Systems [Douglass 99]
 - Pattern-Oriented Software Architecture Volume 3: Patterns for Resource Management [Kircher 03].
 - Just Enough Software Architecture: A Risk-Driven Approach[Fairbanks 10].



## Architect responsibility
 1. Architect should clearly define the rules against the resources used by component if resource is a matter of concern. e.g. if latency is the resource then architect should layout guidelines for each component time budget.
 2. Deciding when changes are essential, determining which change paths have the least risk, assessing the consequences of proposed changes, and arbitrating sequences and priorities for requested changes all require broad insight into the relationships, performance, and behaviors of system software elements.
 3. Architecture decides organizational structure through work-decomposition. Hence it is very costly due to managerial and business aspect once it is fixed.
 4. Use tools like fitness function to measure the qualities of the software.

## Glossary
 - **Component**: runtime of a module/static piece of code.
 - **Failure**: occures when system does not behave according to it's functional or non-functional specification
 - **Fault**: an errorneous event that may cause a system failure
 - **Errors**: occurs due intermittently or cascading effects of some faults.

## General 
 - The software architecture of a system is the **set of structures** needed to reason about the system. These structures comprise software elements, relations among them, and properties of both. A structure is architectural if it supports reasoning about the system and the system’s properties. The reasoning should be about an attribute of the system that is important to some stakeholders meanwhile supressing the non-important attributes. There are three categories of structures: 
   1. Module structures show the system as a set of code or data units that have to be constructed or procured. 
   2. Component-and-connector structures show the system as a set of elements that have runtime behavior (components) and interactions (connectors).
   3. Allocation structures show how elements from module and C&C structures relate to nonsoftware structures (such as CPUs, file systems, networks, and development teams).
 - Architecture derives the system most important quality characteristics.  
 - Starts with skeletal architecture with minimum functionality while serving most important qualities. Then grow the system incremently.
 - Any change to the system can be thought of falling into 3 broad categories
   1. Local: single element change. 
   2. Non-local: effects multiple elements. 
   3. Architectural: effects the fundamental way elements interact with each other.
 - Quality(non functional) requirement should be captured in common vocabulary to iron out difference between different specification. Mind you that quality attributes are ofter poorly captured.
   1. stimulus : user login, error etc.
   2. source of stimulus: user, physical environment etc.
   3. Artifact: Software system, process, project etc.
   4. Response: fault detection, new feature, software response etc
   5. response measure: time measurement, developement effort, cost etc.
   6. environment: startup etc.
 - Architecture focuses on why part of system, while design focuses on how part of the system.
 - Difference between architecture and design, where the former is structural and the latter is more easily changed

 - Documentation of quality attribute using architecture pattern tactics should document where tactics are present, assumptions and rationale behind using or not using it.
----
## Documentation
### Architectural Decision record
```template
  <title>
  <context>
  <decision>
  <consequene>
```
- Title: Noun phrase containing the decision
- Context: problem and alternative solutions alongwith problem space
- Decision: state the decision and justification
- Consequence: impact of the decision and trade-off that were considered.
- [ADR](https://adr.github.io/) 
- [blog](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)

----

# Tools

### Fitness Functions 
 - part of build and continous deployment. 
 - Checks for performance criterias like performance and scalability
### Chaos Testing Framework
 - checks reliability and resiliance

----

### Immutability
 - storage and compute is cheap. Immutabile data store provide semantic updates based on copy-on-write, Log-structured file system and LSM trees. 

### Module structure 
 - Separation of concern
 - information hiding module should hide the changeable aspect and expose the well defined interface to other module.
 - Fitness function `jdepends`, `SonarQube` and `ArchUnit` 
#### Microservices
  - Size of microservices
  - Bounded contexts are microservices design principle which make transactionality its primary concern.
  - microservices granalurity vs deployability tradeoff

### Component and connectors structure

### non functional qualities
#### Modifiability 
  - producer should be separated from consumer. Contract changes between modules should happen incremently. Changes should affect minimum modules. 
  - Measure: wall clock time required to build, test and deploy the changes
  - Changing part frequently without introducing modifiability mechanism can incur technical debt.
  - high cohesion, low coupling, size of the system and binding time of modification are properties which helps in modifiability of the system.
  - For high cohesion - splitting module cohesively and putting similar functionality in a single module, are tactics.
  - For reduce coupling - encapsulation, use an intermediary, abstract common service and restrict dependencies are some of the tactics.
  - For defer binding - component replacemnt, compile-time parameterization, Aspects, configuration-time binding, resouce files, discovery, interpret parameters, shared repositories and polymorphism.


#### Performance 
  - Response time comprises of two major factor - processing time and blocking time.
  - Blocking time can be futher attributed to some resource contention, non-availability of resource or dependency on some other computation.
  - critical path should be analyzed for unnecessary memory allocation, make batch calls wherever possible and minimum no of system call and good concurrency model. 
  - small data structured should be copied from stack to stack, whereas big data structure are allocated on heap and shared by reference.
  - Tactics can be characterized by controlling the demand on resource or managing resource more effectively.
    1. controlling the demand
     - SLAs constraint the client as well as server. It defines the processing of X messages within Y amount of time. If client sends more than X messages than it breaks the SLA.
     - Reduce Event Sampling : Given there is some quality degradation but it is still good enough. System can reduce or sample requests.
     - limit event response: log and discard extra events
     - priortize events
     - increse computational effeiciency: reduce use of intermediaries, co-locating components and periodic cleanup.
     - Bound execution time: can be time bound on intermediatory computations or no of loops in data driven algorithms
     - Improve algorithms to make more efficient programs. 
    2. Manage resource:
     - increase resources, use concurrency, Caching and replication, bound queue size, and schedule resources. 
  - Pattern for performance
    1. service mesh: side car deployed with microsevices for implementation, management and maintainence of cross cutting concerns like interservice communication, security, monitoring etc.

  1. **Latency**: 
    - time each component, use of shared resources, inter element communication frequency and volume.
    - e.g. Stock exchange etc
  2. **Throughput**
    - Batching of messages in messages exchange system like kafka
    - binary messaging alongwith compression
    - no copy of data in different system in between intermediateries.
       
#### Security
 - security are defined using three common principle - Confidentiality, Integrity and Availability.
 - introduce safeguards against your critical data. 
 - special authorization policy.
 - **Attack Tree** that defines from the root - successful attact to leave nodes - shows breakdown on CIA properties of the system as a result of the attack.
 - Tactics includes - Detect, resist, react and recover
 - Detect
  - detect some malicious pattern in data or traffic.
  - Detect service denial compares current network of traffic to historical traffic pattern.
  - Checksum to check message integrity
  - Detect man-in-the-middle attack by comparing message delivery times or abnormal connection drops.
 - Resist
  - Authenticate, Authorize, Encryption
  - Limit accessibility using limited allowed API, internal firewall, validate input, regular security settings updation
  - Limit exposure - resources are siloed in such a way that demage from a attack is minimum
 - React
  - Revoke access, lock an account and inform actual user.


#### Safety
 - keep part of the system functional even though part of system is under fault.
 - keep the system out of hazardous state.
 - occurs due to wrong timing of event or series of events, omission or commission of right or wrong event respectively.
 - safety tactics broadly classified in unsafe state avoidance, unsafe state detected and unsafe state remediation.
 - Subsitution - removing something complicated and dangerous requirement with simple solution like hardware instead of software solution
 - Predictive model runs to figure out unhealthy state before its occurance.
 - Substitution and predictive model are tatics for unsafe state avoidance.
 - Unsafe state detection tatics include timeout, timestamp, condition monitoring (assumption checking using assertions etc), sanity checking and comparison( with redundant components).
 - Containment tactics include replication, functional redundancy(to counter software implementation error by having different implementation), analytical redundancy (to counter implementation and specification error).
 - Limit consequences tactics include abort, degradation and masking (masking by overriding redundant voting participents)
 - Barrier tatics include firewall and interlock
 - Recovery tactics include repair, rollback and reconfiguration. 
 - **Redundant sensor** 
 - **Monitor/actuator** are software elements actuator controller calculate the values before sending it to physical actuator and monitor do the testing of value before sending it to physical actuator.
 - **Separate safety** In safety critical systems it is best to have separate safety critical and non critical part of system. safety critical system should be certified from some authorized agency. In safety critical system component-safety are divided into categories based on hazardous level.

#### Reliability
- It is quality which enables a service to able perform some action in specified time.
- Mean time to repair(MTTR) and Mean Time Between Failure are the reliability measures. 

#### Availability
 - It encompasses reliability, failure recovery and robustness.
 - It prevents fault manifestion into failure with lot of intermediatory/cascading errors. 
 - Fault can be prevented, tolerated, removed and forecast.
 - Security/Safety (Denial of service attack) are related qualities as their attacks are targeted to make system unavailable. Performance also related to availibility as slow system is equivalent to unavailable system.
 - Measured in term of SLA MeanTimeBetweenFailure/ (MeanTimeBetweenFailure + MeanTimeToRepair)
   - Availability tactics includes 1. Fault detection 2. Fault recovery 3. Fault prevention
   - Detecting faults includes 
     1. **Monitoring** for CPU, memory, bandwidth, disk etc.
     2. **ping/echo** pinging component checks the availability of 3rd party system/other component and is it within the network round trip time ?
     3. **Heartbeat** -  Component sends it's heartbeat periodically to system monitor.
     4. Timestamp/last read offset - detects incorrect sequence of events.
     5. conditional monitoring - validate any assumption made by the system.
     6. Sanity checking
     7. Voting - checks the results from multiple components. Replication called when multiple component belong to same deployment. Functional redundancy - when components are deployed differently to check against any design issue. Output of different component should still be same for same input. Analytic redundancy - check specification errors as well, output can be different from different components which are running different logic for same input e.g. Avionics system compute altitude using barometeric pressure, geometric distance calculation etc. 
     8. Exception detection includes timeout, message protocol checking and self tests.
   - Fault recovery includes
     1. Redundant spare: warm(backup component in passive state), hot(same state in backup component), cold(requires warming up before made available) component replace the faulty one.
     2. Rollback: rollback to saved good state, checkpointing etc. Checkpointing is a mechanism where processes in the system can be in consistent view - when all of the process reached a safe state where no message in between transit or being processed. Or they can be inconsistent view when they were some state which is in transit or message exchanged between snapshots.
     3. Recovery through exception handling.
     4. Software upgrade: function/class patch etc
     5. Retry
     6. Ignore fault
     7. graceful degradation - circuit breaker and throttling
     8. Reconfiguration it tries to switch to non-fault one

#### Usability
 - Anticipate user behaviour or human friendly feedbacks.
 - support user initiative: includes cancel, undo, aggregate, pause/resume
 - support system initiative: maintain task model, maintain user model and maintain system model.
 - Pattern of usability includes Model-view-controller, observer and memento. see designPattern.md for more details


#### Deployability
  - Manage Deployment pipeline
    1. scripted commands
    2. scale/incremental rollout
    3. rollback
  - Manage deployed service
    1. version compatibility
    2. Feature toggle
    3. package dependencies
  - Service deployment
    1. blue/green deployment: N instances of new service are deployed against N instances of old service. Discovery service is updated with new service instances. Once everything looks good old service's instances are deleted. 
    2. rolling upgrade  
  - Architectural quantum is independent deployable unit with high functional cohesion, high static coupling and synchronus dynamic coupling.  


  9. Portability

  10. Integrability
   - A system can depend on other through various paradigm
    1. syntatically: module A uses B or A inherits B or A calls B
    2. temporally: time based dependency
    3. semantically: protocol based dependency.
   - Interfaces of a component help integration better as it encapsulate a component to specific functionality. Wrapper, bridge and mediator are encapsulator.
   - Intermediatries like publisher-subscriber remove the syntatic barrier, discovery-service removes the syntatic barrier
   - **Restricting communication pattern** to adhere/force to a common protocol among components.
  
#### Testability
1. Increase observable state/reporting
  - record/playback : Especially helpful in case of highly parallel system.
  - Localize state storage
  - Abstract data sources
  - Sandboxing
  - executatble assertion


## Client side error
- We cannot observe client side errors at a server, as mostly in these error client is not able to reach servers. 
- They are mainly ISP or route related errors. 
- Clients are embedded with agents those gather localized error and send error reports to collector service. Error can be Unknown host exception, Third party CDN errors and timeouts etc.
- Collector service provides API to agents to send error reports. Collector service are deployed independently from main service. It deployed near to client as much as possible.
- Agent can be browser based or application based. In case of browser based it is crucial to not to use any user specific information including traceroute etc.


## Scheduling algorithm
 - FIFO
 - Fixed priority
  1. Semantic importance
  2. Deadline monotonic
  3. Rate monotonic
 - Dynamic prioriy 
  1. Round robin
  2. Earliest deadline first
  3. Least slack first
  4. static scheduling? 

## Communication protocols
 - polling
 - long polling
 - Websocket 
 - Server Sent events 

## Publisher/subscibe
- Temporal decouplng: producer and consumer are not actively participating in communication in timely manner.
- Entity decoupling: producer and consumer should not be aware of each other.
- Synchronization decoupling: publisher/Subscribe should not need to block producer and consumer thread.
- Routing logic
  - simple topic based
  - regex topic based
  - message's data/metadata field based.
- correctness is based on delievery semantics and ordering guarntees.
  - Delievery semantics: check `delievery semantic` in DistributedSystem.md
  - Ordering gurantees:
    - No order
    - Partition-order: casual ordering is maintained at a partition level but not across partitions
    - Total order: Ordering across all partitions
  - latency: calculated by time between message entering and message leaving the pub/sub infra.
    - compute cycles for metadata handling e.g. validation, routing etc.   
    - compute cycles for packet copy
    - storage class access - write vs read, DRAM vs disk, seq vs random access
    - persistence and ordering overhead
    - dequeuing latency: dependent on consumer speed
 ### Activemq
  - Disadvantage
    1. heavy penality of random access in case queue extend beyond RAM
    2. separate queue for each consumer.   













