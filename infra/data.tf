data "aws_eks_cluster" "eks" { 
    name = module.eks-cluster.cluster_name 
}

data "aws_eks_cluster_auth" "eks" { 
    name = module.eks-cluster.cluster_name 
}