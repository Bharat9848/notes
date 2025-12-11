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

## Matrix
- Usage matrix factorization is used in collaborative filtering.
- Matrix multiplication are not commutative.
- Matrix multiplication are associative
- Banded/tridiagnol matrix is square matrix which have three non-zero elements diagnol while all others are zero. It commonly occurs in big matrices computation.
- Transpose
 - `transpose(A*B) = transponse(B) * transpose(A)` also remember that matrix multiplication is not commutative.
 - Symmetric matrix is a special matrix where `transpose(A) = A`  
 - Skew-symmetric matrix is a special matrix where `transpose(A) = -A`  


---
# calculus
## Single variable calculus
- Taylor series
## 

## Rough
- Lagrange interpolation