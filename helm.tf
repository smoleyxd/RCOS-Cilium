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

resource "helm_release" "cilium_base" {
  name       = "cilium_base"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
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

resource "helm_release" "cilium_bandwidth" {
  name       = "cilium_bandwidth"
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

resource "helm_release" "cilium_bbr_congestion" {
  name       = "cilium_bbr_congestion"
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
    name = "bandwidthManager.bbr"
    value = "true"
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

resource "helm_release" "cilium_bigtcp" {
  name       = "cilium_bigtcp"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
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
    name  = "ipv6.enabled"
    value = "true"
  }

  set {
    name  = "enableIPv6BIGTCP"
    value = "true"
  }
  set {
    name  = "kubeProxyReplacement"
    value = "true"
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

resource "helm_release" "cilium_hubble_off" {
  name       = "cilium_hubble_off"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
  }
  
  set {
    name = "bpf.events.trace.enabled"
    value = "false"
  }
  
  set {
    name  = "kubeProxyReplacement"
    value = "true"
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

resource "helm_release" "cilium_iptables_bypass" {
  name       = "cilium_iptables_bypass"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
  }
  
  set {
    name = "installNoConntrackIptablesRules"
    value = "true"
  }
  
  set {
    name  = "kubeProxyReplacement"
    value = "true"
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


resource "helm_release" "cilium_netkit" {
  name       = "cilium_netkit"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
  }
  
  set {
    name  = "routingMode"
    value = "native"
  }

  set {
    name  = "bpf.datapathMode"
    value = "netkit"
  }

  set {
    name  = "bpf.masquerade"
    value = "true"
  }

  set {
    name  = "kubeProxyReplacement"
    value = "true"
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


resource "helm_release" "cilium_xdp" {
  name       = "cilium_xdp"
  repository = "https://helm.cilium.io/"
  chart      = "cilium"
  version    = "1.16.0" # specify the version you want to use
  namespace  = "kube-system"

  set {
    name  = "k8sServiceHost"
    value = local.k8s_service_host
  }

  set {
    name = "routingMode"
    value = "native"
  }
  
  set {
    name  = "kubeProxyReplacement"
    value = "true"
  }

  set {
    name = "loadBalancer.acceleration"
    value = "native"
  }

  set {
    name = "loadBalancer.mode"
    value = "hybrid"
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