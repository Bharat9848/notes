## Overview
 - k8 provides automatic scale up and down, self healing, automated updates, deploy and rollback.
 - can deploy across multiple region ? 

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
 - cluster store is an etcd distributed store
  
## Kubectl
- KUBECONFIG: sets of path that have list of cluster information(API, certificates), user credential, list of contexts like cluster, default namespace and user, current context etc.
- `kubectl config` defines api over kubeconfig information like `use-context`, `current-context`.

## To expose a k8 service to the internet
 - Service type is required to be of `LoadBalancer` type and cloud provider automatically provision a L4 SLB with public IP exposed.
 - Or service type can be of `Ingress` type


## Container
 - Container runtime interface - abstract over containter runtime like docker,containerd etc ???

## practice
 - run 3/5 separate control plane nodes across different cloud region.