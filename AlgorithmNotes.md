# Hashing
- hash function should be random i.e. independent and uniformly.

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


## Rough
A random tree in computer science refers to a tree data structure where some aspect of its construction, structure, or properties involves randomness. There are several important contexts where random trees appear:

## Random Binary Search Trees
These are binary search trees where nodes are inserted in random order, or where the tree structure is randomized. The randomness helps achieve better average-case performance for operations like search, insertion, and deletion, avoiding worst-case scenarios that can occur with ordered input.

## Treaps (Tree + Heap)
A treap combines a binary search tree with a heap by assigning random priorities to nodes. The tree maintains binary search tree ordering by key values while also satisfying heap properties based on the random priorities. This randomization ensures good expected performance.

## Random Forests
In machine learning, a random forest is an ensemble method that constructs multiple decision trees using random subsets of features and training data. Each tree is built with randomness in feature selection and data sampling, and predictions are made by aggregating results across all trees.

## Randomized Tree Algorithms
Various algorithms use randomization in tree construction or traversal, such as:
- Random sampling for tree construction
- Randomized skip lists (which have tree-like properties)
- Probabilistic data structures based on trees

## Random Tree Generation
In algorithm analysis and testing, random trees are generated for benchmarking purposes, where the structure follows certain probabilistic distributions to study average-case behavior of tree algorithms.

The key benefit of randomness in tree structures is typically to achieve good expected performance while avoiding pathological worst-case scenarios that can occur with adversarial or ordered input patterns.