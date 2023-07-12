terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket  = "empowercloudtech"
    key     = "nodeonaks"
    region  = "us-east-2"
    profile = "empowercloud"
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "empowercloud"
}