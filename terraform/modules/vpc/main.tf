module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 6.3.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1b", "sa-east-1c"] # regiões de disponibilidade
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # sub-redes privadas (EKS nodes)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"] # sub-redes públicas (ALB/ingress)

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}