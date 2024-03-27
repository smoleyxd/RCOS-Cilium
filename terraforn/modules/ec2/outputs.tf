output "instance_ids" {
  value       = aws_instance.k8s_node.*.id
  description = "The IDs of the EC2 instances."
}

output "instance_public_ips" {
  value       = aws_instance.k8s_node.*.public_ip
  description = "The public IPs of the EC2 instances."
}
