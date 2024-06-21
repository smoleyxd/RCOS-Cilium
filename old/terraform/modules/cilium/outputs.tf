output "cilium_helm_release_name" {
  description = "The name of the deployed Cilium Helm release."
  value       = helm_release.cilium.name
}

output "cilium_namespace" {
  description = "The namespace where Cilium is deployed."
  value       = var.namespace
}
