output "master_instance_id" {
  value       = aws_instance.k8s_master.id
  description = "The ID of the Kubernetes master instance."
}

output "worker_instance_ids" {
  value       = aws_instance.k8s_worker.*.id
  description = "The IDs of the Kubernetes worker instances."
}
