# Optimal Online Assignment with Forecasts
- Instead of assuming that the input is drawn i.i.d. from a known distribution or that arrives in a random order, we give the algorithm the ability to obtain a sample the set of vertices that will arrive online (i.e., a sample of the future). This aspect models common real world scenarios, where the input to the online algorithm is not entirely unknown, but can be modeled in some reasonable manner.
- We propose a two-phase model for solving the online as- signment with forecast problem. In the first (offline) phase, we use a black box to obtain a sample of vertices that will ar- rive online, and compute a compact allocation plan. In the second (online) phase, we use the allocation plan to com- pute assignments for vertices as they arrive.

## Unknown terms
- [Convex optimization](https://en.wikipedia.org/wiki/Convex_optimization)
- online bipartite matching, 
- allocation 
- budgeted bidders
## Rough
- Our technique applies to the forecast version of a large class of online assignment problems, such as online bipartite matching, allocation, and budgeted bidders, in which we wish to minimize the value of some convex objective function subject to a set of linear supply and demand constraints.
- Our solution utilizes a particular subspace of the dual space, allowing us to describe the optimal primal solution implicitly in space proportional to the demand side of the input graph.
- Bipartite matching usein randomized online algorithm that can find a matching of size n(1 − 1/e ). Paper(An optimal algorithm for on-line bipartite matching.)