module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "meu-eks"
  kubernetes_version = "1.29"

  # Opcional
  endpoint_public_access = true

  # Opcional: Adiciona a identidade do chamador atual como administrador via entrada de acesso do cluster
  enable_cluster_creator_admin_permissions = true

  # Habilitar IRSA para service accounts
  enable_irsa = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  # Grupos de nós gerenciados
  eks_managed_node_groups = {
    general = {
      name = "general-purpose"

      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2

      vpc_security_group_ids = []
    }
  }

  tags = merge(var.common_tags, {
    Environment = "dev"
    Terraform   = "true"
  })
}

#Nome
#Versão
#perfil do IAM do cluster
#perfil IAM do nó
#VPC
#Subnets
