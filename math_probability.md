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
## Discrete Random Variable
 - a variable that can assume a finite or countably infinite number of potential outcomes. E.g. Random variable can represent a coin toss, or Number of cars passing through toll booth in an hour. In second example number of cars can zero to infinite each represent an outcome. 
 - **Expected** value of a random variable - it is the probability weighted average of all outcome. 
### Probability Distribution of a Random Variable 
 - For each possiblity of outcomes we assign a probability.
### Probability Mass Function
  - helps in graphical represenation of probability distribution function. PMF is represented using histogram, where each bar represents probability from possible outcomes. Sum of all probabilities should be 1.		

## Continuous Random Variable 
### Probability Density Function: 
- It is for calculating the probability of a continuous random variable within a range.
### Cumulative Density Function  	
- relevant for both discrete as well as cumulative random variables

## Maximum Likelihood Estimation
- Estimate parameters of probability distribution.
- "The maximum likelihood estimate (MLE) is the parameter vector value that offers the maximum value for the likelihood function across the parameter space."



# Conditional probability

- It sounds similar to probability intersection of two events(`P(A intesect B)`). Given B happens what is the probability of A. 
- P(A ∩ B) = P(A and B) = P(A) · P(B|A) Why do we use B|A instead of B? This is because it is possible that B depends on A. If this is the case, then just multiplying P(A) and P(B) does not give us the whole picture. 
- `P(A|B) = P(A intersect B)/P(B)` for formula try visualizing this using venn diagram. While P(A intersect B) denotes A and B event occuring together. Conditional probability is more conditional, it is P(A intersect B) with B already happend.
- `P(A|B) = P(A intersect B)/ P(B) = P(B intersect A)/P(B) = P(B|A)*P(A)/P(B)`  
- A and B are independent 
 `P(A and B) = P(A)*P(B) => P(A and B)/P(B) = P(A)*P(B)/P(B) => P(A|B) = P(A) `

-----
# Bayes rules
 - A is the interested event. P(A) was the prior distribution. P(B|A) ?? P(B) Marginal liklihood
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
# References
 - DasGupta, Anirban. Probability for statistics and machine learning: fundamentals and advanced topics. New York: Springer, 2011.

# Question
1. What is the probability that, in six throws of a die, there will be exactly one each of “1”  “2”, “3”  “3”“, 3, ” “4”  “4”“, 4, ” “5”  “5”“, 5, ” and “6”  “6”“, 6, ” ? ans There are 6!=720 permutations where each face occurs exactly once. There are 6×6×6×6×6×6=46656 total permutations of 6 throws. The probability is therefore 720/46656=0.01543210

# Rough
Question 7
If it rains, I do not go sailing. It rains 10%
10%10, percent
 of days;  I go sailing 3%
3%3, percent
 of days.
If it does not rain, what is the (conditional) probability that I go sailing?
Written "p(I go sailing | it does not rain)''?


The factory quality control department discovers that the conditional probability of making a manufacturing mistake in its precision ball bearing production is 4%
4%on Tuesday, 4%
4%4, percent
 on Wednesday, 4%
4%4, percent
 on Thursday, 8%
8%8, percent
 on Monday, and 12%
12%12, percent
 on Friday. 
The Company manufactures an equal amount of ball bearings (20%
20%20, percent
) on each weekday.  What is the probability that a defective ball bearing was manufactured on a Friday?


Question 1
What additional statement, added to the three below, forms a probability distribution?
(1) I missed only my first class today
(2) I missed only my second class today
(3) I missed both my first and second class today

Question 4
The probability that I will go sailing today AND the fair six-sided die will come up even on the next roll is .3
.3point, 3
. 
 If these events are independent, what is the probability that I will go sailing today?