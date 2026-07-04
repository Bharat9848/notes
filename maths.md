## Glossary
 - Lemma
 - Corollary
 - Theorem
- when to take arithmatic mean / harmonic mean/ geometric mean.

# logarithms
- Scaling usecase: Logarithms have a magnifying and dilating effect. Basically, taking the log of values greater than one— such as a positive number of documents —compresses the difference between values, while taking the log of values between zero and one — such as one divided by a count—expands the spacing. It tackles Underflow problem in computer science - floating point number calculated cannot be represented by floating point datatype representaion.
---

# Vector
- dot product- also called inner product
- length is also called norm
- vector is called normalized if length of the vector is 1.
- orthogonal vectors which are perpendicular to each other.
- outer product

---


# Sampling
- **Greedy sampling**: choose the sample with highest probability on a scoring criteria.
- top-k sampling: choose top k highest probabilites on a scoring criteria.
- Nucleus sampling or top-p sampling: it uses top-k sampling underneath but it compute k more dynamically which differ from input to input. e.g. when set to 0.9 means that sampling would consider samples which scores sum made it to 90 percent.
- min-p sampling: minimum probability that a token must reach to be considered during sampling

---
# Log
- `log(a*b)= log(a) + log(b)` 
- `log(a/b)= log(a) - log(b)`



---
# Trignometry
## Formulas
1. `cos(x + y) = cos(x)cos(y)- sin(x)sin(y)`
2. `sin(x + y) = sin(x)cos(y) + cos(x)sin(y)`
3. `cos(-x) = cos(x)`
4. `sin(-x) = -sin(x)`
---- 
# calculus
## Single variable calculus
- Taylor series
----
# Derivatives
- it is slope of a function.
- chain rule: `d(y)/d(x) = d(y)/d(z) * d(z)/d(x) 
----
# Algebra
1. Exponentially Weighted Average/ Moving average:
 - Used when you want to use sliding window average. 
 - It is less acurate than the sum last x values then do average.
 - It is less computationally expensive. 
 - `value(t) = (alpha)* value(t-1) + (1-alpha)*currentVal` with alpha value dictate the lookback window of (1/1-alpha) values
 - Start of the series due to lack of lookback values it is very drastically differ from actual average. To remedy the situation `value(t)` is divided with bias term `1-alpha^t` 

## Rough
- Lagrange interpolation


## Graphs
- free online tool to plot [graph](https://www.desmos.com/calculator) 