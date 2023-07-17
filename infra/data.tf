
data "aws_eks_cluster" "eks" { 
    name = module.eks-cluster.cluster_name 
}

data "aws_eks_cluster_auth" "eks" { 
    name = module.eks-cluster.cluster_name 
}

data "aws_iam_role" "blue" { 
    name = "blue-eks-node-group-20230717195427581600000002"
}

data "aws_iam_role" "green" { 
    name = "green-eks-node-group-20230717195427581500000001"
}




