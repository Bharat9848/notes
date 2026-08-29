# Terminology
- Trial or Experiment: experiment defined which result in random outcome.
- Sample Space: count of all the possible outcomes
- Probabilty distribution: probability collection of statement/samples which are exclusive(no more than one statement can be true) and exhaustive(at least one statement can be true).
- joint probability: P(A and B)
- Marginal probability P(y2) = P(x1, y2) + P(x2, y2) + P(x3, y2) given x1,x2,x3 makes probability distribution for X. y2 belongs to event Y.

## Event
Non empty portion of sample space.
  1. Compound event 	
	- combination of primitive events e.g. dice showing odd number
	- non-overlapping compound events have probability sum of 1.
	- compound events can be recursive or overlapping. In this case we have to subtract overlapped times minus one.
  2.  primitive event 
	- one of the possiblity or outcome e.g. rolling dice gives six.
	- probability can be calculated using count.
	- Probability is a measure of a likelihood of an event occuring when an experiment is concluded.
  3. Independent Events
	- when one event does not interfere in the likelihood of another event.
	- Mathematically `P(A and B) = P(A) * P(B)`
  4. Mutually Exclusive Events 
 	- When two events have no shared outcome means P(A intersect B) = 0 
 	- P(A union B) = P(A) + P(B)
  5. Complementary Event of an event
  	- Event comprises of sample space not covered in original sample space.	
-----
## Complex Counting
1. Factorial
2. N choose R
3. Permutation
4. with replacement
5. without replacement

## Counting ways
1. **Multinomial Distribution** used for Counting ways to choose r classes of n1, n2, n3... nr items from n objects `n!/n1!*n2!*n3!*....*nr!`
2. **Binomial distribution** used for counting ways to choose 1 class of k items from n object `n!/(n-k)!*k!`
-----
# Random variable
## Discrete Random Variable
 - a Random variable that can assume a finite or countably infinite number of potential outcomes. E.g. Random variable can represent a coin toss, or Number of cars passing through toll booth in an hour. In second example number of cars can zero to infinite each represent an outcome. 
 - **Expected** value of a random variable - it is the probability weighted average of all outcome. 
  - It provides the summary of all or some values that a random variable can take.
 - PDF of a random variable allow the modeling of a random process.
 - It helps in visualizing and compute various function like pdf, Expectation like `P(a<X<=b)`, 
 - Pdf(X) allow calculation of various complex formulas.

### Probability Distribution of a Random Variable 
 -`P(X)` is a function that defined probability distribution of random variable X taking on various value at random.
### Probability Mass Function
  - helps in graphical represenation of probability distribution function. PMF is represented using histogram, where each bar represents probability from possible outcomes. Sum of all probabilities should be 1.		

## Continuous Random Variable 
### Probability Density Function: 
- It is probability curve of a continuous random variable at various values of random varibale X.

### Cumulative Density Function  	
- relevant for both discrete as well as cumulative random variables. 
- It is Probability of X <=x. And it is calculated using integration of probability density function.

## Maximum Likelihood Estimation
- Estimate parameters of probability distribution.
- "The maximum likelihood estimate (MLE) is the parameter vector value that offers the maximum value for the likelihood function across the parameter space."

## Transforming function from one random variable to other
 - We cannot apply transforming function to a PDF of a random variable but we can do the same to the CDF of the variable. We start from CDF of transformed random variable to the equivalent of CDF of given random variable then take derivative of CDF to arrive at PDF of new random variable. 

# Conditional probability

- It sounds similar to probability intersection of two events(`P(A intesect B)`). Given B happens what is the probability of A or What is the probability of A happening give partial information of B happened.
- **Multiplication Law** `P(A ∩ B) = P(A and B) = P(A)*P(B|A) = P(A|B)*P(B)` Why do we use B|A instead of B? This is because it is possible that B depends on A. If this is the case, then just multiplying P(A) and P(B) does not give us the whole picture.
- **Law of total probability** `P(A) = SumAllBi(P(A|Bi)*P(Bi))`  given B0, B1, B2... Bn are disjoint sets.
- `P(A|B) = P(A intersect B)/P(B)` for formula try visualizing this using venn diagram. While P(A intersect B) denotes A and B event occuring together. Conditional probability is more conditional, it is P(A intersect B) with B already happend. Here we are zooming inside from the universal set Omega to B and check what are the counts where A also happend given we are in B.
- A and B are independent. Means the happening of event A does not give any information about happening of B.
 `P(A and B) = P(A)*P(B) => P(A and B)/P(B) = P(A)*P(B)/P(B) => P(A|B) = P(A) `

-----
# Bayes rules
 - A is expansive to measure and B is the symptom or test result. e.g. probability of a disease given test result/symptom 
 - A is the interested event. P(A) was the prior distribution. P(B|A) probability of B given A. P(B) is Marginal liklihood.
	```math
	P(A|B) = (P(B|A)*P(A))/ P(B)
	```
	Posterior probability = P(A|B) means probability of A after B is observed.
	Prior probability = P(A) means probability of A before any data or new data is observed
	Likelihood = P(B|A) probability of observed new data given A.
	Marginal probability = P(B) Probability of observed data. which can be written as sum rules of various P(B|Asub(i))


 - Bayes rule help in problem like **inverse Probability problem**
   B = observed data, A = possible process i with probability parameter thetasub(i). Process can be action on different entity each have different probability parameter. We want to calculate whats the probability of different process given observed data.  
   ` P(process parameter| observed data) = P(observed data|Process parameter) * P(process parameter) / (P(obseved data | parameter 1) *P(Parameter 1) + P(observed data|parameter2)*P(parameter2) + P(observed data|paramtern) * processN)`

 - Principle of indifference allows calculation of prior probability  which mean probability of parameteri prior to the experiment

 - Bayes theorem allows updating our probability based on new data. Here the previously calculated P(process paramter|observed data) becomes the new prior distribution.

------
# Binomial Theorem
 - Given possible outcomes are binary, binomial theorem tells us the probability of observing certain number a an outcome after certain number of trials. 
 - ```math
    N = total number of trials
    S = number of occurance of outcome1
    P(A) = probality of outcome1
    P(X) = probability of observing outcome1 S number of times in N number of trials
    P(X) = Combination(N choose S) * P(A)^S * (1- P(A))^(N-S) 
 ```
 - Bayes theorem combine with binomail theorem.
------

# Distributions

 1. **Binomial**
 - Variable made of N independent bernouli distributed random variables makes one binomial variable. It is denoted as X~binomial(n,p) where n is number of independent bernouli random variable and p is probability of getting value 1 for the single bernouli random variable. Probablity of bernouli random variable B1, B2, B3 ... BN having K ones is a binomial random varibale X `P(X=k) = (n choose k)*(p^k)*(q^(n-k))`

 2. **Normal** / **Gaussian**: 
 - When Number of random variables in binomial distribution is becoming large and term `npq` is not too small then binomial distribution becomes normal distribution. It is denoted by X ~ normal(np, sqrt(npq)) where np is mean and sqrt(npq) is standard deviation. Binomial distribution starts to converge to normal distribution starting from n=30 given p is not very small.
 - Give X is normally distributed random variable `P(X=x) = (1/sqrt(2*pi)*std)* e ^ (- (x-mu)^2/2*std^2)` where mu is mean and std is standard deviation.
 - Standard unit normal is a transformation we do to other normal distribution variable to make our calculation easier.
 3. **Bernouli**
  - Bernouli distributed random variable can only take two values(0 or 1). Probability for value 1 is called `p` and probability for value 0 is called `q`. 

 4. **Poisson**: 
 - When Number of random variables in binomial distribution is becoming large and term `np` or `nq` is too small then binomial distribution becomes poisson distribution. It helps in calculating probability of rare events. It is denoted by X ~ poisson(lambda) where lambda = `np`.
 - it calculate the probabilty of discrete number of events given the avg rate.
 - it is used to calculate probabilty of rare events and queueinng theory. 
 - `P(X=k) = ((lambda^k)/k!) *e^-lambda where l`

 5. **Geometric distribution** measures the probability of getting a choice in a given set of trials. 
 - probability of happening of bernouli random variable event p at exactly nth trial  `P(X = n) = (q^n-1)*P`

 6. Log-Normal Distrubution
 8. Exponential Distribution: 
 - when an rare event will happen or help in modeling the lifetime of a rare event.
 - ```math
 		P(T = t) = if t>=0 lambda*e^(-lambda*t) else 0
   ````
 - Lambda represent the average life of the rare event
 - memoryless property `P(T>t+s|T>s) = P(T>t)`
 - Hazard rate is probability of risk event in another dt time period given it survive t.
   ```math
   P(T<=t+dt|T >t)=  1 - P(T > t+dt| T>t)
   = 1 - P(T>dt) // by using memoryless property
   = 1 - e^(-lambda*dt) // by using cdf
   = 1 - (1-lamdba*dt + 1/2 * lambda^2 * dt^2 + .....)
   = lambda*dt
   OR
   P(t < T <= t+dt) = lambda * P(T > t) * dt
   ``` 
 9. Gamma Distribution: for random variable to denote the waiting time of rth rare event.
 		```math
 			T(r, lamdba)
 			P(T > t) ~ P(No of poisson process in t time <= r-1) = SumAll k=0 to r-1(poisson for k events)
 			pdf = e^(-lambda*t) * lambda^r * t^(r-1) / (r-1)! 
 		```
   
# References
 - DasGupta, Anirban. Probability for statistics and machine learning: fundamentals and advanced topics. New York: Springer, 2011.

# Question
1. What is the probability that, in six throws of a die, there will be exactly one each of “1”  “2”, “3”  “3”“, 3, ” “4”  “4”“, 4, ” “5”  “5”“, 5, ” and “6”  “6”“, 6, ” ? ans There are 6!=720 permutations where each face occurs exactly once. There are 6×6×6×6×6×6=46656 total permutations of 6 throws. The probability is therefore 720/46656=0.01543210

# Rough
Question 7
If it rains, I do not go sailing. It rains 10% percent of days;  I go sailing 3% percent of days. If it does not rain, what is the (conditional) probability that I go sailing?
Written "p(I go sailing | it does not rain)''? = 


The factory quality control department discovers that the conditional probability of making a manufacturing mistake in its precision ball bearing production is 4% on Tuesday, 4%, percent on Wednesday, 4% percent on Thursday, 8% percent on Monday, and 12% percent on Friday. The Company manufactures an equal amount of ball bearings (20% percent ) on each weekday.  What is the probability that a defective ball bearing was manufactured on a Friday?
`P(friday|defective) = P(defective|friday) P(friday) / P(defective|monday) P(mon) +P(defective|tue) P(tue) +P(defective|wed) P(wed) +P(defective|thur) P(thur) +P(defective|friday) P(friday) + P(defective|sat) P(sat) +  P(defective|sun) P(sun)  = (12*1/7) / (8*1/7 +4 *1/7 + 4*1/7 + 4 *1/7 +12 *1/7) = 12/32 =0.375`

Question 1
What additional statement, added to the three below, forms a probability distribution?
(1) I missed only my first class today P(missed first and attend second)
(2) I missed only my second class today P(attend second and missed second )
(3) I missed both my first and second class today P(missed first and missed second)

Question 4
The probability that I will go sailing today AND the fair six-sided die will come up even on the next roll is .3. If these events are independent, what is the probability that I will go sailing today?    P(sailing and dice even)  = .3  = P(sailing)* P(even) => 0.3 = P(sailing)* 0.5 => P(sailing) = 0.6



2. 
3.
6. full house = denominator = P(5/52) = 5 choose 52  = 2598960. count of numerator = count of a kind * count of 3 choose 13 * count of second kind * count of 2 choose 13
8. 

My friend takes 10 cards at random from a 52-card deck, and places them in a box. Then he puts the other 42 cards in a second, identical box. He hands me one of the two boxes and asks me to draw out the top card. What is the probability that the first card I draw will be the Ace of Spades?

Question 11
What is the probability, if I flip a fair coin with heads and tails ten times in a row, that I get at least 8
88
 heads?

 
 Question 12
Suppose I have either a fair coin or a bent coin, and I don’t know which. The bent coin has a 60%
60%60, percent
 probability of coming up heads.
I throw the coin ten times and it comes up heads 8 times. What is the probability I have the fair coin vs. the probability I have the bent coin? 
Assume at the outset there is an equal (.5,.5)
(.5,.5)left parenthesis, point, 5, comma, point, 5, right parenthesis
 prior probability of either coin.

*Please note that in order to fit the entire formula in the feedback, probability has been abbreviated to "prob."