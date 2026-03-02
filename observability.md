
---
# SRE
## Glossary
- **Service Level Indictor**
- **Service Level Objective**: objective of a service from a user centric manner. 
- **Error Budgets**
- Error budget policy
- Error budget decision making
- SRE concept pyramid
- **Platform reliability**
- **Alerts**
- **On-call rotation**
- **Mean time to repair**
- **SRE infrastructure**
## Production deployment
 - communication to stakeholders

## Incident
 - detect the incident
 - notify the stakeholders
 - fix the incident before it lead to custom escalation.

## Post Mortem
- blameless
- from user prespective

## SLO breaches
- Team based - bug in own team service, unplanned downtime, planned downtime
- Dependent team based - bugs in dependent services/infrastructure.


### SLI
- SLI typically includes throughput, latency and availability for a service and finding them is an empirical process. 
- SLI can include freshness, durability, throughput, availability, latency, fidelity, coverage and correctness. Any of these quality can be chosen as a reliability measure.
- SLI should be chosen from the customer point of view rather than technical standpoints. Since business analyst and product owner are more closer to the product user they should approve of current set of SLOs.
- **Availiablity SLI**: It is measured using HTTP error codes - It is paramount for a team to follow http error code correctly.
- **Latency SLI**: it should be based on user story. Each coarse grained latency SLO should be further break into individual call chain latency's SLO.

### Service Level Objective
**Service Level Objective** are the thresholds or range of values to meet SLI for a service. SLO have to setup according to customer perspective. SLO should be tuned as per the customer happiness.

- If some stakeholder or anyone else outside the group detect issues, then SLO revision should happen. It may require to have additional SLOs besides current one.
- New feature's SLO impact should be measured before hand before it is released in production.
- SLO checking schedule should be set by team - quaterly, biweekly or semi-anually etc.

- SLO Process
  - SRE implements DevOps in a prescriptive way, and it requires operations engineers, software developers, and product owners to align on:
    1. what service objectives are
    2. consequences to the objectives if SLO are not met.
    3. Operations, software and product stakholders are agreed on the task upfront if SLO does not meet.
  
- Setting SLO:
  1. Defining if in user centric manner.
     -  SLO of user facing service should have availability SLO of "99.99% over X year/month" or Latency SLO "p95 under X millisec"
  2. measuring it in production
     - SLO breach should be measured and raise an alert.
  3. what to do to bring it back to normal when it is broken. 
     1. If SLO breach have a real user negative impact then impacted service need to be improved upon so that it can meet the SLO. 
     2. If SLO breach does not have negative user impact then it needs to get relax and it is merely technical glitch.

 
### Error budget
Error budget is difference between maximum service level and SLO. Error budgets are allocted per unit time and it get reset to the maximum error budget after time unit expires. So onus is on the team to remain within error budget during a time unit. Error budgets are important for consumers in two folds. First they have come up with strategies to cope up with permissible SLI breaches. Second they have to take the downstream budget into consideration before setting their own SLOs.
- 100% SLI can take significant amount of engineering and operational effort/time to justify the marginal gain it would provide. More on-call rota, no deployment and work towards the operational/engineering issue will cause lot of efforts that will make 100% SLI not feasible.
- **Error Budget policy** defines the strategies to improve service reliability after full depletion of error budget within allocated time unit. It includes blameless postmortem, no production deployment till SLI comes within the acceptable range, review of architecture design and deployment etc. Policy is applied to all the services owned by the team.
- **Error Budget debt** does not accumulate and see it that its paid by the customer. 

### SRE infrastucture
- Bare minimum requirement
  1. set SLO for availability and latency
  2. ability to send alerts on SLO breaches
  3. retune SLO through selfservice
- Dashboard 
  1. plot each SLI error budget depletion on y-axis with 100% to -100% and allocated time unit on x-axis.
  2. Alerts originated from SRE infrastructure should also mention remaining error budget. 
  3. It should track total error budget, depletion speed, error budget remaining for each SLO.
  
- **Error budget based decision making**: All internal and external team desision making or contracts are done while looking at internal and external teams SLO. It may further lead to discussion for tightening of SLO of downstream dependencies based on current service SLO requirements. Also implementation/review of new/old technical design to meet SLO. Error budget depletion calculation while chaos testing. Error budget depletion calculation while deploying some features that require downtime.
- A professional status page such as the one for Microsoft [Azure](https://azure.status.microsoft/en-us/status) or Amazon [AWS](https://status.aws.amazon.com.) is the goal with SRE.

## Excercises
 - SRE introduction to the team.
 - Setup logging infrastructure
 - Setup SRE infrastructure to setup SLO for availability and latency SLI
 - Alerting infrastructure to tune to not few and not many alerts
 - Dashboards for plotting SLI
 - Error budget calculation infrastructure
 - Error budget dashboard graph
 - Infrastructure for error budget decision making.
 - Infra for custom SLI definition
 - Self service SLO adaptation tool
 - self service configuration of SRE. 
 - setup process to react to SLO breaches
 - Tuning of SLOs : Repeated check on SLO will they lead to broken customer experience.

---
# Monitoring
---
# Logging
- service logging in a uniform manner ?
- logging infrastructure
- Out of box features of logging infrastructure
  1. call duration
  2. runtime dependency graph
  3. query language support
  4. programmatically querying the logs.
  5. metrics over logs
- asynchronous logging ?
---
# distributed Tracing   

---
# Observability
## Vs Monitoring
- With distributed system issues are random and always something new. Staging environment testing is obsolete as it is very hard to do production testing, observability let you do testing in production.
- Monitoring is best suited for finding system level issue while observability is suited for application level issues.

## General
- observability is more granular than monitoring as it try to comprehend system from unpredictable, long-tail or multimodal distributions.
- Using observability approaches you will be able to map system internal state giving some external input. It helps you understand working of your system by checking its internal states.
- Observability allows you to understand and explain any state of your system can get into no matter how novel or bizarre. You must be able to comparatively debug the bizzare or novel state across all dimensions of data or combination of dimension in an ad-hoc manner without being required to defing or predicts those debugging needs in advance.
- Observability is not a  debugging your code logic. Observability is for figuring out where in your systems to find the code you need to debug.
- Observability also put architectural/infrastructural context like build id, set of hosts, instance types, container version, kernel patch etc.
- To debug unknown-unknown we can dice the arbitrarily wide structured events across any dimensions and group them.

## How-to
- Data type: arbitrarily wide capture structural wide event which can be at request level. Structured means there is a key assigned to a value to assign the meaning. Arbitrarily wide means the map of key-value pair length is not predefined

## Alerts
- When most alerts are not actionable that quickly lead to alert fatigue. So alert should be actionable. Alert should be reliable indicator that user experience is downgraded. SLO based alert should be event based as they have a few lesser degree of false positives and false negatives. SLO based alert decouple what and why behind incident alerting.

## Tracing
- **Span**: is a discrete unit of subtask that user wants to measure. It also include any interesting events that happen in span execution period.
- Trace: is a set of spans
- Tail sampling
- Head sampling

## openTelemetry
 -- see opentelemetry.md

## Qustions
- how does one aggregate all the data and make it available for inspection.
- what are the technical requirement for processing that data
- what team capabilities are necessary to benefit from  that data ?
- How to plot data sets with high cardinality

## Resources
  - Beyer, Betsy, Niall Richard Murphy, David K. Rensin, Stephen Thorne, and Kent Kawahara. 2018. The Site Reliability Workbook: Practical Ways to Implement SRE. Sebastopol, CA: O’Reilly Media.
  - DORA. n.d. “DORA Research Program.” Accessed January 18, 2022. https://www.devops-research.com/research.html.
  - Davis, Jennifer, and Ryn Daniels. 2016. “Foundational Terminology and Concepts.” In EffectiveDevOps. O’Reilly Online Learning. https://www.oreilly.com/library/view/effective-devops/9781491926291/ch04.html.
  - DORA. 2021. “State of DevOps 2021.” . https://services.google.com/fh/files/misc/state-of-devops-2021.pdf.
  - Google. 2022. “Google SRE Books.” https://sre.google/books.
  - https://www.infoq.com/minibooks/data-driven-decision-making
  - https://www.infoq.com/articles/data-driven-decision-product-operations
  - Simple network management protocol RFC-1157
  - [why intuitive troubleshooting...](https://www.honeycomb.io/blog/why-intuitive-troubleshooting-stopped-working)
  - paper from larry tesler
  - accelerate state of devops report.
  - Site reliability engineering by Betsy Beyer 
  - Uber jaegar: open source distributed tracing tool
  - Waterfall visualisation diagram for distributed tracing
- https://www.w3.org/TR/trace-context/
- Openzipkin b3-propagation
- Https://o11y.news
- Https://GitHub.com/cncf/tag-observability
- Https://opentelemetry.io/community
- https://hny.co/blog/what-is-auto-instrumation
- the psychology of sunk costs Arkes and Catherine Blumer
- accelerate: building and scaling high performing technology organization by Nicole Forsgren
- continuous architecture and continuous delivery Murat Erfer and Pierre Pureur
- how to get Started with continuous integration by sten pittet
- flannel-an-application-level-cache-to-make-slack -scale
- infrastructure observability for changing spend curve by slack engineering 
- circleCI the unreasonable effectiveness of single wide event.
- balancing safety and velocity in cl/cd at slavk
- accelerate state of devops by Nicole Forsgren 
- scuba: diving into data at Facebook 
- signoz architecture
- arcticDB architecture 
- a technique for high performance data compression by Terry Welch
- oreil.ly/ivNPL
- chord pattern doi.org/10.1145/964723.383071
- sandimetz.com/blog/2016/1/20/the-wrong-abstraction
- scribe 
- logging tools- logstash, fluentd, rsyslog
- Prometheus push gateway
- honeycomb refinery 
- vector.dev
- oriel.ly/pZd4m
- mobile load time and user abandonment
- oriel.ly/2Gqjz
- Pageduty blameless postmortem documentation 
- Google Cloud Tech. 2020. “The History of SRE.” YouTube, July 15, 2020. https://www.youtube.com/watch?v=1NF6N2RwVoc.
- Beyer, Betsy, Niall Richard Murphy, David K. Rensin, Stephen Thorne, and Kent Kawahara. 2018. The Site Reliability Workbook: Practical Ways to Implement SRE. Sebastopol, CA: O’Reilly Media.
- Implementing Service Level Objectives: A Practical Guide to SLIs, SLOs, and Error Budgets by Alex Hidalgo 
- Real-World SRE: The Survival Guide for Responding to a System Outage and Maximizing Uptime9
- SRECon.” 2017. USENIX. August 25, 2017. https://www.usenix.org/srecon.
-  IT Revolution Events. n.d. “DevOps Enterprise Summit 2022.” Accessed January 12, 2022. https://events.itrevolution.com.
- Microsoft Tech Community. 2019. “Monitoring Your Infrastructure and Applications in Production.” YouTube,April 2, 2019. https://www.youtube.com/watch?v=Si6ehIr6kjw.
- McGhee, Steve. 2021. “SLO Math.” YouTube, May 16, 2021. https://www.youtube.com/watch?v=-lHPDx90Ppg.
- Blank-Edelman, David N. 2018. Seeking SRE: Conversations about Running Production Systems at Scale. Sebastopol, CA: O’Reilly Media.
- CernerEng. 2018. “Less Risk Through Greater Humanity, Dave Rensin.” Video. YouTube. https://youtu.be/0zqBlRW_6jA?t=1234.
- Westrum, R. 2004. “A Typology of Organisational Cultures.” Quality and Safety in Health Care 13 (suppl_2):ii22–27. https://doi.org/10.1136/qshc.2003.009522.
- Thorne, Stephen. 2018. “Getting Started with Site Reliability Engineering.” YouTube, July 11, 2018. https://www.youtube.com/watch?v=c-w_GYvi0eA.
- “SRE for Everyone: Making Tomorrow Better Than Today.” SlideShare IOS, May 2, 2019. AccessedJanuary 19, 2022. https://www.slideshare.net/Rundeck/sre-for-everyone-making-tomorrow-better-than-today-devops-days-austin-2019.
- Microsoft. 2019. “Monitoring Your Infrastructure and Applications in Production.” YouTube, April 2,2019. https://www.youtube.com/watch?v=Si6ehIr6kjw.
- SRE Weekly. Weekly online newsletter published by Lex Neva. Available at https://sreweekly.com.
- Rensin, Dave. 2016. “Introducing Google Customer Reliability Engineering.” Google Cloud, October 10, 2016. https://cloud.google.com/blog/products/gcp/introducing-a-new-era-of-customer-support-google-customer-reliability-engineering.
- Book - Forsgren, Nicole, Jez Humble, and Gene Kim. 2018. Accelerate: The Science of Lean Software and DevOps:Building and Scaling High Performing Technology Organizations. Portland, OR: IT Revolution Press.
 - “Use Four Keys Metrics Like Change Failure Rate to Measure Your DevOps Performance.” n.d.Google Cloud Blog. Accessed January 20, 2022. https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance.
- “DORA Research Program.” n.d. Accessed January 18, 2022. https://www.devops-research.com/
research.html.
- DORA. 2021. “State of DevOps 2021.” Google Cloud. https://services.google.com/fh/files/misc/state-of-devops-2021.pdf.
- Harley, Nick. 2017. “Software Intelligence: Why Slow Is the New Down.” VentureBeat, April 27, 2017. (link)[https://venturebeat.com/2017/04/27/software-intelligence-why-slow-is-the-new-down]



## Rough 

- top level aggregate view.
- How to control the amount of logging in case of log storm
- Filter pii data from the logs
- Ingest synthetic logs to measure the performance of the telemetry pipeline 
- "Sociologist
Ron Westrum defined a popular topology of organizational cultures, often referred to as the
Westrum model,5 which classifies cultures as pathological, bureaucratic, or generative according
to how organizations process information: Pathological cultures are power oriented, bureau-
cratic cultures are rule oriented, and generative cultures are performance oriented. According to
DevOps Research and Assessment (DORA6), performance-oriented generative cultures also lead
to high performance in software delivery."
- "In marketing, there is a popular model called AIDA3 for moving consumers through a funnel of
cognitive and emotional steps to affect buying behavior. AIDA stands for Awareness → Interest
→ Desire → Action. First, the consumer’s Awareness of a product needs to be captured. One
way this can be done is through advertising. Next, the consumer needs to show Interest in learn-
ing more about the product. This can be done through, for example, the product website. In the
Desire step, the consumer develops a positive attitude toward the product. Finally, the Action
step leads to a product purchase."
