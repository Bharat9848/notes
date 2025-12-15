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
 - Matrix is invertible ?
 - Determinant
- **Orthognal matrix**: matrix is orthogonal if inverse of the matrix is equal to its transpose. Orthogonal matrix preserve length. rows and columns are orthogonals.
- **Matrix rotation**: Rotation matrx is orthogonal matrix means multiplying any vector with it will not change its length. rotation matrix for angle `x` is represented as 
```math 
  [[cos(x), -sin(x)], [sin(x), cos(x)]]
```
cos(θ): This represents the horizontal component of the rotation. It determines how much of the original vector's length is projected onto the x-axis after rotation.
sin(θ): This represents the vertical component of the rotation. It determines how much of the original vector's length is projected onto the y-axis after rotation.
-sin(θ): This is used to ensure that the rotation is counterclockwise. It effectively flips the sign of the y-component when the vector is rotate



---
# Trignometry
## Formulas
1. `cos(x + y) = cos(x)cos(y)- sin(x)sin(y)`
2. `sin(x + y) = sin(x)cos(y) + cos(x)sin(y)`
---
# calculus
## Single variable calculus
- Taylor series
## 

## Rough
- Lagrange interpolation