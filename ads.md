# Ads 
##  Actors
 1. Ad Exchange: Talks to multiple ad networks.
 2. Ad Network
 3. Advertiser
 4. Publisher
 5. DSP
 6. SSP
 7. Private Market Place(PMP)

----
# Data model
 1. Campaign
   - Flight dates: Campaign start and end dates.
----
# Guarnteed Ads/Premium Contracts
 - CPM Bids
----
# Ad Network Ads
## Display Ads

## Sponsored Ads
- Keyword Targeting: Use contextual keywords to calculate relevancy score of advertiser campaign.  

# Frequency Capping
 - Optimal frequency capping differ campaign to campaign, some campaign have high CVR when frequency is set to low number(2-5 per day) and for some campaign high CVR is achieved with (6-10 per day).

----

# Targeting
 - Pre-defined Targeting Rules
 - Contextual: It uses the environment data of current callee like webpage keyword user is reading or category pages user is browsing etc. 
 - Behaviour: User browser history, city, state, location etc.
----
# Pricing Model
 - Cost Per Install(CPI)
 - Cost Per Click (CPC) It is calculated by `total-ad-spend/ total-clicks`. Low-CPC is good for generic audiance target while high-CPC is also good for narrowed target(high spend users).
 - Cost Per Acquisition (CPA)
 - Click Through Rate
 - Conversion Rate
----
# Pacing
 - plot traffic pattern of impression vs number of bidders. Ideally with impression peaking number of bidder should also peak otherwise advertiser have to pay higher bids to win auction at the time of less traffic and more competition.
 - Pacing is effected by campaign daily spending limit, dayparting, frequency capping, targeted audiance and pacing type.
 - Pacing Types
  1. No-Pacing/Pacing-ASAP
  2. Uniform Pacing
  3. Dynamic Pacing
  4. Pacing Ahead: Allocate more daily budget in initial days of the campaign and then constraining budget teir wise as days passes by.
 - Solutions
  - Probablistic Filtering: Pacing is assigned a probability between 0 and 1 to participate in auction.
  - Reinforcement Learning.    
---- 

# Events
 - Impression Event
 - Post-Click Conversion: User saw the Ad then click the Ad then register.
 - Post-View Conversion: User saw the Ad but do not click, but still goes to the adv website and register

----
# Auction
 - Generalised Second Price Auction (GSP): In order to take the measurement of performance into account, ad networks usually employ the generalised second price auction (GSP)  which allow them to apply bid biases (e.g the quality score) that usually weight the historical clickthrough rate (CTR) or conversion rate (CVR) heavily.(???)

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

## important features
### User features
### supply features
### Contextual feature

## Measurement
- Attribution
- click/Impression url.


## Budget constraint bidder
  - Knapsack algorithm with clearing price is the win for the user, total budget is the capacity and lookalike score is the quality of user

## Inmobi dsp scale
 - 3 million raw ad request 
 - 300K unfiltered adrequest
 - 60K fills
 - 15K wins

## Rough
 1. Soft floor price

## Multi-Arm bandit
"The standard multi–armed bandit (MAB) problem was originally proposed by Robbins (1952), and presents one of the clearest examples of the trade–off be-tween exploration and exploitation in reinforcement learning. In the standard MAB problem, there are K arms of a single machine, each of which delivers rewards that are independently drawn from an unknown distribution when an arm of the machine is pulled. Given this, an agent must choose which of these arms to pull. At each time step, it pulls one of the machine’s arms and re- ceives a reward or payoff. The agent’s goal is to maximise its return; that is, the expected sum of the rewards its receives over a sequence of pulls. As the reward distributions differ from arm to arm, the goal is to find the arm with the highest expected payoff as early as possible, and then to keep playing using that best arm. However, the agent does not know the rewards for the arms, so it must sample them in order to learn which is the optimal one. In other words, in order to choose the optimal arm (exploitation) the agent first has to estimate the mean rewards of all of the arms (exploration). In the standard MAB, this trade–off has been effectively balanced by decision–making policies such as upper confidence bound (UCB) and ǫn–greedy"