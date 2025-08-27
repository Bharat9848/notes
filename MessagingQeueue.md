# Requirements
- Data production is very spiky or uncontrolled. We can handle the usecase with consumer and producer decoupling.
- producer and consumer have independent usecases which might be fatal for business decoupling producer and consumer helps in this case. 
- online consumption only: No retention of message for longer periods.
- offline and online consumption
- Transaction across multiple queues.
- Ordering guarntee.

# tech
- see kafka.md
- see rabbitMq.md
- JMS : Apache activeMQ is implementation of JMS 
- IBM websphereMQ