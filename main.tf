module "vpc" {
  source = "./modules/vpc"

  cidr_block                  = "10.0.0.0/16"
  enable_dns_support          = true
  enable_dns_hostnames        = true
  vpc_name                    = "my-custom-vpc"
  private_subnets_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones          = ["us-east-1a", "us-east-1b"]
}

module "cilium" {
  source = "git::https://github.com/your-repo/terraform-helm-cilium.git?ref=v1.0.0"
  # Configuration parameters for Cilium
}

module "grafana" {
  source = "git::https://github.com/your-repo/terraform-helm-grafana.git?ref=v1.0.0"
  # Configuration parameters for Grafana
}
