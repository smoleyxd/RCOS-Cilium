resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "14.0.0"

  namespace  = "monitoring"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
}