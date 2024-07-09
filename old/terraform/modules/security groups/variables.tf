variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Used for tagging."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where security groups will be created."
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR block allowed for SSH access to the nodes."
  type        = string
  default     = "0.0.0.0/0" # TODO restrict this to known IPs for security
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prd) for tagging purposes."
  type        = string
}
