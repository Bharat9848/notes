## Cost
 - Cost estimation: hidden expenditure include licenses and maintenance are included
 - In "pay as you go model" cost can be estimated using price calculator.

## Glossary
 - **hypervisor** operating system for all vms runs on a physical machine. Hypervisor does not translate hosted vms instruction set to host instruction set. Type1/type2 hypervisor.
 - **Emulator** translate or map the instruction set to different instruction set.
 - Infrastructure as a service: include ip, firewall, vpc, storage and compute engine
 - Platform as a service: well defined and managed environment eg. cloud sql, app engine etc.
 - Software as a service: software services like map, email etc without installing it anywhere.
 - Virtualization: abstraction over hardware to provice logical separation on resources like CPU, network and disk and provide stable/configurable os on it.
 - Multi-tanent:  No logical separation between multiple user. Different users's data is stored with your data.
 - Type of cloud: 
   - private: all is hidden, nothing is exposed via public IP. User can only acccess services using VPN connection.
   - public:  Services like API server, websites etc are exposed to public via public IP.
   - hybrid: Mix of private and public.
   - Multi-cloud: use same
- Live migration: updating VM/hardware to new version by migration live VM to other VMs without taking downtime.  
- Network endpoint group - logical grouping of network devices for better management.

## Network
 - VPC is global.   
 - VPC is a virtual private cloud which have subgroups called subnet or sub-network. Each sub-network are logical group of network devives like VM, pods etc.
 - CIDR is IP ranges
 - Subnet: A single subnet share the same IP cidr among devices in that subnets.
 - Devices from different subnet from the same VPC can communicate to each other without any public ip address.  	
 - VPC flow logs monitor communication between subnet. It can be helpful in detecting malicious activity.

## GCP
 ## Data model 
 - Access Model for an Organisation
  Organisation (company)
   - Department X, Department Y... Shared Dependencies (folder)
     - Team X, Team Y ... (folder)
       - Product 1, product 2 (folder)
        - project Dev, project test, project prod (project)
          - Vms, storage etc (services)

 - Project is the most fundamental unit. We have to select project before using or seeing any GCP services. 
 - Only IAM and billing is at organisation level.
 - IAM data model
   1. roles `<resource_permission>`
 ### google cloud armor
  - prevent DDOS attacks. It can be easily integrate with load balancer.

 ### Cloud storage
  - flat namespace
  - storage classes should be applied carefully for frequently access data `Multi-regional`/`regional`/`standard` and for non frequently data should be accessed through `coldline`/`nearline`/`archive`.  
  - Access control are at object level/ bucket level.
  - `Signed urls` are used to give public access for specific time period.

 ### Cloud VM
  - can have external Ips or access to Cloud NAT.
 ### Cloud sql
  - increase storage space automatically.
  - binary logging should be enabled to restore database to some older timestamp.
  - instance 
   `usercrm` 
  password 
  ````
  B}`x/lGLz~hRil5Q
  ````
  - disable data cache
  - check database backup frequency
  - scheduled maintainence window.
  - encryption at rest and transit


## Load Balancer
## Terms
 - Anycast IP address: Special IP address that is used for global load balancer with multi-region backends.
 - passthrough load balancer: only do load balancing. Client connection is passed on to backend.
 - proxy load balancer: do SSL offload. Manages two separate connection one with client and one with backend. 
## L7 load balancer:
 - External facing load balancer are envoy proxy based
 - load balancing is based on URI or Http headers.
 - internal facing load balancer are Andromeda network virtualization stack and envoy proxy based
## L4 Load balancer
## Google Front Ends
## Envoy proxy

## Load balancer internal components
 1. `Forwarding rule` specifies frontend of load balancer which have an IP address, protocol and port.
 2. `Target Proxy` handles seprate downstream and upstream connection.
 3. `proxy-only-subnet` IP ranges used by envoy proxy nodes.
 4. `SSL certificates` certificate and private key to negotiate secure traffic between client and load balancer.
 5. `URL Map`
 6. `Backend service` a logical unit of backend related configuration like distribution session settings, health checks and timeout
 7. `Backend bucket` for static content
 8. `Health Checks`
 9. `firewall rules` 
 10. `Backends`

### Load Balancer Internal
 - see notes from google Maglev.md
 - Andromeda









          
