output "cloudwatch_log_group_name" {
  value       = aws_cloudwatch_log_group.k8s_logs.name
  description = "The name of the CloudWatch log group created for the Kubernetes cluster."
}

output "cloudwatch_log_group_arn" {
  value       = aws_cloudwatch_log_group.k8s_logs.arn
  description = "The ARN of the CloudWatch log group created for the Kubernetes cluster."
}
