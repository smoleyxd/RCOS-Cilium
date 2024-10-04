# helmHubbleOff.tf

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.default.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].cluster_ca_certificate)
  }
}

resource "helm_release" "cilium" {
  name       = "cilium"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = azurerm_kubernetes_cluster.default.kube_config[0].host
  }
  
  set {
    name = "bpf.events.trace.enabled"
    value = "false"
  }
  
  set {
    name  = "kubeProxyReplacement"
    value = "true"
  }
}