#iniitialize HCP provider to authenticate and manage resources in HCP
provider "hcp" {
  client_id     = "<your-client-id>"
  client_secret = "<your-client-secret>"
}

#initialize AWS provider- provides necessary infrastructure for kubernetes cluster
provider "aws" {
  region = "us-west-2"
}

#create a VPC on AWS- a virtual network dedicated to your AWS account
#where AWS resources like EC2 instances can be launched
module "vpc" {
  source = "./vpc"  #reference to the VPC module (defined in `vpc.tf`)
}

module "eks" {
  source = "./eks"  #reference to the EKS module (defined in `eks.tf`)
}

#outputs used to expose certain values after infrastructure is deployed

#provides kubeconfig file content; used to configure kubectl which is the command-line tool for 
#interacting wiht kubernetes clusters
output "kubeconfig" {
  value = module.eks.kubeconfig
}

output "cluster_name" {
  value = module.eks.cluster_name #retrieve name of cluster specified in eks module
}

output "cluster_certificate" {
  value = module.eks.cluster_certificate #provides certificate authority data needed to securley communicate with kubernetes clusters;
  #fetches CA certificate from eks module, required for validating identify of kubernetes API server
}
