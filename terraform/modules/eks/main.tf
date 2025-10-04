module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "meu-eks"
  kubernetes_version = "~> 2.23"

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = "vpc-0298439287506220b"
  subnet_ids = ["subnet-09656565656565656", "subnet-09656565656565656", "subnet-09656565656565656"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}