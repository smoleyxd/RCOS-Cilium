output "iam_role_name" {
  value       = aws_iam_role.k8s_role.name
  description = "The name of the IAM role created for Kubernetes nodes."
}

output "iam_instance_profile" {
  value       = aws_iam_instance_profile.k8s_instance_profile.name
  description = "The instance profile to be used by the EC2 instances."
}
