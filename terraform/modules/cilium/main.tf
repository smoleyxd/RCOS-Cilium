provider "helm" {
  kubernetes {
    host                   = var.kube_cluster_endpoint
    token                  = var.kube_cluster_token
    cluster_ca_certificate = base64decode(var.kube_cluster_ca_certificate)
  }
}

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = var.cilium_version

  namespace = var.namespace

  # Enabling Hubble within the Cilium installation
  values = [
    "${file("${path.module}/cilium-values.yaml")}"
  ]
}
