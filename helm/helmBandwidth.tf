# helmBandwidth.tf

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
    value = local.k8s_service_host
  }
  
  set {
    name  = "kubeProxyReplacement"
    value = "true"
  }

  set {
    name = "bandwidthManager.enabled"
    value = "true"
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


