## Books and references
 - Software architecture in practice.
 - Software Fundamentals: Collected Papers by David L. Parnas
 - Pattern-Oriented Software Architecture [Buschmann 96 and others]
 - George Fairbanks’ Just Enough Software Architecture [Fairbanks 10], 
 - Woodsand Rozanski’s Software Systems Architecture [Woods 11],
 - Martin’s Clean Architecture: A Craftsman’s Guide to Software Structure and Design [Martin 17].


## Architect responsibility
 1. Architect should clearly define the rules against the resources used by component if it is a matter of concern. e.g. if latency is the resource then architect should layout guidelines for each component time budget.



 - A structure is architectural if it supports reasoning about the system and the system’s properties. The reasoning should be about an attribute of the system that is important to some stakeholders meanwhile supressing the non-important attributes.
 - Starts with skeletal architecture with minimum functionality while serving most important qualities. Then grow the system incremently.
 - Separation of concern
 - information hiding module should hide the changeable aspect and expose the well defined interface to other module.

 - Qualities
  1. **Modifiability** producer should be separated from consumer. Contract changes between modules should happen incremently. Changes should affect minimum modules. 
  2. **Performance** time each component, use of shared resources, inter element communication frequency and volume.
  3. **Safe** introduce safeguards against your critical data.
  4. **Secure** 


Book quotes
 1. Software architecture in practice
  - The software architecture of a system is the set of structures needed to reason about the system. These structures comprise software elements, relations among them, and properties of both. There are three categories of structures:1. Module structures show the system as a set of code or data units that have to be constructed or procured. 2. Component-and-connector structures show the system as a set of elements that have runtime behavior (components) and interactions (connectors).3. Allocation structures show how elements from module and C&C structures relate tononsoftware structures (such as CPUs, file systems, networks, and development teams).