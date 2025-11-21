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
- implementing service level objective by Alex Hidalgo 
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

## Rough 

- top level aggregate view.
- How to control the amount of logging in case of log storm
- Filter pii data from the logs
- Ingest synthetic logs to measure the performance of the telemetry pipeline 
