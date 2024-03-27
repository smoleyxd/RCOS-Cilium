terraform {
  required_version = ">= 0.14"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc_k8s" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs= ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  cluster_name        = "?????" # TODO
}


# Security Groups Module
module "security_groups" {
  source          = "./modules/security_groups"
  cluster_name    = "?????" # TODO
  vpc_id          = module.vpc.vpc_id
  ssh_access_cidr = "?????" # TODO
  environment     = "prd"
}


# EC2 Module for Kubernetes Nodes
module "ec2_k8s_nodes" {
  source            = "./modules/ec2"
  instance_count    = 3
  ami_id            = "?????" # TODO
  instance_type     = "t2.medium"
  subnet_id         = "?????" # TODO
  key_name          = "?????" # TODO
  security_group_id = "?????" # TODO
  cluster_name      = "?????" # TODO
}


# Networking Module
module "networking_k8s" {
  source            = "./modules/networking"
  cluster_name      = "?????" # TODO
  availability_zones= ["us-east-1a", "us-east-1b"]
  subnets           = ["subnet-?????", "subnet-?????"] # TODO
  route53_zone_id   = "?????" # TODO
  route53_zone_name = "?????" # TODO
}


# IAM Module
module "iam_k8s" {
  source       = "./modules/iam"
  cluster_name = "?????" # TODO
}


# CloudWatch Module
module "cloudwatch_k8s_logs" {
  source            = "./modules/cloudwatch"
  cluster_name      = "?????"
  log_retention_days= 90
  environment       = "prd"
}

# S3 Modules
module "s3_logs" {
  source        = "./modules/s3"
  bucket_prefix = "?????" # TODO
  environment   = "prd"
}

module "s3_tfstate" {
  source        = "./modules/s3"
  bucket_prefix = "?????" # TODO
  environment   = "prd"
}


# Helm for deploying Cilium
module "cilium" {
  source                   = "./modules/cilium"
  kube_cluster_endpoint    = module.kubernetes.cluster_endpoint
  kube_cluster_token       = module.kubernetes.cluster_token
  kube_cluster_ca_certificate = module.kubernetes.cluster_ca_certificate
  cilium_version           = "1.9.5" # TODO specify Cilium version
}
