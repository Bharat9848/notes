# Matrix
- Usage matrix factorization is used in collaborative filtering.
- Matrix multiplication are not commutative.
- Matrix multiplication are associative
- Banded/tridiagnol matrix is square matrix which have three non-zero elements diagnol while all others are zero. It commonly occurs in big matrices computation.
- Anisotropic scaling
- Diagonalizable matrix
- companion matrix
## Transpose operation
 - `transpose(A*B) = transponse(B) * transpose(A)` also remember that matrix multiplication is not commutative.
 - Symmetric matrix is a special matrix where `transpose(A) = A`  
 - Skew-symmetric matrix is a special matrix where `transpose(A) = -A` 
 - `transpose(A)*B = transpose(B)*A`
 - Matrix is invertible ?
 - Matrix multiplication intitution for left side of matrix,  imagine you have stacked a breakable thing like a stack (rowwise) and for right side of matrix, there is another set of object which are stacked (columnwise). Intention is to mix the row with every column  or each right object is a subcomponent of row. Now break left side stack horizontally in x pieces and right side of stack vertically in x pieces. Now multiply broken piece from row and column and then sum it. Resulting  

## Determinant
- represents the volume of a parallalpiped formed by the row or column vector of a square matrix.
- "When a diagonalizable matrix A interacts with a group of co-ordinate vectors, the ensuing distortion is termed anisotropic scaling. The determinant can aid in establishing the scale factors of this conversion. The determinant of a square matrix carries crucial insights about the linear alteration accomplished by the multiplication with the matrix. Particularly, the sign of thedeterminant mirrors the impact of the transformation on the basis of the system’s orientation." 


- Elementry matrix are matrices which are same as identity matrix but one of the zero is replaced with some number. Elementry matrix are step transformations that are done as part of Gaussian elimination. We can see end result of Gaussian elimination as `E3*E2*E1*A = U` where E3, E2 and E1 are elementary matrices. if E1 have to multiple some number with first row and add it second row that means its second row will be of form `x 1 0 0`. Similary for E2 which have to multiply some number with first row and add it to third row that means its third row would be form `x 0 1 0`.

- **Orthognal matrix**: matrix is orthogonal if inverse of the matrix is equal to its transpose. Orthogonal matrix preserve length. rows and columns are orthogonals.

## Frobenius Norm
- The Frobenius norm of a matrix the square root of sqaure of each of its element. 
## Solving linear equations
### Gaussian elimination equation
- uses row switching. scalar multiplication and then add/subtract one row to another to reach upper diagnol matrix by repeatedly using some pivot to eliminate variables from lower equation by making their cofficient zero.
- After reaching upper diagnol matrix we can do back substitution to reach the final solution.
### Reduced row echelon form
- pivots become one and all the columns values above and below pivots become zero.
- It helps in solving set of linear equations.
### LU decomposition
- given `A=LU` with U using gausian elimination
- And L using set of matrix elementary matrix for each step from guassian elimination.
- Given we have L and U, solving LUx=b is very fast for computers.

# Vector spaces and Matrix
- Vector space is set of vectors(column vector in case of matrix) and set of numbers.
- Vector space is a closed space under vector addition and scalar multiplication.
- Null space
- column space
- row space
- left null space
- Linear independence: 
  - Set of vectors are linearly independent if solution for `c1*v1 + c2*v2 ... cn*vn=0` only when `c1=c2=...cn=0`. 
  - linear dependent vectors are vectors which can be written as linear combination of each other.
- **Span**: vector space made of all linear combinations for a given set of vectors.
- **Basis**: minimum number of vector that can span the vector space.
  - Orthonormal basis: basis vectors have dot product of zero
- **Dimension**: Number of basis vectors.
- for orthonormal vectors `inverse(V) = transpose(V)`
- **Gram - Schmidt process** 
  finds the orthonormal vector basis from a vector basis.
  - uses two steps 
    1. find an orthogonal basis
    2. normalize  

## Vector operation
### dot product
 -  dot product of two vectors means visually take a projection of a vector on second vector and multiply of norm of projected vector and second vector. Also the sign of final result tell us whether vectors are pointing in same direction or different direction
 - dot product is a scalar quantity.
 - It is distributive over addition and commutative.
 - Multiply same dimension from both the vector and then sum up.
### Normalize a Vector
 - it preserves the direction but reduces the length of vector to one unit.
```math
normalizeVec = vec/norm(vec)
```` 
### Cosine of Two Vectors
  ```math
  cos(a,b) =  dot(a,b)/(norm(a) * norm(b))
  ```
### Norm of a Vector
 ```math
  norm(v) = sqrt(dot(v,v))
 ```
## Vector Transformation 
### Scaling
 - Scale it by multiplying with a vector.

### Translation
 - Take projection of vector over different arbitrary lines.

#### Eigen Vectors and Eighen Values
- covariance matrix -> Singular value decomposition -> first two matix represent eignvector, eigenvalue, other matrix 
- Eigen vector: orthogonal vector - uncorrelated features of your data.
- Eigen value: amount of information retained by each vector
- "A vector x, belonging to a d × d matrix A, is an eigenvector if it satisfies the equation Ax = λx, where
λ represents the eigenvalue associated with the matrix."

#### Singular Value decomposition
 - ???

### Rotation 
- implemented using dot product of rotation matrix and transponse of a vector. ????. Rotation matrix comes first in multiplication.
#### Rotation Matrix
 - The norm of any rotation matrix is always sqrt(2)=1.414221
- **Matrix rotation**: Rotation matrx is orthogonal matrix means multiplying any vector with it will not change its length. rotation matrix for angle `x` is represented as 
```math 
   [[cos(alpha), -sin(alpha)], [sin(alpha), cos(alpha)]] #rotates a vector by alpha angle anticlockwise.
   [[cos(-alpha), -sin(-alpha)], [sin(-alpha), cos(-alpha)]] # rotates a vector by alpha angle clockwise.
```
cos(θ): This represents the horizontal component of the rotation. It determines how much of the original vector's length is projected onto the x-axis after rotation.
sin(θ): This represents the vertical component of the rotation. It determines how much of the original vector's length is projected onto the y-axis after rotation.
-sin(θ): This is used to ensure that the rotation is counterclockwise. It effectively flips the sign of the y-component when the vector is rotate

# Rough 