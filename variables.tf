variable "region" {
  description = "AWS region to deploy the EKS cluster."
  type        = string
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "eks-cilium-test"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster."
  type        = string
  default     = "1.29"
}

variable "node_instance_type" {
  description = "Instance type for the EKS worker nodes."
  type        = string
  default     = "t2.medium"
}

variable "node_group_name" {
  description = "Name of the EKS node group."
  type        = string
  default     = "testing-node-group"
}

variable "key_name" {
  description = "SSH key name to be used for the worker nodes."
  type        = string
  default     = "Smith-Foley-Laptop"
}
