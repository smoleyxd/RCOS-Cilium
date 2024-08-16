#defines the resources needed for setting up an Amazon EKS cluster and its components


#defines an amazon EKS cluster
resource "aws_eks_cluster" "k8s_cluster" {
  name     = var.eks_cluster_name #name of the cluster
  role_arn = aws_iam_role.eks_role.arn

  vpc_config { #configures the VPC settings for the EKS cluster
    subnet_ids = module.vpc.subnet_ids #list of subnet IDs where EKS cluster will be deployed
    security_group_ids = [module.vpc.k8s_sg_id] #list of security group IDs associated with the EKS cluster
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy
  ]
}

#defines a node group for the EKs cluster
resource "aws_eks_node_group" "k8s_node_group" {
  cluster_name    = aws_eks_cluster.k8s_cluster.name #name of the EKS cluster to which this node group belongs, taken from previously created EKS cluster resource
  node_group_name = "${var.eks_cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnets         = module.vpc.subnet_ids

  scaling_config { #defines scaling settings for the node group
    desired_size = 2 #number of worker nodes that should be running in the node group
    max_size     = 3 #max number of worker nodes that can be in the node group
    min_size     = 1 #min number of worker nodes that should be in the node group
  }

  instance_types = [var.instance_type] #specifies the EC2 instance types to be used for the worker nodes

  depends_on = [
    aws_iam_role_policy_attachment.eks_policy #snures IAM policy attachment is completed before creating the node group (? learn more)
  ]
}

#creates an IAM role for the EKS cluster (?: learn more)
resource "aws_iam_role" "eks_role" {
  name = "eks-role"

  assume_role_policy = jsonencode({ #JSON policy that allows the EKS service to assume this role (?: learn more)
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#outputs the endpoint URL of the EKS cluster, necessary for configuring kubectl to interact with the cluster
output "kubeconfig" {
  value = aws_eks_cluster.k8s_cluster.endpoint
}

#outputs name of EKS cluster
output "cluster_name" {
  value = aws_eks_cluster.k8s_cluster.name
}

#outputs base64-encoded certificate authority data required for kubectl to authenticate to the EKS cluster
output "cluster_certificate" {
  value = aws_eks_cluster.k8s_cluster.certificate_authority[0].data
}
