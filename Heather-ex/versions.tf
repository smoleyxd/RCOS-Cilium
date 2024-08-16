#locks versions of Terraform and providers to ensure consistency

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.0.1"
    }
  }
}
