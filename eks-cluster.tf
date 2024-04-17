module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnets         = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  node_groups = {
    example = {
      desired_capacity = 4
      max_capacity     = 4
      min_capacity     = 4

      instance_type = var.node_instance_type
      key_name      = var.key_name
    }
  }
}
