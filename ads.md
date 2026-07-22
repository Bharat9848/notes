# Ads 

##  Actors
 1. Ad Exchange: Talks to multiple ad networks.
 2. Ad Network
 3. Advertiser: They represent agency, Ad-Network, House Advertiser, House Agentcy, Viewability provider.
 4. Publisher
 5. DSP
 6. SSP
 7. Private Market Place(PMP)
 8. Data Management Platform (DMP): It collects and manages the user historical data for both the SSP and DSP to support a better matching between ads and users.

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
 - It uses the environment data of current callee like webpage keyword user is reading or category pages user is browsing etc. 
### Keywords Targeting
  - Auto Keyword targets: System automatically chooses the keywords for you. System starts with loose or generic target keyword but after few days it learns and tune the keywords. Or if even after tuning advertiser is not able to make sense of auto-keywords he/she choose negative targeting.
  - Manual Keyword Targets: 
  - Keywords bid can be further categorised into close, loose. substitute and complement matches. Bids can differ based on the sematically closeness to the targetted keywords.
  - **Negative Keyword**: Not to show ads for specified keywords.
### Behaviour: 
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
3. Generalized Second Price auction: Most common in ad domain and simple to understand. Highest bid wins but charged price would be second higest bid. `pay(i) = (bid(i+1)*ctr(i+1))/ctr(i)` where i+1 is chosen bid and i is second bid for i+1th slot. ctr represent the quality score. bid represent the calculated bid. In order to take the measurement of performance into account, ad networks usually employ the generalised second price auction (GSP) which allow them to apply bid biases (e.g the quality score) that usually weight the historical clickthrough rate (CTR) or conversion rate (CVR) heavily.

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
## Problems
- Impression value
 1. Relevancy Score: How shortlisted SKUs are relevant to seached keyword, category being browsed, product similar or product complementary category.
 2. Quality score: it is a confidence interval threshold of CTR/CVR. If CTR/CVR is above the range then bid should be done and below request should be rejected and within confidence interval should be randomly bid based on some probability like pacing_rate.
- Cost Esimation: 
 how competetive bid is.

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
- User behavior modeling is necessary 

## CVR Model/Action Rate Model(CPA CPI etc)
- Challenges of CVR model are data sparsity, delayed feedback and sample selection bias.
- for tackling data sparsity auxillary conversion related events are introduced. 
  - cluster user model 
  - hierarchial model with triplet(user, publisher, advertiser)
  - logistic regression
  - collaborative Filtering

## Bid Landscape Forecasting

## Surplus Model

# Pricing Model
- Problem: select high quality impression and bid
## Dynamic Pricing
- dynamic eCPM model are free to change the bid price to win high quality impressions. 
- want optimization on eCPC and eCPA
## Fixed Pricing
- want optimization on CTR and Action-Rate (AR) 
## Bidding Optimizations
 - Cost Per Install(CPI)
 - Cost Per Click (CPC) It is calculated by `total-ad-spend/ total-clicks`. Low-CPC is good for generic audiance target while high-CPC is also good for narrowed target(high spend users).
 - Cost Per Acquisition (CPA)
 - Click Through Rate
 - Conversion Rate

## Problems
1. Cold start Problem
----

# Performance Measurement
- click and conversion events are usually very rare for non-search advertisement and therefore the variance will be large while estimating the past performance metrics.
- Total Cost
- No of purchase/sales
- Branded searches
- Cost per click
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

## Multi-Arm bandit
"The standard multi–armed bandit (MAB) problem was originally proposed by Robbins (1952), and presents one of the clearest examples of the trade–off be-tween exploration and exploitation in reinforcement learning. In the standard MAB problem, there are K arms of a single machine, each of which delivers rewards that are independently drawn from an unknown distribution when an arm of the machine is pulled. Given this, an agent must choose which of these arms to pull. At each time step, it pulls one of the machine’s arms and re- ceives a reward or payoff. The agent’s goal is to maximise its return; that is, the expected sum of the rewards its receives over a sequence of pulls. As the reward distributions differ from arm to arm, the goal is to find the arm with the highest expected payoff as early as possible, and then to keep playing using that best arm. However, the agent does not know the rewards for the arms, so it must sample them in order to learn which is the optimal one. In other words, in order to choose the optimal arm (exploitation) the agent first has to estimate the mean rewards of all of the arms (exploration). In the standard MAB, this trade–off has been effectively balanced by decision–making policies such as upper confidence bound (UCB) and ǫn–greedy"

## References
- [papers](https://github.com/wnzhang/rtb-papers)
