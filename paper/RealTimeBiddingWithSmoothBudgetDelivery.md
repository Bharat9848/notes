- Our approach first applies a control feedback loop to iterativel estimate the future spending rate in order to impose smooth delivery constraints. Then, the spending rate is used to select high quality impressions and adjust the bid price based on the prior performance distribution to maximize the performance goal.
- Try to see impression have a value and cost Bid optimizaiton problem is 
```Math
 Maximize(SumAll(i)(vi * xi)) subjected to SumAll(j)(cj*xj) <= bt 
 where xi is a 0 or 1(boolean) to indicate to bid in adrequest i or not
 cj is cost of adrequest j   
 bt is  budget allocated to time period t
```
# Smooth delivery 
- Constraints
```math
 1. `Math.abs(B - sumall(t)st) < epsilon` // difference between daily budget B and actual spend at time slot t should not be greater than absolute
 2. `Math.abs(bt - st) < epsilon/total(t) // difference between budget allocated for time slot t bt and actual spend t should not be greater than some small epsilon
 3. `eCPM <= M` // effected CPM should be smaller than advertiser set daily CPM limit M 
``` 
- spend at time t propotional to number of impressions. No of impressions equals to `req(t)*Pacing_rate*win_rate`. Feedback loop for pacing
```math
     spend(t+1) = req(t+1) * pacing_rate(t+1) * win_rate(t+1)
     spend(t) = req(t) * pacing_rate(t) * win_rate(t)
     pacing_rate(t+1) = (pacing_rate(t) * win_rate(t) * req(t) * spend(t+1))/ (req(t+1) * win_rate(t+1) * spend(t))
``` 
For above equation win_rate(t+1) and req(t+1) can be approximated from historical trends. spend(t+1) can calculated using below formulas as based on different pacing type. 
For uniform pacing `spend(t+1) = budget_left * 1/(T - t)`
For intelligent pacing `spend(t+1) = budget_left * p(t+1)/sumAll(t)p(t) where t range from t+1 to T`. p(t) is probability of click or conversion.

- find Quality ad requests within time interval t for campaign with fixed pricing.
 1. calculate number of request to bid on within time interval 
 ```math
 impressions_required = spend_required(t)/fixed_bid
 bid_required = impressions_required/win_rate(t)
 req_required = bids_required/pacingrate(t)
 ```
 2. select req_required from total request which have CTR or AR score above certain treshold tau
  - How to find treshold CTR/CVR `tau(t)`
  1. Plot a histogram of CTR/CVR of ad request from historical time period. X axis would be CTR/CVR b/w 0 to 1. Y axis would number of ad request having CTR/CVR x.
  2. do reverse cumulative density sum starting form CTR/CVR 1 towards CTR/CVR 0. and stop at limit CTR/CVR value tau(t) where sum crosses no of req_required.
 3. `tau(t)` gives ocillation like behavior bcas of reality and historical based. To compensate we evaluate confidence interval of threshold parameter `tau(t)` 
 ```math
      mean(tau,t) = mean(tau, t-1) + 1/t(tau(t) - mean(tau, t-1))  
      variance(tau, t) = (t-1/t)*variance(tau, t-1) + (1/t)*(tau(t)-mean(tau,t-1))*(tau(t)-mean(tau, t))
      upper_bound = mean(tau, t) + gamma*(sqrt(variance(tau,t)/d)
      lower_bound = mean(tau, t) - gamma*(sqrt(variance(tau,t)/d)
      where d is number of days we looked into the history of data to make the statistics
      gamma is value 1.96
 ```
 4. Use lower_bound and upper_bound CTR/CVR  - bid on all the requests with CTR/CVR above upper_bound threshold and reject all request which are below the threshold. If the predicted value is in between the upper and lower bounds, the ad request will be selected at random with probability equal to pacing rate(t). This scheme, although approximate, ensures that the smooth delivery constraint is met while the opportunity exploration continues on the boundary of high and low quality ad requests.