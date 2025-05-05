# Spark
## Spark streaming
- uses microbatch architecture underneath with continous stream of RDDs

## Fault tolerance
- Resilient distributed dataset
- provide exactly-once guarntee

## Flow model
- It is difficult to achieve unless reconfiguration is done end to end,

## Programming model
- windowing cannot be done for intervals which are not multiple of checkpointing interval. No session window or complex windowing

## Latency
- Application with many suffles suffers latency upto many seconds.
