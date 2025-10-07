output "vpc_id" {
  description = "ID da VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "ARN da VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "Bloco CIDR da VPC"
  value       = module.vpc.vpc_cidr_block
}
output "private_subnets" {
  description = "Lista de IDs das subnets privadas"
  value       = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "Lista de ARNs das subnets privadas"
  value       = module.vpc.private_subnet_arns
}
output "private_subnets_cidr_blocks" {
  description = "Lista de blocos CIDR das subnets privadas"
  value       = module.vpc.private_subnets_cidr_blocks
}
output "public_subnets" {
  description = "Lista de IDs das subnets publicas"
  value       = module.vpc.public_subnets
}

output "public_subnet_arns" {
  description = "Lista de ARNs das subnets publicas"
  value       = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "Lista de blocos CIDR das subnets publicas"
  value       = module.vpc.public_subnets_cidr_blocks
}