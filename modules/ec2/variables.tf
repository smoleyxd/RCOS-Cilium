variable "ami_id" {
  description = "The AMI ID for the instances."
}

variable "master_instance_type" {
  description = "Instance type for the master node."
  default     = "t2.medium"
}

variable "worker_instance_type" {
  description = "Instance type for the worker nodes."
  default     = "t2.medium"
}

variable "subnet_id" {
  description = "The ID of the subnet where instances will be created."
}

variable "key_name" {
  description = "The key name to use for the instance."
}

variable "security_group_name" {
  description = "The name of the security group to attach to the instances."
}

variable "worker_count" {
  description = "The number of worker instances to create."
  default     = 2
}
