provider "flux" {
    kubernetes = {
        host                   = azurerm_kubernetes_cluster.default.kube_config[0].host
        client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_certificate)
        client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_key)
        cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].cluster_ca_certificate)
    }
    git = {
        url = "https://github.com/smoleyxd/RCOS-Cilium"
    }
}