output "cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Endpoint for EKS Kubernetes API server"
}

output "grafana_endpoint" {
  value       = module.grafana.endpoint
  description = "Endpoint for the Grafana dashboard"
}
