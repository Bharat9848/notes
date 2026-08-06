# Experiments
- High Measurement cost: 
 1. Duration of a cost: running an experiment might take weeks or months based on the nature of domain 
 2. One experiment will may have goodwill risk for the system.
 3. One experiment will may have cost risk for the system.

# Stages
1. **Design**
 - Determine number of measurements to take	
2. **Measure**
 - Take multiple measurements of business metrics.
3. **Analyze**
 - Decide whether to accept or reject B version.

## Measurement 
- Aggregate measurement vs multiple individual measurement: Aggregate measurement are more precise(less variation) than multiple individual measurements. Aggregate measurement will increase the measurement cost.
- Replication: Averaging a measurement over span of time to remove the effect of variation.
- Randomization: coin toss to run your experiment randomly than doing then sequentially helps in getting rid of sampling and confounder bias.



- Design - Calculate the number of individual element in aggregate needed to decided upon decision of experiment A and experiment B.

- Measure

## Analyze
- Expectation: A predictable number
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
