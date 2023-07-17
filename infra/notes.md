# resources created when creating a cluster manually

coredns - addon by default 
kube-proxy - addon by default 
vpc-cni addon by default

This will have no nodes 


IAM 

Node groups -> 
    - each node is assigned the service account aws-node 


# amazon VPC CNI plugin 

- implements cluster netowrking through 



# Community Module notes 

- IAM roles 
    - Node Group IAM roles:
         - this is an EC2 trust relationship role 
         - the policies that are attached to this are AmazonEC2ContainerRegistryReadOnly, AmazonEKS_CNI_Policy, and AmazonEKSWorkerNodePolicy
        the policies: 
            - AmazonEKS_CNI_Policy: provides the amazon VPC CNI plugin the permissions to modify the IP address configuration on your EKS worker nodes 
            - AmazonEC2ContainerRegistryReadOnly: provides read only acces to the container registry repositories 
            - AmazonEKSWorkerNodePolicy: allows EKS nodes to connect to the EKS clusters
    - Cluster IAM role:
         - EKS trust relationship role 
         - the policies attached are: Customer managed permission for cluster encryption, AmazonEKSClusterPolicy, AmazonEKSVPCResourceController, custom inline permissions
        the policies:
          - customer managed permission for cluster encryption: this is created pretty much just to be able to manage the specific KMS key that was created 
          - AmazonEKSClusterPolicy: created for the cluster to have proper permissions 
          - AmazonEKSVPCResourceController: used when you have security groups for your pods 
          - random inline permission, idk if it has much value

- Pods 


- Plugins 


- Node Groups 


- Security Groups 

