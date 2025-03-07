## Overview
 - k8 provides automatic scale up and down, self healing, automated updates, deploy and rollback.
 - can deploy across multiple region ? 
 - Kubernetes architecture have two broad categories of objects - A resource and controller.


## Minikube
 - `minikube start|stop|status`
 - `minikube ssh`
 - `minikube dashboard`
 - `minikube dashboard --url`
## config
 - `.kube/config` contains cluster information, context and user information.

## Control plane
 - Control plane nodes runs - API server, the schedular and controllers.
### API server
 - Doing changes to cluster through API server
  1. describe the changes in yaml file
  2. post the configuration to API server
  3. request will be authenticated/authorized
  4. required state will be stored in clustered store.
  5. the changes will be scheduled to the cluster
 - API server manages the **cluster store**.

### cluster autoscaler
 - tries to scale cluster by adding node in case new pods are not getting nodes.
 - It observes the pending pods state and bring new nodes in case cluster requires.

### Cluster store 
 - cluster store is an etcd distributed store which stores the cluster desired state.
 - etcd uses RAFT for consensus.

### Controllers
#### Types of controller  
 - Deployment controller
 - Statefulset controller
 - Replicaset controller
- Different controllers keeps watch on their domains's desired state and actual state.
- Controllers provide add on services over pod like self healing, scaling, rolling update etc.
- Watches failed node then deletes a pod 

### Contoller Manager  
- spawning and managing of different controllers.

### Schedular
- It looks for API server changes for new tasks and assigns new tasks to nodes matching implicit and explicit filtering criterias.
- It also do autoscaling. It schedules new pods to the node given node selection criteria.
- Internal controller like replicaset requests schedular to scheduler required number of pods.

#### Node selection
 - nodeSelector is simple key=value pairs on pod desc. Schedular simply select the nodes with given key-value pair from the pod.
 - Affinity and anti-affinity rules can be hard and soft rules. 
 - topology based tries to spread pods in different availability zones.
 - request and resource limit specifies 

### cloud contoller manager
- It interacts with cloud and provide cloud host provided components like load-balancer etc. 

## K8 components
### Service
- provide reliable networking for group of pods. K8 gaurantees that the DNS name, Ip address and port never changes.
- Service is a contract to guide the traffic to backend healthy pods. To achieve the same, each service have an `EndpointSlice` controller which tracks all the healthy pods.  
- For services with clusterIP it adds a DNS entry `<service-name>.<namespace>.svc.cluster.local` for assigned clusterIP.

- **Properties**
  - `ExternalTrafficPolicy: local` means traffic from cloud LB directly goes to node which have the destination service's pod running.
  - `ExternalTrafficPolicy: cluster` means traffic from cloud LB can go to node which do not have destination service's pod running. The load balancer uses health checks to determine which nodes have the appropriate Pods. It obscures source IP address.
  - `sessionAffinity:ClientIP`: will make all the call from same client to a particular node.

- `NodePort` service type is also `ClusterIP` service as well. In addition to `ClusterIP` features it additionally opens up a port on cluster node which allows external traffic to passthrough via node's port. It requires external client to be aware of cluster nodes and their health.
- `LoadBalancer` service type configures an cloud provider loadbalancer to sit on the `NodePort` service. Cloud provider loadbalancer take cares of health protocol and guides external traffic via its public Ip to node's port then to Sevice's pods.


## ingress
- Applicable to L7 load balancer as ingress specfies the rules at URI level.
- needs k8 service of type nodeport.
- `ingress` resource defines the rules. User have to install explicit **ingress controller** to handle those rules. 
- `ingress` rule can be based on different domain names or path prefixes.
- Ingress is more flexible in cases of multiple services that needs to be exposed through a single load balancer.
- `ingressClass` binds the ingress with ingress controller. We can have multiple ingress-controller by having multiple ingress.
- ingress default backend defines the behaviour in case none of the rules matches the coming traffic.
- `nginx.ingress.kubernetes.io/rewrite-target: /` ??


### Namespace
- namespace to have soft partition between clusters.
- Each Namespace can have its own users, RBAC rules, and resource quotas.
### Pods
- pods is an abstraction 
 1. resource sharing
 2. advanced scheduling: Pod scheduled based on request/resource limit, nodeSelector, affinity/anti-affinity and toleration and topology related constraint by Schedular.
 3. Application health probes
 4. restart policy
 5. security policy
 6. Termination controls
 7. volume.
- Pod scheduling sequence
 1. new pod spec/scaling up is requested to API server
 2. spec is validated and authenticated/authorized
 3. Schedular does the node selection
 4. pod is assigned to a healthy node
 5. kubelet watches the API server and notice API assignment
 6. kubelet downloads pod spec and instruct container runtime to start the container
 7. kubelet report status back to API server. 
- Deploy pod can be done using directly via standalone pod spec or indirectly via a workload resource and controllers
#### Pod network
 - pods network is created by Container network interface plugin. It spans all pods in the cluster. 
 - Pod and node network is connected through **bridge network interface**
 - Additionally each pod have virtual network interface

### Deployment
- It adds auto-scaling, self-healing, rollout and rollback add-on services to the pods.
- Deployment delegates the pod management - scaling and self healing to another sub-manager called `ReplicaSet`.
- Deployment manages replicaset which in turn manages pods. we shouldn’t directly create or edit ReplicaSets, we should always configure them via a Deployment.
- Main properties- `replicas`, `spec.selector.matchLabels`
- rollout settings - 
  - `spec.strategy.type: RollingUpdate` 
   `spec.strategy.rollingUpdate.maxUnavailable:1`  never go 1 less than desired and `spec.strategy.rollingUpdate.maxSurge:1` never go more than 1 than the desired.
  - `spec.minReadySeconds:10` wait 10 sec between each replica.
  - `spec.progressDeadlineSeconds:300` give each pod 300 sec to start properly before marking failed
  - `spec.revisionHistoryLimit:10` tells k8 to keep 10 last revision which might be required to rollback.
  - `kubectl rollout <status|pause|resume> deploy <name>` returns the overall progress of deployment.
- How to rollout
 1. `kubectl rollout history deploy <name>`
 2. `kubectl rollout undo deployment <name> --to-revision=<from annotation - deployment.kubernetes.io/revision>`    
### Horizontal autoscalar
### Vertical autoscaler

## K8 components - Worker Node internal
- Each node have single pod for kublet and kube-proxy
### Kubelet
- communicate with control plane and API server
- communicate downstream with Container runtime to execute tasks
- report status of task to API server 
- runs on a worker node.
- act on `pod.spec.restartPolicy: Always|Never|Onfailure` and restart or not restart containers accordingly.

### Container runtime
- manages and pull images
### kube-proxy
- handles networking and load balancing tasks to other nodes.
- implements ip-tables and IPVS rules which helps in DNAT to a healthy pods IP when destination is the clusterIP of a pod's service.


### Kubectl
- KUBECONFIG: sets of path that have list of cluster information(API, certificates), user credential, list of contexts like cluster, default namespace and user, current context etc.
- `kubectl config` defines api over kubeconfig information like `use-context`, `current-context`.

### container network plugin
- Decides MTU.
- Calico, kubenet, netd, cilium are some of the famous CNI plugins

## To expose a k8 service to the internet
 - Service type is required to be of `LoadBalancer` type and cloud provider automatically provision a L4 SLB with public IP exposed.
 - Or service type can be of `Ingress` type


## Container
 - Container runtime interface - abstract over containter runtime like docker,containerd etc ???
 - `init-container` : runs only once and should be finished before non-init containers.
 - sidecar: containers that run till entire runtime of main container. They provide supporting services to the main container.

## practice
 - run 3/5 separate control plane nodes across different cloud region.

### Rough
- Kube-proxy is implemented as daemonset.
- kube-proxy is implemented as static pod on a node.
#### Kube-DNS

### Geteway
- breaks the components into role based topology- Gateway controller(cloud provider), gateway(infra team), Route(svc owner)
- traffic weighing
- header based matching

