# interview

## general
 - sleep well before interview
 - find all the scenarios
 - dont be eager on writing code if you are not sure about solution just try to work on examples.
 - HR divided in sourcerer and recruiter. Sourcerer find the relevant candidate 
## Mental models

## Problem brainstorming
 - Merging sorted array of size (m+n) and n to a single array in the (m+n) array in place. trick is to do reverse merging merge biggest number first and as the tail of first array would be empty. 
 - Solution can be reached more easily if I can think of some minor modification of algorithm like instead of going from parent to child, it should be from child to parent.

## Minor gotchas 
 - dont use `a-b`or `a+b` operation while creating integer comparator as its give wrong result in integer max value boundary. 
 - matrix and linkedlist questions' implementation are bit messy. 

## Design
 - speak requirement, scope, constraint before proposing the solution.
 - use lingua franca of design which includes terms like scalability, availability, resiliance, consistency, perfomace, CAP theorem, Gossip protocol etc.
 - Ask for non-functional requirement in b/w interview
 - Ask data releated questions like current size, future requirement, consumption, consistency, durability and privacy and regulatory

## LLD
 - use bottom up approach
 - Steps
   1. gathering requirement and scoping
   2. identifying the objects
   3. identifying properties and behavior of the object.
   4. Constraint and group objects based on the role in the system using abstraction, encapsulation, polymorphism and inheritance
   5. sequennce and activity diagrams for deep dives


## Behavioural
 -- see `behaviourInterview.md`

## experiences
  - Target
    1. forgot to give eventId to event
    2. Requirement miss in DSA
  - Stripe
    1. requirement miss in DSA    
  - Agoda 
  1. bill splitting app, 
  2. api rate limiter 
  3. hotel booking system
  4. Hashmap implementation and low level design for the same with concurrency
  5. Architecture round - It was majorly about the Redis internal and database internals. Not to complex. Just focused on indexing and transaction handling in microservice env where high consistency is required.
  6. given array string return min number of character change required such that no two adjacent character are same.
  


- Wayfair
 1. 75 min - hard question - 45 min system design  - 30
 custmor page visit/nearest cities
 2. LLD, HLD, Behaviorial


