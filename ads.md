# Ads 

##  Actors
 1. Ad Exchange: Talks to multiple ad networks.
 2. Ad Network: Traditional central entity where publisher and advertiser come together to exchange.
 3. Advertiser: They represent agency, Ad-Network, House Advertiser, House Agentcy, Viewability provider.
 4. Publisher
 5. DSP
 6. SSP
 7. Private Market Place(PMP)
 8. Data Management Platform (DMP): It collects and manages the user historical data for both the SSP and DSP to support a better matching between ads and users.
 9. Relevance problem is to match user with given context with suitable Ad.
 10. Revenue problem: Only relevance is not enough bidder wants to show Ad which generates more revenue for the advertiser(CTR).
 11. Bidding: Advertiser selected bid range(constraint).
 12. Relevance, revenue and bids decides the Ad for the top slots. 
----
# Data model
 1. **Campaign**
  a. Metadata
  - Flight dates: Campaign start and end dates.
  b. Objective: 
  - Awareness branding, Niche B2B, Hot retargeting(Sale), Warm retargeting, Cold Prespecting(?), Consideration(?), Increase Userbase/Install/Purchase.
  - Targeting Parameters.
  - Creatives in case of display/videos etc. Or product SKUs in case of sponsored product ads.
  c. bid-model
  - min-bid
  - max-bid
  - max-CPM
  - fixed-bid
  - bid-multiplier
  d. Frequency capping
  e. Pacing
  f. Audiance 
 2. **Inventory**
  - Location
    1. position on page e.g. block1, block2 etc
    2. Page type: Homepage, Search, Product-Detail, category, Product-listing, Registry, Drive-Up/Order-Pickup, Store-Mode
  - Size of the slot      
----

# Guarnteed Ads/Premium Contracts
 - CPM Bids
----


# Ad Network Ads
-----


# Types
----
## Search Ad
 - Search Ad words against the current searched keyword, user past data and contextual data.
## Display Ads
 - CPM or vCPM considered for the bidding model
 - first price auction is default.
----
## Sponsored Product Ads
 - Manual Keyword Targeting: Use contextual keywords to calculate relevancy score of advertiser campaign.  
 - Auto Targeting 
----
## Sponsored Brand Ad
 - encompasses multi-skus from same brand/seller.
## Video Ad
## Intersitial Ad
## Audio Ad
## Native Ad
## Reserved Ad / Over-the-counter Ads:
- Advertiser directly buy them from the publisher and ignore the context.  
----


# Frequency Capping
 - Requriement is to constriant user ad exposure to daily/weekly/lifetime frequency with optional duration gap between two subsequent ad exposure. 
 - Object of FC can be creative, campaign or adgroup. 
 - Optimal frequency capping differ campaign to campaign, some campaign have high CVR when frequency is set to low number(2-5 per day) and for some campaign high CVR is achieved with (6-10 per day).
 - Signs that require FC to be tuned
   1. CTR is falling down while impressions hold steady.
----

# Brand Conquesting
 - Show competitors brands using positive keyword targeting to help steal customers.
----


# Targeting
 - Pre-defined Targeting Rules
## Contextual: 
 - User Relevance and Content relevance
 - It uses the environment data of current callee like webpage keyword user is reading or category pages user is browsing etc. 
### Keywords Targeting
  - It is a form of contextual targeting.
  - Auto Keyword targets: System automatically chooses the keywords for you. System starts with loose or generic target keyword but after few days it learns and tune the keywords. Or if even after tuning advertiser is not able to make sense of auto-keywords he/she choose negative targeting.
  - Manual Keyword Targets: 
  - Keywords bid can be further categorised into close, loose. substitute and complement matches. Bids can differ based on the sematically closeness to the targetted keywords.
  - **Negative Keyword**: Not to show ads for specified keywords.
### Behavioural Targeting: 
  - User Tracker Cookie tied to a domain and domain set information about user's shopping cart or any other previous browsing activiities along with user identifying information typically ID of the user on that domain. User cookie is stored on web browser under domain name. Managed web page have htmlcode which stores cookie from different service provider like ad exchange, SSP, DSP etc 's domain. When Ad request comes page sends ad-exchange cookie alongwith it. To further send user data to DSP **cookie syncing** is needed. Cookie syncing is achieved via HTTP 302 page redirect functionality.  Process of cookie syncing??
  - Device or Browser Fingerprinting
 - User browser history, city, state, location etc.
 - Device type, Platform like mweb, app web etc.
### Audiance Targeting 


----


# Pacing
 - Require **spending smoothness** to prevent premature stop.
 - Should follow traffic and performance trend.
 - plot traffic pattern of impression vs number of bidders. Ideally with impression peaking number of bidder should also peak otherwise advertiser have to pay higher bids to win auction at the time of less traffic and more competition.
 - Pacing is effected by campaign daily spending limit, dayparting, frequency capping, targeted audiance and pacing type.
 - Pacing Types
  1. No-Pacing/Pacing-ASAP
  2. Uniform Pacing
  3. Dynamic Pacing
  4. Pacing Ahead: Allocate more daily budget in initial days of the campaign and then constraining budget tier wise as days passes by.
 - Solutions
  - Probablistic Filtering: Pacing is assigned a probability between 0 and 1 to participate in auction.
  - Reinforcement Learning: cost function is of smoothness and budget fluctuation
 - Day Parting
 - Problems
   - Budget exhaustion from surge in traffic  
 - See RealTimeBiddingwithSmoothBudgetDelivery notes for fixed and dynamic CPM campaigns.

---- 

# Events
 - Impression Event
 - Click event: Deduplication latency
 - Post-Click Conversion: User saw the Ad then click the Ad then register/buy.
 - Post-View Conversion: User saw the Ad but do not click, but still goes to the adv website and register. 7 days to get a attribution

----

# Auction
1. Mayerson auction: Maximize revenue for seller
2. Vickrey-Clarke-Groves auction: 
3. Generalized Second Price auction: 
- Incentivize the bidder to reveal the private value, thus second price auction is better suited to bring truthness in the compeition.
- Most common in ad domain and simple to understand. Highest bid wins but charged price would be second higest bid. `pay(i) = (second-bidder-bid * second-bidder-quality-score)/first-bidder-quality-score` ctr represent quality score.  In order to take the measurement of performance into account, ad networks usually employ the generalised second price auction (GSP) which allow them to apply bid biases (e.g the quality score) that usually weight the historical clickthrough rate (CTR) or conversion rate (CVR) heavily. Second Price Auction is sealed bid auction only winner advertiser is notified of the winning price. Thus each advertiser only presents local view of the market data(?).
 - Disadvantage of first price auction: "The reason behind paying the second highest bid is that impressions with same or similar user profiles will continuously appear in ad exchanges. If advertisers pay what they bid (i.e., the first price auction), they would not state their true valuations, but rather keep adjusting their bids in re- sponse to other bidders’ behaviours. Unstable bidding behaviours have been well observed in continuously repeated first price auctions, such as in the search markets [Edelman and Ostrovsky, 2007]. To understand this in RTB, suppose there are two advertisers and the impressions associated with the same targeted user group are worth $6 CPMs (cost per mille impressions, with mille being Latin for thousand) to the first advertiser and $8 CPMs to the second. The floor price (the lowest acceptable bid) is assumed to be $2 CPMs. Thus, when they bid between $2 CPMs and $6 CPMs, each of them tries to outbid each other with a small amount. As a result, the winning price increases continuously until reach $6 CPMs where the second advertiser stops the bidding. Then, without the competition from the second advertiser, the first advertiser would drop back to the minimum bid $2 CPMs. At that point, the second advertiser comes back and the competition restarts again and the cycling behaviour will continue indefinitely".???


----

## Gloassary
- Return On AS (ROAS): 
- SKAdNetwork: SKAN needs slots??

- Remarketing/ Event optimization
- target cost per event(tCPE)
- Attribution loss: When we win the impression how much of it are attributed to us. 
- organic data: Advertiser share the user id. For any new user, we try to map user to existing organic user's look alike and generate user lookalike score.
- Fraud check by 3rd party double verify
- Supply-path optimization: exploration and exploit model is revenue per request optimized model.

-----
# Bidding strategy design

- In this view, the bidding strategy design becomes a constrained optimization problem in an interactive and stochastic environment with big data as support, which has attracted great research interest for data scientists.
- Bids are in CPM unit
## Bidding
# Pricing Model
- Problem: select high quality impression and bid
## Dynamic Pricing
- dynamic eCPM model are free to change the bid price to win high quality impressions. 
- want optimization on eCPC and eCPA
## Fixed Pricing
- want optimization on CTR and Action-Rate (AR) 

## Problems
1. Cold start Problem

### Bidding objectives - Value estimation
- Performance advertising
 1. Increase the utility of winning impression. Utility is measured as Value generated by the impression which can be sales etc minus the cost(auction landscape and advertiser own bid).
 2. increase the value of winning impression. It just calculate the value of the impression without checking cost while cost(auction landscape and advertiser own bid) is used as budget constraint or return-on-investment constraint. 
- Brand advertising: objective wise, there are no direct measurements of performance of brand campaign but measurement like user reach, amount of time video watched etc.
### Bidding Constraint
- Budget constraint
- KPI constraint like Cost-Per constraint e.g. CPC, CPA, ROI
- Non-cost-related (NCR) constraints define the lower bound of some certain advertising effects, such as the click-through rate and conversion rate.
### Bidding Function
- It maps the bidding request to bid where the objective and constraint affects the bidding function.
- It is function of quality score and value that impression will generate along with budget constraint.
- Impression value
 1. Relevancy Score: How shortlisted SKUs are relevant to seached keyword, category being browsed, product similar or product complementary category.
 2. Quality score: it is a confidence interval threshold of CTR/CVR. If CTR/CVR is above the range then bid should be done and below request should be rejected and within confidence interval should be randomly bid based on some probability like pacing_rate.
#### Risk
- Due to stocastic nature of the market there is risk of negative value generation - predicted value will vary from real value. Sometime additional risk calculation is needed.
- Other risk is spend beyond the budget constraint.
## Features
### User features
 - Contextual feature
 - behavioral features
### supply features
### Campaign features

## CTR Model 
- Predicts user click on the Ad. It depends upon
 - user profile
 - historical behavior
 - Item attributes
 - contextual information
 - total number of ads on the page
 - position
- User behavior modeling is necessary 

## CVR Model/Action Rate Model(CPA CPI etc)
- Challenges of CVR model are data sparsity, delayed feedback and sample selection bias.
- for tackling data sparsity auxillary conversion related events are introduced. 
  - cluster user model 
  - hierarchial model with triplet(user, publisher, advertiser)
  - logistic regression
  - collaborative Filtering


-----


# Bid Optimization
- applied over generated bid.
- Rule based method
  1. Online stochastic knapsack
  2. PID controller: takes proportional, integral and differential error part which are specific to current, past and future trend into account respectively.
- Reinforcement learning: Meant for more dynamic enviroment and complex objectives
- predictive models
- win probability 

## Bidding Optimizations
 - Cost Per Install(CPI)
 - Cost Per Click (CPC) It is calculated by `total-ad-spend/ total-clicks`. Low-CPC is good for generic audiance target while high-CPC is also good for narrowed target(high spend users).
 - Cost Per Acquisition (CPA)
 - Click Through Rate
 - Conversion Rate

## Surplus Model
------

# Bid Landscape Forecasting
-  how competetive bid is by checking the winning probability by looking at bidding landscape.
- Winning price distribution is a histogram of winning frequency vs bid value bins. Expected wins for a bid b is `w(b) = integration from 0 to b p(z)dz`
- Cost in case of second price auction : `c(b) = integration from 0 to b(z*p(z)dz)/ integration from 0 to b(p(z)dz)` ??

----

# Performance Measurement
- click and conversion events are usually very rare for non-search advertisement and therefore the variance will be large while estimating the past performance metrics.
- Total Cost
- No of purchase/sales
- Branded searches
- Cost per click: Advertiser is charged per click.
- Cost per Milli: Advertiser is charged per 1000 impressions
- Page views
- Purchases new to brand,
- Ad-fatigue metrics like hides, skips and block etc
- Reach metrics: No of unique user, impressions per unique users.
- Attribution
- click/Impression url.
- Competitive CPC
----

# Campaign
## Campaign types
1. Performance 
 - Click Campaign
 - Conversion Campaign
 - Awareness  
## tuning
- Set the bids as per suggested bids(by the platform itself) on the lower range. If impressions are not picking up then increase the bids by 1-2 cents.
----


## Budget constraint bidder
  - Knapsack algorithm with clearing price is the win for the user, total budget is the capacity and lookalike score is the quality of user ?
----


# Company specifics
## Target
 - Competitiors- Amazon Ads, Walmart connect, Instacart Ads, Kroger, Best buy
 - 5000 advertiser accounts
 - 60k per minute ad request
## Inmobi dsp scale
 - 3 million raw ad request 
 - 300K unfiltered adrequest
 - 60K fills
 - 15K wins
-----

## Rough
 1. Soft floor price
 2. When discussing the bidding strategy in second-price auctions in previous sections, we first demonstrate that truth-telling is the dominant strategy for utility maximizers, and for value maximizers with constraints, the optimal bidding function is derived as a linear form that does not require the knowledge of auction landscape explicitly. However, for first-price auctions, there is no trivial optimal bidding formula for both utility maximizers and value maximizers. The analytic form can only be derived with the landscape assumed explicitly, resulting in a seemingly more complex problem.

## Multi-Arm bandit
"The standard multi–armed bandit (MAB) problem was originally proposed by Robbins (1952), and presents one of the clearest examples of the trade–off be-tween exploration and exploitation in reinforcement learning. In the standard MAB problem, there are K arms of a single machine, each of which delivers rewards that are independently drawn from an unknown distribution when an arm of the machine is pulled. Given this, an agent must choose which of these arms to pull. At each time step, it pulls one of the machine’s arms and re- ceives a reward or payoff. The agent’s goal is to maximise its return; that is, the expected sum of the rewards its receives over a sequence of pulls. As the reward distributions differ from arm to arm, the goal is to find the arm with the highest expected payoff as early as possible, and then to keep playing using that best arm. However, the agent does not know the rewards for the arms, so it must sample them in order to learn which is the optimal one. In other words, in order to choose the optimal arm (exploitation) the agent first has to estimate the mean rewards of all of the arms (exploration). In the standard MAB, this trade–off has been effectively balanced by decision–making policies such as upper confidence bound (UCB) and ǫn–greedy"

## References
- [papers](https://github.com/wnzhang/rtb-papers)

