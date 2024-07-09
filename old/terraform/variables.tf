variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for Kubernetes nodes"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID to use for Kubernetes nodes"
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
}

variable "helm_chart" {
  description = "The Helm chart to be deployed"
  type        = string
}

variable "helm_version" {
  description = "The version of the Helm chart to be deployed"
  type        = string
  default     = "latest"
}
