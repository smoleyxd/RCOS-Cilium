#example variables.tf: used to define any input variables that can be customized

#geographic region where infrastructure will be deployed
variable "aws_region" {
  description = "The AWS region to deploy the cluster in"
  default     = "us-east-1"
}

#defines CIDR block for VPC, specifies IP address range available
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

#list of CIDR blocks that define the IP ranges for the subnets within the VPC, each element corresoponding to a different subnet
#subnet: segment of VPC's IP address range where you can place resources such as EC2 instances
variable "subnet_cidrs" {
  description = "CIDR blocks for the subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"] #creates two subnets
}

#defines the name of EKS cluster
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  default     = "k8s-cluster"
}

#specifies the EC2 isntance type used for the worker nodes in your EKS cluster
#instance types define the hardware characteristics (CPU, memory, storage) of the virtual machines that run your workloads
variable "instance_type" {
  description = "EC2 instance type for the EKS worker nodes"
  default     = "t3.medium" #default value with 2vCPUs and 4 GB memory
}

#holds the client ID for HCP account- used to authenticate with HCP
provider "hcp" {
  client_id = var.hcp_client_id #public identifier for app or service requesting access to an API or service
  #when your application requests access to a user's data, includes the client ID in teh request to indicate which application is
  #making the request
}

#stores the client secret associated with your HCP client ID, used to authenticate with HCP securely
provider "hcp" {
  client_secret = var.hcp_client_secret #confidential information known only to the application and authorization server; used to prove the identity
  #of the client application and authenticate it during the request
}


