# helmIPv4.tf

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
    name  = "routingMode"
    value = "native"
  }

  set {
    name  = "bpf.masquerade"
    value = "true"
  }
  
  set {
    name  = "ipv4.enabled"
    value = "true"
  }

  set {
    name  = "enableIPv4BIGTCP"
    value = "true"
  }

  set {
    name  = "kubeProxyReplacement"
    value = "true"
  }
}