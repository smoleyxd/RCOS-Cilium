/*
variables.tf:
declares variables, provides metadata such as their type, description, and default values
doesn't set the actual values of the variables but just defines what variables are available for use as well as
any default values they may have
*/

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}
//default values are used if not overriden/provided in .tfvars file
//an absence of a default value means it must be explicitly set in .tfvars file

variable "region" {
  description = "The AWS region where the EKS cluster will be deployed"
  type        = string
  default     = "us-west-2"
}

variable "node_count" {
  description = "The number of nodes in the EKS cluster"
  type        = number
  default     = 2
}

//Specifies the type of EC2 instances used as nodes in the EKS cluster
variable "node_instance_type" {
  description = "The EC2 instance type for the EKS nodes"
  type        = string
  default     = "t3.medium"
}

/*
vpc: virtual private cloud; a costumizable, logically isolated virtual section of the AWS cloud
where you can define, manage, control your AWS resources and other networking aspects
such as IP addressing, subnets, routing, security, etc.
*/
variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be deployed"
  type        = string
}

//lists the subnet IDs within the specified VPC where the EKS cluster will be deployed
variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster"
  type        = list(string)
}
