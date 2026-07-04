# Terminology
- Trial or Experiment: experiment defined which result in random outcome.
- Sample Space: count of all the possible outcomes
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

# Rules
- P(A intersect B)


# Conditional probability

- It sounds similar to probability intersection of two events(`P(A intesect B)`). Given B happens what is the probability of A. 
- P(A ∩ B) = P(A and B) = P(A) · P(B|A) Why do we use B|A instead of B? This is because it is possible that B depends on A. If this is the case, then just multiplying P(A) and P(B) does not give us the whole picture. 
- `P(A|B) = P(A intersect B)/P(B)` for formula try visualizing this using venn diagram. While P(A intersect B) denotes A and B event occuring together. Conditional probability is more conditional, it is P(A intersect B) with B already happend.
- `P(A|B) = P(A intersect B)/ P(B) = P(B intersect A)/P(B) = P(B|A)*P(A)/P(B)`  

# Bayes rules
 - A is the interested event. P(A) was the prior distribution. P(B|A) ?? P(B) Marginal liklihood
	```math
	P(A|B) = (P(B|A)*P(A))/ P(B)
	```
# References
 - DasGupta, Anirban. Probability for statistics and machine learning: fundamentals and advanced topics. New York: Springer, 2011.

# Rough



