# numpy
## Functions
 - `np.histogram(list, bins=np.arange(start, end))[0]` ?
 - `np.arange(startInclusive, endExclusive)` 
 - `np.random.randomInt(startInclusive, endExclusive)`
 - `np.array([...])` creates 1-D array
 - `np.c_[list1, list2]` create 2-D array pairing elements from both the list one by one.
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
 - `np.tile(nparr, times)` returns new array with given array's element repeated given number of times.
 - `np.argsort` - sort an array give indices of the elements in ascending order
 - `np.cov(x, y, rowvar=False, bias=True)` return covariance between X and y
 - `np.corrcoef(x, y, rowvar=false)` return correlation between X and y


















