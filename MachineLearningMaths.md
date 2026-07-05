# measure of similarity
 - **covariance** is average(means divide by n) centered(means means are subtracted from value) dot product of two vectors.
 - **cosine similarity** is length normalized dot product of two vectors.  
 - **Correlation** is length normalized covariance
 - Hamming distance

 - **logit vector**: gives a score to each token in vocabulary. High logit score means high probability on a scoring criteria. Score can be negative. 
  - To convert logit score to probility `softmax` function is used which is (e^x)/Sum(e^y) where y!=x.
  
 - ginni index `1-sum(p(i))`
  
 - Entropy = `-sum(p(i)*log(p(i))`information gain. Intuitively, entropy measures how difficult it is to predict what comes next in a language. The lower a language’s entropy (the less information a token of a language carries), the more predictable that language.
 - cross-entropy: A language model’s cross entropy on a dataset measures how difficult it is for the language model to predict what comes next in this dataset.

# Famous functions

 - Jaccard similarity : measures similarity between two sets = (A intersection B)/ (A union B). It is used in full text search where number of overlapping words divided by the unique words in the snippet and query.
  
 
# Matrix
 - matrix decomposition
 - matrix factorization - 
  1. Singular value decomposition(SVD) : breaks a matrix into using rotation, streching and rotation.
  2. Alternative least squares
 - Eigen Decomposition(EigD) - eigen vector covariance matrix relation ??
 - In the real world, we start with interesting data that comes to us in the form of RSW. We don’t see the component pieces. Then we use SVD or EIGD to figure out the RS. where R matrix is rotation matrix and S matrix is scaled matrix and W matrix is patternless data which is orthogonal.

that could conceptually get us from white-noise data to the data we observed.

## Vector

## Similarity score
 - cosine similarity: measures the angle between two vector. It does not depend on the magnitude. 
 - cosine distance : `1-cosine similarity`
 - dot product: vector[a1,b1,c1] and vector [a2, b2, c2] scalar product of two vector v1 and v2 = `a1.a2+b1.b2+c1.c2`
 - Euclidean distance
 - Manhatten distance: sum(abs(a1-a2) +  abs(b1-b2) + abs(c1-c2)) for 3D vector v1 and v2.
 - Hamming distance: number of dimension to be changed in vector v1 to become other vector v2 
 - [distance](https://bib.dbvis.de/uploadedFiles/155.pdf)

----

# Gradient Descent
 - Gradient descent finds the weights and intercept that will minimize the cost function. At every iteration (tiny step descent) we used all the training examples and train our algorithm. 
 
 - **Loss function**: calculates the difference b/w a ypred(i) and y(i) of an individual training sample.
 - **Cost function**: Average of sum of all the loss function value of all the training sample.
  - **Steps**
    1. initialize `W = random(W)` 
    2. Start a loop till some good amount of loop or cost has reached some minimum threshold.
      1. compute Y vector `Y_pred = ml_algo(W)`
      2. then calculate loss function `L= (Y_pred-Y)`
      3. calculate cost function `J = (1/m)SumAll(L)`
      4. calculating descent using forumla `descent = d(J(W,b))/dW` 
      5. We readjust weights according to gradient to `W' = W - (alpha)* descent` where alpha is learning rate.

## Problems Gradient descent
 - local optima in case of low parameter space.
 - Saddle(Horse saddle) point in case of high parameter space. 
 - Plateaus: gradient is zero for a long time which make learning very slow.
## Optimization of Gradient descent
1. replacing sigmoid function with relu function have increased the speed of gradient descent. As in sigmoid plateau regions the weights change very slowly.
2. mini-batch gradient descent:
 - Used in case where training examples size is very large in tune of million.
 - Implementation notes: training example are divided into mini-batches in a inner loop and all gradient descent steps are done inside it.
 - Plotting cost vs no of iteration will show the decrease in cost but it will be noisy.
 - Choosing mini batch size is based on experiment where the speed of gradient descent is optimal. And should be power of 2 and it should fit CPU/GPU memory.
3. Gradient Descent with Momentum
 - while updating W, b for next iteration instead of using last dW and last db we use moving average of dw and db which are calculated as below.
 ```math
 for iteration 0 initialize last_Vsub(dW) = 0, last_Vsub(db) = 0. After some iteration it recovers and approximate well the series
 current_Vsub(dW) = beta * last_Vsub(dW) + (1 - beta) * dW

 current_Vsub(db) = beta * last_Vsub(db) + (1 - beta) * db

 W = W - learning_rate * current_Vsub(dW)
 b = b - learning_rate * current_Vsub(db)   
 ``` 
4. RMSProp
 - Damping the occilation of learning by using Root mean square. ssub(dW) will be small and ssub(db) will be large.
 ```math
 ssub(dW) = cons * last_ssub(dW) + (1-cons)dW^2 
 // (dW^2) is element wise multiplication
 ssub(db) = cons * last_ssub(db) + (1-cons)db^2

 W = W - learning_rate * dW/sqrt(ssub(dW) + epsilon)
 b = b - learning_rate * db/sqrt(ssub(db) + epsilon)
 epsilon is for 10^8. it is for help with division by zero
 ```
 5. ADAptive Moment (ADAM) optimization  
 - combines Gradient descent with momentum and RMS prop
 ```math
 current_Vsub(dW) = beta * last_Vsub(dW) + (1 - beta) * dW
 current_Vsub(db) = beta * last_Vsub(db) + (1 - beta) * db 
 ssub(dW) = cons * last_ssub(dW) + (1-cons)dW^2 
 // (dW^2) is element wise multiplication
 ssub(db) = cons * last_ssub(db) + (1-cons)db^2

 W = W - learning_rate * current_Vsub(dW)/sqrt(ssub(dW) + epsilon)
 b = b - learning_rate * current_Vsub(db)/sqrt(ssub(db) + epsilon)
 ``` 
 - ADAM paper suggested beta as 0.9 and cons as 0.999 and epsilon be 10^8 
 6. Learning rate decay
 - leraning rate is decayed with multiple ways   
 ```math
  1. Normal learning rate decay
   learning_rate =  learning_rate / (1 + epoch_no * decay_rate)
  2. Exponential learning_rate decay 
   learning_rate = (0.95)^epoch_no * learning_rate0
  3. other way
    learning_rate = k/sqrt(epoch_no) * learning_rate0
  4. Discrete step wise learning rate decay
    learning rate is decayed in descrete steps.  
 ```
-----   

# Computation graph
- In deep learning computaion graph shows the computation of cost function with its component at each subsequent layer.
## Forward propagation
- For deep learning algorithms X is matrix of all example vectors. Each example will be represented by a column. Thus it have dimesion of (nx, m). Y will have dimensions of (1,m)
## Backward propagation
- Process of calculation derivatives of weight starting from the last layer to previous layer and so on to calculate optimal weights for minimizing the cost.
- partial derivative dL/da, dL/dz dL/dW and dL/db for each layer is calculated.
```math
   dL/d(supern(a)) = ... depends upon the activation unit
   dL/d(supern(z)) = a - y
   dL/d(supern(w)) = dL/d(supern(z)) * supern-1(a)
   dL/d(supern(b)) = dL/d(supern(z)) * supern-1(a)
....
```
- Gradient Check technique helps in checking if back propagation calculations are correct. It should be only used for debugging, not in training. Also be careful to add any regularization component in loss function if you are using regularization in original training as well. Gradient check does not work in case of dropout regularization.


# Rough
- Chebyshev’s inequality


SET 

`dL/dz = dL/da * da/dz = (-y/a + 1-y/1-a ) * [(1- g(z))*g(z)]`

Random variable
A random variable can have many values, how do we keep track of them all? Each value that a random variable might take on is associated with a percentage. For every value that a random variable might take on, there is a single probability that the variable will be this value. Random variable are represented by the mean value and variance. We can usually say that Random variable have an expected value, give or take the standard deviation.

Type of discrete random variable.
A Binomial random variable represent a single random event happens over and over till a fixed number and we try to count the number of times the result is positive.

A geometric random variable is a discrete random variable, X, that counts the number of trials needed to obtain one success.

A Poisson Random Variable represent a variable for an event that has a small probability of happening and that we wish to count the number of times that the event occurs in a certain time frame. If we have an idea of the average number of occurrences, μ, over a specific period of time, given from past instances, then the Poisson random variable, denoted by X = Poi(μ), counts the total number of occurrences of the event during that given time period.

A continuous random variable can take on an infinite number of possible values, not just a few countable ones. They are defined using probablity density(y axis) over range of possible values.

Statistics

Measuring center of dataset : mean is sensitive to outliers its beneficial to use mean if dataset member are close to each other or variation in dataset is minimum.On the other hand median of sorted dataset is not sensitive to outliers, then its a good measurement of center if your dataset is suffering from outliers. 

The coefficient of variation is defined as the ratio of the data's standard deviation to its mean.We use this measure frequently when attempting to compare means, and it spreads across populations that exist at different scales.

The z-score is a way of telling us how far away a single data value is from the mean.By replacing each value with its z-score is same as original data value. It is a very effective way of normalizing data that exists on very different scales, and also to put data in context of their mean. 


Correlation cofficient between two variable: they might go from linear to polynomial based on level of fitness that can be find out by  mapping different model on testing data. Also it is important to realize that causation is not implied by correlation. The hypothesis relationship between two variable must be tested further.We will need to use more sophisticated statistical methods and machine learning algorithms to solidify these assumptions and hypotheses.

Assumption : Many statistical tests and hypotheses require the underlying data to come from a normally distributed population.

central limit theorem states that the sampling distribution (the distribution of point estimates) will approach a normal distribution as we increase the number of samples taken. A sampling distribution is a distribution of several point estimates.

A confidence interval is a range of values based on a point estimate that contains the true population parameter at some confidence level.A confidence level does not represent a "probability of being correct"; instead, it represents the frequency that the obtained answer will be accurate.

Hypothesis tests' framework to determine whether the observed sample data deviates from what was to be expected from the population itself.A hypothesis test generally looks at two opposing hypotheses about a population. We call them the null hypothesis and the alternative hypothesis. The null hypothesis is the statement being tested and is the default correct answer.The alternative hypothesis is the statement that opposes the null hypothesis. Our test will tell us which hypothesis we should trust and which we should reject.

Graphs : scatter plot :It is made by creating two quantitative axes and using data points to represent observations. It is very helpful in capacity planning and scalability analysis
Line graph : A line graph simply uses lines to connect data points and usually represents time on the x axis.
Bar chart : It is used when we try to compare some quatitative variable accross different group. Here X-axis does not represent any quatitative variable, it generally represent a category variable. While the y-axis is quantitative.
Histograms : It shows counts of a single column by distributing values in bins or range of values. count/bin-width should be plotted for each bin instead of count only.Several formulas exist for selecting the number of bins that yield "ideal" results under certain assumptions—in particular, n1/2 (Excel) and 3.5σ/n1/3 (Scott's rule7). 

Box graph : It shows minimum, 25 percentile mean, 75 percentile and maximum value. It is more informational for showing outliers.

Correlation simply quantifies the degree to which variables change together, whereas causation is the idea that one variable actually determines the value of another. conincidence and cofounding factor may be the reason behind the correlation of two variables. Cofounding factor is a third variable that direct show the causation betweeen two correlated variables. While coincidence shows that correlation does not imply causation. When we ignore cofounding variables then correlation become very misleading.

Simpson paradox shows there might be another cofounded variable which can break the hypothesis of two correlated variables by showing anti-correlation. The main takeaway from Simpson's paradox is that we should not unduly give causational power to correlated variables. There might be confounding variables that have to be examined.

A desirable property is robustness against outliers. A single faulty measurement should not change a rough description of the dataset.

Mean : one minute/hour rollup (???)
  
https://en.wikipedia.org/wiki/Discounted_cumulative_gain
https://en.wikipedia.org/wiki/Evaluation_measures_(information_retrieval)#Mean_average_precision
https://en.wikipedia.org/wiki/Mean_reciprocal_rank

- [RELU](https://arxiv.org/abs/1803.08375)
- [GELU](https://arxiv.org/abs/1606.08415)


Entropy and cross entropy share the same mathematical notation, H. Let P be the
true distribution of the training data, and Q be the distribution learned by the lan‐
guage model. Accordingly, the following is true:
• The training data’s entropy is, therefore, H(P).
• The divergence of Q with respect to P can be measured using the Kullback–Lei‐
bler (KL) divergence, which is mathematically represented as DKL (P | | Q). One unit of entropy and cross entropy is bits. If the cross entropy of a language
model is 6 bits, this language model needs 6 bits to represent each token.





