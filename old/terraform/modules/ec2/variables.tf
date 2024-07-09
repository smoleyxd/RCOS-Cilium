variable "instance_count" {
  description = "Number of instances to launch."
  type        = number
}

variable "ami_id" {
  description = "The ID of the AMI to use for the instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type of the Kubernetes nodes."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the instances in."
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance."
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the instances."
  type        = string
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Used for tagging."
  type        = string
}
