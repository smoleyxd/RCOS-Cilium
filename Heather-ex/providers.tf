#defines the providers used, ensures consistency across Terraform configuration

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

provider "aws" {
  region = var.aws_region
}
