# Testing
- only the public behavior
- Test should be optimized for failure
- Failure message should pinpoint where it fails(stack trace tell us). What it tries to assert rather plain true/false or number - we can use more verbose library and Hamcrest library. 
- Explicitly test for failure scenario

## TDD
 - helps you refine the requirements as you incrementally write more specific testcases.
 - Helps in defining public interfaces of your functionality
 - prevent overengineering
 - helps in writing a comprehensive test suite.
 - TDD should be used before writing any implementation and also should be used when doing refactoring.
 - Process
 	- add a failing test
 	- run all test
 	- impelement the missing functionality to pass the failing test
 	- run all test 

## Rough
Test suite
Test harness
Testing infrastructure
Testing framework / Runners