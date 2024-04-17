provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0"

  namespace = "kube-system"

  set {
    name  = "global.nodeinit.enabled"
    value = "true"
  }

  set {
    name  = "global.kubeProxyReplacement"
    value = "partial"
  }

  set {
    name  = "global.hostServices.enabled"
    value = "true"
  }

  set {
    name  = "global.externalIPs.enabled"
    value = "true"
  }

  set {
    name  = "global.nodePort.enabled"
    value = "true"
  }

  set {
    name  = "global.hostPort.enabled"
    value = "true"
  }
}
