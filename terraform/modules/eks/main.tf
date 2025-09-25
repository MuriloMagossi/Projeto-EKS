# ===================================================================
# 2. MÓDULO DO CLUSTER EKS
# Fonte: terraform-aws-modules/eks/aws
# ===================================================================
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Use uma versão estável

  cluster_name    = "meu-cluster-eks"
  cluster_version = "1.29"

  # Conecta o EKS à VPC criada no passo anterior
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # Nós ficarão nas subnets privadas

  # Configuração dos Node Groups (onde suas aplicações vão rodar)
  eks_managed_node_groups = {
    # Um grupo de nós chamado 'workers'
    workers = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      # Anexa os nós às subnets privadas que foram criadas pelo módulo VPC
      subnet_ids = module.vpc.private_subnets
    }
  }

  # O módulo já cria as roles do IAM necessárias para o cluster e para os nós!
  # Isso simplifica enormemente a etapa 5 do seu plano.
}