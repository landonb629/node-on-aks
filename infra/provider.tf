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
  host = module.eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks-cluster.cluster_certificate_authority_data)
  exec { 
    api_version = "client.authentication.k8s.io/v1beta1"
    command = "aws"
    args = ["eks", "get-token", "--cluster-name", module.eks-cluster.cluster_name]
  }
}

provider "helm" { 
  kubernetes { 
    host = module.eks-cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks-cluster.cluster_certificate_authority_data)
    exec { 
      api_version = "client.authentication.k8s.io/v1beta1"
      command = "aws"
      args = ["eks", "get-token", "--cluster-name", module.eks-cluster.cluster_name]
    }
  }
}
