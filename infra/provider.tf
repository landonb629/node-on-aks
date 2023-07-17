terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
  backend "s3" {
    bucket  = "empowercloudtech"
    key     = "nodeonaks"
    region  = "us-east-2"
  }
  required_version = "1.5.2"
}

provider "aws" {
  region  = "us-east-2"
}

provider "kubernetes" { 
    host = data.aws_eks_cluster.eks.endpoint 
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.eks.token 
}

provider "helm" { 
  kubernetes { 
    host = data.aws_eks_cluster.eks.endpoint 
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token = data.aws_eks_cluster_auth.eks.token
  }
}
