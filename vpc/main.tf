terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  backend "remote" {
    organization = "mavenlink"

    workspaces {
      name = "vpc-dev"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "tf-cloud-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.203.0/24", "10.0.202.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}