# Monitoring system
## Concept
 1. Meterics: it defines what to be measured and in which unit.
   - counter
   - histogram
   - guage
 2. Timeseries db: see timeseries db.  

## Requirement
 - monitor server side errors.
 - System should be able to raise alert in case of any error condition is breached.
 - system should allow alerts to be defined in form of meterics condition or threshholds.

## Non functional requirement
 - Availability
 - consistency
 - latency
 - Fault tolerance

## Estimation
1. Base facts
2. storage requiement
3. upload bandwidth
4. download bandwidth
5. server estimation

## API and schemas

## Flow diagram
### Metrics collection
```mermaid
  A[monitoring pods]  --fetches-> B[server pods]
  B ---> C[(timeseries database)]
  D[Query service] --query--> C
```
### Querying
```mermaid
	A[client/grafana] ---Query--> B[Query Service]
	B ----> C[(timeseries database)]
```
### Alerting
``` mermaid
	A[client] --post-> B[API server]
	B ---> C[Alert database]
	D[AlertWorker] --query-> E[Query service]
	E -query--> F[(timeseries database)]
	D ----> G[Alert notification system]
	F ----> H[user]
```
---
## Component
 - Data collector system: it pulls the data from various services that we want to monitor.
 - Timeseries database: It is the resting place of all the meterics. It is backed up by an blob storage which natively stores the DB data files. Blob storage is very cost effective than a server node with persistent volume. 
 - querying system: It provides an API through which we can query a meterics database.
 - Alert Manager: It repeteadly query the metrics on a set of frequency set on the detail definition using query service.
 - Alert and action db: It stores the alert and action notification details
 - service discoverer: Use third party tools like consul/k8 api server apis to discover new instances of the main service.

---

## Deep dive
1. push vs pull ?
  1. push pros: helps in case of firewall accessing the server hosts. E.g. in case of banking system or service provider we do not want to expose servers to the third party monitoring system.
  2. push cons: 
    - system should be able to scale at which daemons are pushing the data. It might choke the network infrastructure which may indirectly hurt the main application traffic. It might choke the monitoring system and further degrades an overloaded monitoring system. 
    - We need to install daemon services on the server pods. 
  3. pull pros: Monitoring system pods pull data according to its own frequency. Hence it put less load on the server.
  4. pull cons: Monitoring data is stored in the server itself can cause performance issue with main server. But we can use side car pattern.

2. how to isolate meterics from the main server memory system ?  

3. cleaning up old data ?

4. scaling metric collector ?
  - Meteric collector is very data-heavy service. It will take data from application services and send it to timeseries database. It have scaling chanllenges because of high data transmission. We can use horizontal scaling to scale metric collector.

5. scale Local monitoring system to global monitoring system:
  - Use push based approach from local to global. local monitoring system or global monitoring system uses blob store as backup. 

7. how to handle timeseries db failure ?
  - if timeseries db is not reachable then it will cause pressure on metric collectors. Since meteric collector is a high data activity service, it will cause it is failure. We can introduce Apache Kafka in-between metric collector and timeseries db to decouple it.
  - timeseries db is vertically scaled db.Either we can have hot db on standby or We can have its databackup in blob storage it will allow new instance to quickly comeup.
  - Other standard Database disaster recovery mechanism like WAL logs, etc should be built in the database.

8. How to handle metric collector pod failure.  
   - We can put them behind Loadbalancer which have health check mechnism in place. In case of any pod failure no new request will come to it and load balancer will send the new request to other pods.
   - In case if we use consistent-hashing solution to tie application server and metric collector pods, in that case application pods will automatically send to next metric collector pod in clockwise direction. 

9. In case of multiple metric collector pods how they manage the host distribution among them.
   - Through consistent hashing in which case the application pods and metric collector pods will fall on the same hash ring. And all the pods will get binded to metric collector pods which is next nearest location in the hash ring.

## Rough
- zipkin tracing

## resources
 - [InfluxDb](https://www.influxdata.com)
 - [OpenTSDB](https://www.opentsdb.net)
 - 
