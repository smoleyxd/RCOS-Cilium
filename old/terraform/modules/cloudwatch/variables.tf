variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Used for naming the log group."
  type        = string
}

variable "log_retention_days" {
  description = "The number of days to retain logs in the log group."
  type        = number
  default     = 30
}

variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod) for tagging purposes."
  type        = string
}
