variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
  default     = "us-east-2"
}

variable "cluster_name" {
  type        = string
  description = "rocs-cilium-testing"
}
