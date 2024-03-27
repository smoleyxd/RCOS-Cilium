resource "aws_cloudwatch_log_group" "k8s_logs" {
  name              = "/aws/k8s/${var.cluster_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "LogGroup-${var.cluster_name}"
    Environment = var.environment
  }
}
