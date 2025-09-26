# ===================================================================
# VARIÁVEIS PRINCIPAIS
# ===================================================================

variable "region" {
  description = "Região AWS onde os recursos serão criados"
  type        = string
  default     = "sa-east-1"
}

# ===================================================================
# TAGS
# ===================================================================

variable "common_tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default = {
    Project     = "EKS-Terraform"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}