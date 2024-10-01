provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.default.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].cluster_ca_certificate)
  }
}

locals {
  # Extract the hostname from the Kubernetes host URL
  k8s_service_host = regex("https?://([^:]+)", azurerm_kubernetes_cluster.default.kube_config[0].host)[0]
}

resource "helm_release" "cilium" {
  depends_on = [azurerm_kubernetes_cluster.default]
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.15.7" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "kubeProxyReplacement"
    value = "strict"
  }

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
  }

  set {
    name  = "prometheus.enabled"
    value = "true"
  }

  set {
    name  = "k8sServicePort"
    value = "443"
  }
}
