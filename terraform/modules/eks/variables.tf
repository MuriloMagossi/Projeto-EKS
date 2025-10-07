variable "common_tags" {
  description = "Tags comuns para todos os recursos"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID da VPC onde o EKS sera criado"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas para o EKS"
  type        = list(string)
}