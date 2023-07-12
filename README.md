# node-on-EKS
using Terraform + Argo CD to deploy a demo microservices application (nodejs and react) on Elastic Kubernetes Service.

### Network requirements 

- two subnets that are in different AZs 
- VPC must have DNS hostname and DNS resolution support 

Subnet Requirements: 
- EKS creates 2-4 elastic network interaces in the subnets that enable communication between the cluster and VPC 
- subnet must have atleast 6 IPs for EKS, 16 is recommended 
- subnet can be public or private, recommended to be private 


### Cluster Authentication 
- authentication is provided through IAM 
- authorization is still provided by kubernetes RBAC 

How to enable access to your cluster?

- access is granted through the aws-auth ConfigMap
- upon creation of a cluster, an IAM principal is automatically created with system:masters permissions, this principal isnt present in any configurations 
- to add additional users, edit the aws-auth ConfigMap. and create a rolebinding or clusterrolebinding with the name of group that you specify


### Nodes 

3 different types of kubernetes nodes 
- EKS managed nodegroups: Automate the provisioning and lifecycle management of nodes, nodes are managed in an EC2 autoscaling group, no additional costs associated with managed node groups
- self managed nodes 
- AWS fargate