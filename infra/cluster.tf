/*

Resources required to fully deploy an EKS cluster with terraform
- subnets 
- vpc 
- security groups 
- IAM roles 
- worker node groups (aws launch configuration + aws_instance)
- aws autoscaling group 
*/
locals {
  eks-iam-role = "eks-cluster-role"
  eks-cluster  = "empower-prod-cluster"
}

module "eks-cluster"  { 
    source = "terraform-aws-modules/eks/aws"
    version =  "~> 19.0"

    cluster_name = local.eks-cluster 
    cluster_version = "1.27"
    cluster_endpoint_public_access = true 
    cluster_addons = { 
        coredns = { 
            most_recent = false 
            addon_version = "v1.10.1-eksbuild.2"
        }
        kube-proxy = { 
            most_recent = true
        }
        vpc-cni = { 
            most_recent = false 
            addon_version = "v1.13.2-eksbuild.1"
        }
    }
    vpc_id = aws_vpc.production.id 
    subnet_ids = [aws_subnet.private_subnets["private-1a"].id, aws_subnet.private_subnets["private-2a"].id]
    control_plane_subnet_ids = [aws_subnet.private_subnets["private-1a"].id, aws_subnet.private_subnets["private-2a"].id]
    kms_key_administrators = ["arn:aws:iam::500731508494:user/landon.babay", "arn:aws:iam::500731508494:user/empower-CICD"]
    eks_managed_node_group_defaults = { 
        instance_types = ["t3.medium"]
    }
    eks_managed_node_groups = {
        prod-nodegroup = { 
            min_size = 2
            max_size = 2
            desired_size = 2 
            instance_types = ["t3.medium"]
        }        
    }
   
    manage_aws_auth_configmap = true
    aws_auth_users = [ 
        { 
            userarn = "arn:aws:iam::500731508494:user/landon.babay"
            username = "landon.babay"
            groups = ["system:masters"]
        }, 
        { 
           userarn = "arn:aws:iam::500731508494:user/empower-CICD",
           username = "empower-CICD",
           groups = ["system:masters"]
        }
    ]
    // KMS stuff - this is going to remove the cluster KMS key being created
    cluster_encryption_config = {}
}

