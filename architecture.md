## Books and references
 - Software architecture in practice.
 - Software Fundamentals: Collected Papers by David L. Parnas
 - Pattern-Oriented Software Architecture [Buschmann 96 and others]
 - George Fairbanks’ Just Enough Software Architecture [Fairbanks 10], 
 - Woodsand Rozanski’s Software Systems Architecture [Woods 11],
 - Martin’s Clean Architecture: A Craftsman’s Guide to Software Structure and Design [Martin 17].
 - The Software Architect Elevator: Redefining the Architect’s Role in the Digital Enterprise by Gregor Hohpe


## Architect responsibility
 1. Architect should clearly define the rules against the resources used by component if resource is a matter of concern. e.g. if latency is the resource then architect should layout guidelines for each component time budget.
 2. "Deciding when changes are essential, determining which change paths have the least risk,
assessing the consequences of proposed changes, and arbitrating sequences and priorities for
requested changes all require broad insight into the relationships, performance, and behaviors
of system software elements."  
 3. Architecture decides organizational structure through work-decomposition. Hence it is very costly due to managerial and business aspect once it is fixed.

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

 - Documentation of quality attribute using architecture pattern tactics should document where tactics are present, assumptions and rationale behind using or not using it.



### Module structure 
 - Separation of concern
 - information hiding module should hide the changeable aspect and expose the well defined interface to other module.

### Component and connectors structure

### non functional qualities
  1. **Modifiability** producer should be separated from consumer. Contract changes between modules should happen incremently. Changes should affect minimum modules. 
     Measure: wall clock time required to build, test and deploy the changes

  2. **Performance** 
    1. **Latency**: 
      - time each component, use of shared resources, inter element communication frequency and volume.
      - e.g. Stock exchange etc
    2. **Throughput**
      - Batching of messages in messages exchange system like kafka
      - binary messaging alongwith compression
      - no copy of data in different system in between intermediateries.
       
  3. **Security** 
    - introduce safeguards against your critical data. 
    - special authorization policy

  4. **Safety**
   - keep part of the system functional even though part of system is under fault.
   - keep the system out of hazardous state.

  5. **Availibility**
   - It encompasses reliability, failure recovery and robustness.
   - It prevents fault manifestion into failure with lot of intermediatory/cascading errors. 
   Fault can be prevented, tolerated, removed and forecast.
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
     2. Rollback: rollback to saved good state, checkpointing etc.
     3. Recovery through exception handling.
     4. Software upgrade: function/class patch etc
     5. Retry
     6. Ignore fault
     7. graceful degradation 
     8. Reconfiguration it tries to switch to non-fault one

  6. Usability
  7. Testability
  8. Deployability
  9. Portability
