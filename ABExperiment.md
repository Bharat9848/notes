# Experiments
- High Measurement cost: 
 1. Duration of a cost: running an experiment might take weeks or months based on the nature of domain 
 2. One experiment will may have goodwill risk for the system.
 3. One experiment will may have cost risk for the system.



## Measurement 
- Aggregate measurement vs multiple individual measurement: Aggregate measurement are more precise(less variation) than multiple individual measurements. Aggregate measurement will increase the measurement cost.
- **Replication**: Averaging a measurement over span of time to remove the effect of variation.
- Randomization: coin toss to run your experiment randomly than doing then sequentially helps in getting rid of sampling and confounder bias.
- **Expectation**: An expectation of central value around which actual measurement will lie. Actual value might be little less or more than expectation due to variation

------

# Stage
## Design 
- Calculate the number of individual element in aggregate needed to decided upon decision of experiment A and experiment B.
- Assuming 5% error chance or false positive rate. Following equation is from analyze stage
 ```math 
 		z < -1.64
       delta/standardError_delta < -1.64
       standardError_delta = StandardDeviation_delta / sqrt(N)
       N > (1.64 * standardDeviation_delta/delta)^2	
  ``` 
- It will require 2N individual measurement. 
- Since at design phase we do not know delta and standard deviation of delta we can assume these quantities. For delta we can assume minimum difference b/w A and B from practical business point of view. For standardDeviation_delta we must already have some data for A since system is already on A. For B's standard deviation we can assume that it will be equal to A or if we think it can be very varying from B then we can do a **pilot study** for experiment B.
- Conventionally for A/B tesing False Negative rate of 20% and false postive rate of 5% is choosen. false negative rate which is more tolerant than false positive rate because of opportunity cost in case of false negative rate is less risky than the explicit cost of switching whole system from A to B to find that B was no better. 
- **Power Analysis** considers false positive and false negative rate together to calculate the number of individual measurement needed for AB experiment. Imagine two bell curve for one representing expectation for delta for choosing A which should be centered at 0 and other bell curve representing expectation for delta for choosing B at least 1.64 distance away to the left A delta center. It have 20% overlap with bell curve A.
 ```
    Expectation of delta for B + 0.84 <= Expectation of delta for A - 1.64 // expectation for delta for A = 0
    Expectation of delta for B <= -2.48
    delta/standardError_delta <= -2.48
    standardError_delta = StandardDeviation_delta / sqrt(N)
    N > (2.48 * standardDeviation_delta/delta)^2	
 ```   


## Measure
 - Take multiple individual measurements of business metrics using randomization and replication

## Analyze
- Expectation: True mean of a population. Though impossible to get the expectation A/B tesing strive to make decision by estimating the expection.
- **Decision Logic**
 1. Null hypothesis: A and B are no different, the expectaion of difference is value of A and value of B is zero. Z-score is also zero.
 2. Alternate Hypothesis: A and B are different 
 3. Measurement from the experiment should be far off from the zero(expectation of null hypothesis) that there is less than 5% chance of being wrong - which makes the alternate hypotheis wins. Calculate z-score and it aggregate measurement z value is less than -1.64 then it is safe to take a bet.
 4. It is a bet still there is a 5% chance that B is not better than A.

- Do one sided hypothesis test. Null hypothesis will be that there is no difference between A and B. We calcuate delta which should be expected to be zero as per the null hypothesis. We calculate z-score of delta by using `delta/standard deviation( all Standard errors)` if observed value z is below -1.64 then we will call this result is statistically significatant and choose B over A. But it can be false positive which means 5% chance that B is not better than A.
- Value of actual cost between A and B is a practical and business decision which may says that below a threshold it is not worthwhile to switch from A and B.




# Problems
- unknown-unknown and known-unknown
# References
- Paper online experimentation at microsoft
- [bing experiment](https://hbr.org/2017/09/the-surprising-power-of-online-experiments)
# Rough
- Bandit Algorithm
- Bayesian optimization

# Practical
- Simulator
