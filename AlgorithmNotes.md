# Array
 - local/global maxima minima 
   1. stocks problem 2. swap integer to make maximum  
 - Anagrams
 - String concatenation
 

# Graph algorithm

1. General approaches

2. Minimum Spanning Tree
 - **Prim algorithm**  
  1. It uses greedy approach.
  2. At each iteration a non-tree node is added in result set by selecting minimum distance node from any of the so far in-tree nodes.
  3. performance ??

 - **Kruskal algorithm** 
  1. It uses greedy approach
  2. It sorts the edges by the distance. By iterating over sorted edge list it joins two union set of edge vertices.
  3. Performance  

3. Graph Traversal
  1. Breadth first
   - It is used to find shortest path in a unweighed graph.
   - Performance is `O(n + m)` where `n` is number of nodes and `m` is number of edges.  
  2. Depth first


# Advanced
 - SkipList -sorted list logN insertion logN searching
 - OrdSet/sortedSet - it is kind of skiplist- one cell have some sorted elements. cells are connected to some cells  [1](https://discord.com/blog/using-rust-to-scale-elixir-for-11-million-concurrent-users)
