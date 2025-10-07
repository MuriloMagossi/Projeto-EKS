terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.32"
    }
  }
}
provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
  common_tags = var.common_tags
}

module "eks" {
  source = "./modules/eks"
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
}

module "alb" {
  source = "./modules/alb"
  common_tags = var.common_tags
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
}