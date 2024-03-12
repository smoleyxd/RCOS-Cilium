variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones in which to create the subnets."
  type        = list(string)
}
