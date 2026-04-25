# numpy
## numpy arrays
 - `np.array([...])` creates 1-D array
 - `np.c_[list1, list2]` create 2-D array pairing elements from both the list one by one.
 - property `arr.shape` is for arrays dimension
 - property `arr.size` returns 1st dimension length?
 - `+`, `*` opreators etc do element wise operation given all rows have same size or matrix is not malformed.
 - Transpose `arr.T` does not affect 1-D array.
 - `np.expand_dims` add extra empty dimensions and given dimension -  0 means column, 1 means row.
 - column selection: `arr[:, colIndex]` returns 1d array of column values

## Vector and Matrix function
 - `np.linalg.norm` do normalization of matrix row-wise, col-wise or all elements.
 - `2dArr - rowVec`	do vector subtraction row wise.
 - `euclidean distance` is norm of `vectorA-vectorB`

## Functions
 - `np.histogram(list, bins=np.arange(start, end))[0]` ?
 - `np.arange(startInclusive, endExclusive)` 
 - `np.random`
 	- `np.random.randomInt(startInclusive, endExclusive)`
 	- `np.random.uniform(start, end, noOfValues)`returns 1D array with uniform values between start and end.
 	- `np.random.normal(mean, std, noOfValues)` returns normal distribution values with given mean and standard deviation. 
 	- `np.random.rand(X,Y)` will generate random number between 0 and 1 of shape(X,Y)
 - `np.dot(npArr1, npArr2)`
 - np.meshgrid(1Darr2, 1Darr2)
 - `np.poly1d` gives us an easy helper to define polynomials by specifying the leading
coefficients on each term in the polynomial. For example, we specify 2x2 + 3x + 4 by
passing in a list of [2, 3, 4].
 - `np.allclose` for checking floating point comparison. Floating point number cannot be compared with `==` 
 - `<nparray>.reshape(1,-1)` ??
 - `np.zeros_likes(npArray)` create an array with all values zero equal to length of given array.
 -  `np.linspace(start, end, size)` create equal spaced array between range start and end of given size.
 - `[::-1]` reverse the order i.e first become the last, second become the second last.
 - `np.arange(somenumber)` equals to range(0, no)
 - `np.where(<column boolean>, true, negative)` returns partition column with true value and negative value. 
 - `np.where(boolean)`returns pair with zeroth element containing array of indexes where condition holds true.  
 - `np.tile(nparr, times)` returns new array with given array's element repeated given number of times.
 - `np.argsort` - sort an array give indices of the elements in ascending order
 - `np.cov(x, y, rowvar=False, bias=True)` return covariance between X and y
 - `np.corrcoef(x, y, rowvar=false)` return correlation between X and y
 - `np.squeeze` remove extra dimension
 - `np.ones(<shape>)` create an array of all 1s of given shape
 - `np.zeros(<shape>)` create an array of all 0s of given shape
 - `np.mean` do mean on whole array or axis wise	
 - `np.argmin` gives the index of lowest value.























