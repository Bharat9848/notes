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
 -**Sigmoid function** : used in mapping of classification of data in between 0 and 1. 
 - Formula = 1/(1+e^(-z)).

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


## Gradient Descent
  - **Steps**
   1. use random weights W to computed Y_pred = XW
   2. then calculate error = (Y_pred-Y) 
   3. Start a loop
      1. finding local minima by taking derivative `d(XW - Y)/dW` (why do it for W bcas we dont want to change X and Y.) 
      2. We readjust weights according to gradient to `W' =W - (alpha)* descent` 

# Rough
- Chebyshev’s inequality


SET 
Jaccard similarity : measures similarity between two sets = (A intersection B)/ (A union B) 



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





