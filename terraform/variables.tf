variable "region" {
  description = "regiao AWS onde os recursos serao criados"
  type        = string
  default     = "us-east-1"
}
variable "common_tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default = {
    Project     = "EKS-Terraform"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}