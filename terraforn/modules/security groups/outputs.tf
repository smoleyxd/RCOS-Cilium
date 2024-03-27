output "k8s_node_sg_id" {
  value       = aws_security_group.k8s_node_sg.id
  description = "The ID of the security group for Kubernetes nodes."
}

output "lb_sg_id" {
  value       = aws_security_group.lb_sg.id
  description = "The ID of the security group for the Kubernetes Load Balancer."
}
