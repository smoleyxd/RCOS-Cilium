#consolidates outputs from the various modules and resources

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_certificate" {
  value = module.eks.cluster_certificate
}
