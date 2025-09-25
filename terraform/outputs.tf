#EKS OUTPUTS
output "instance_id" {
  description = "ID of the created EKS"
  value = module.eks.instance_id
}