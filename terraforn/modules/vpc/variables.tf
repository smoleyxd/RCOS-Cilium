variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "A list of public subnet CIDR blocks."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "A list of private subnet CIDR blocks."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in which to create subnets."
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Used for tagging."
  type        = string
}
