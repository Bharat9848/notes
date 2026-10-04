

# Experiments
- High Measurement cost: 
 1. Duration of a cost: running an experiment might take weeks or months based on the nature of domain 
 2. One experiment will may have goodwill risk for the system.
 3. One experiment will may have cost risk for the system.(?)



## Measurement 
- Aggregate measurement vs multiple individual measurement: Aggregate measurement are more precise(less variation) than multiple individual measurements. Aggregate measurement will increase the measurement cost.
- **Replication**: Averaging a measurement over span of time to remove the effect of variation.
- Randomization: coin toss to run your experiment randomly than doing then sequentially helps in getting rid of sampling and confounder bias.
- **Expectation**: An expectation of central value around which actual measurement will lie. Actual value might be little less or more than expectation due to variation

------

# Stage
1. Design 
- Calculate the minimum number of sample to take what is needed to decided upon decision of experiment A and experiment B.
- Assuming 5% error chance or false positive rate. Delta is difference between the value of B and A. Negative value indicated B is better than A. Following equation is from analyze stage. For a normal distribution with mean zero and standard deviation one (a unit normal), 5% of the distribution falls below -1.64.
 ```math 
       delta = aggregate_B - aggregate_A                                                                       // aggregate_X = np.list(measurements).mean 
       Standard_deviation(delta) = np.sqrt(aggregate_B^2 + aggregate_A^2)

 		 zscore of delta < -1.64                                                                                 // for difference b/w A and B to be statistically significant.  
       delta/standardError_delta < -1.64                                                                      // z score = x-mean(X)/std(X)
       standardError_delta = Standard_deviation(delta) / sqrt(N)
       N > (1.64 * standardDeviation_delta/delta)^2	
  ``` 
- It will require N individual measurement for each A and B experiment. 
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

2. Measure
 - Take N number of individual measurements of business metrics using randomization and replication.
 - Calculate standard error from standard deviation of the measurements.

3. Analyze
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



# Multi-Arm Bandit
- In AB experiment traffic is statically send traffic to A and B. If B is costly then we have to bear the cost. To make this more cheaper, multi-arm bandit algorithm entails for system to keep sending traffic to better alternative  while occasionally sends traffic to less benificial one.
- **Regret**: after running A/B test, overall system gain is avg of A and B if system would have already chosed the better alternative than the system gain would be more. This lost opportunity is called regret. Instead if we have run Multi-Arm bandit the regret would be less. 
- **interaction effect** when changes are not independent and have an effect on each other. It results in more than two experiments
----
## **Thompson Sampling**: 
 - Use better statistic to choose better aleternative. It calculate Probability for each arm to signify if it is the best one. Then choose the arm based on the calculated probability. 
 - Bootstrap sampling can be used to calculate for each arm to get the aggregate measures. But it is expensive each time we want to choose the data as it is of O(T)^2.
 - Online Bootstrap algorithm helps in performance improvement it maintains the number of bootstrap samples as it process the new data. It choose randomly from already maintained samples.
 - Number of bootstrap samples is usually in tune of 100 or it can be large but it will be less faster.
 - estimate of CTR should be precise enough to the required practical significance. Fixing discretization error we can calculate the size of sample in single bootstrap aggregate sample .
 - O. Chapelle and L. Li, “An empirical evaluation of Thompson sampling,” in Proc. 24th Int. Conf. on Neural Information Processing Systems, 2011, pp. 2249-2257).
----
## Epsilon-Greedy
 - Uses summary statistic to choose better alternative.
 - A variable - epsilon is used to tune scale at which to run MAB test:
  1. complete turn-on(epsilon=0) exploit 
  2. complete turn-off(epsilon=1) explore or
  3. exploit at probability of (1-epsilon) versus explore at epsilon which can be some static value or A/B test.
 - Algorithm
 ```
  MAP_epislon_greedy(epsilon){
   select = null
   if(random(0,1) < (1 - epsilon)){
      // exploit
      if (A_aggregate > B_aggregate) {
         select = A
      } else {
         select = B
      }

   } else {
      // explore
      if(random(0,1) < 0.5){
         select = A
      } else {
         select = B
      }
   }
   return select
  } 
   
 ```  
 - when to stop the test we can choose some very low value of epsilon where epsilon value is dynamic - optimal asymptotic regret and based on the formula. Epsilor is multiplication of `noOfArms * explore_boost_factor * decaying_factor`. P.S. explore_boost_factor should be determined through experiment.
  ```math
   epsilon = number_of_arms * c * (BMmax/PS)/n
   where n is number of iteration
   BMmax is plausible max value of summary aggregate
   PS is practical significance smallest change which is worthy to allow changes in the system.
   c metaparameter to control how much epsilon to above 1 to make system explore more.
  ```

