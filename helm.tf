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

resource "helm_release" "loki" {
  name       = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  version    = "2.9.1" # specify the version you want to use
  //namespace  = kubernetes_namespace.logging.metadata[0].name
  cleanup_on_fail = true


  set {
    name  = "loki.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "loki.config.table_manager.retention_deletes_enabled"
    value = "true"
  }

  set {
    name  = "loki.config.table_manager.retention_period"
    value = "168h" # retention period of 7 days
  }
}


resource "helm_release" "fluentbit" {
  name       = "fluentbit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "0.47.5"
  //namespace  = kubernetes_namespace.logging.metadata[0].name
  cleanup_on_fail = true

  set {
    name  = "backend.type"
    value = "loki"
  }

  set {
    name  = "backend.loki.host"
    value = "http://loki.logging.svc.cluster.local:3100"
  }

  set {
    name  = "backend.loki.labels"
    value = "{job=\"fluent-bit\"}"
  }

  set {
    name  = "backend.loki.batchWait"
    value = "1s"
  }

  set {
    name  = "backend.loki.batchSize"
    value = "102400"
  }

  set {
    name  = "resources.limits.cpu"
    value = "500m"
  }

  set {
    name  = "resources.limits.memory"
    value = "512Mi"
  }

  set {
    name  = "resources.requests.cpu"
    value = "100m"
  }

  set {
    name  = "resources.requests.memory"
    value = "128Mi"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "fluentbit-sa"
  }

  set {
    name  = "tolerations[0].key"
    value = "node-role.kubernetes.io/master"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoSchedule"
  }

  set {
    name  = "nodeSelector.role"
    value = "logging"
  }

  set {
    name  = "prometheus.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "prometheus.serviceMonitor.namespace"
    value = "monitoring"
  }

  set {
    name  = "prometheus.serviceMonitor.interval"
    value = "30s"
  }

  set {
    name  = "prometheus.serviceMonitor.scrapeTimeout"
    value = "10s"
  }
}

