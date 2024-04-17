output "cluster_id" {
  description = "The ID of the EKS cluster."
  value       = module.eks.cluster_id
}

output "cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "The security group ID attached to the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

# output "node_group_status" {
#   description = "Status of the node group."
#   value       = module.eks.node_groups_status
# }

output "vpc_id" {
  description = "The VPC ID where the EKS cluster is deployed."
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "List of subnet IDs used by the EKS cluster."
  value       = module.vpc.private_subnets
}
