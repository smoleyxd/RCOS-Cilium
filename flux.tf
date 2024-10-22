# provider "flux" {
#   kubernetes = {
#     host                   = azurerm_kubernetes_cluster.default.kube_config[0].host
#     client_certificate     = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_certificate)
#     client_key             = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].client_key)
#     cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.default.kube_config[0].cluster_ca_certificate)
#   }
#   git = {
#     url = "ssh://git@github.com/${var.GITHUB_ORG}/${var.GITHUB_REPOSITORY}.git"
#     ssh = {
#       username    = "git"
#       private_key = tls_private_key.flux.private_key_pem
#     }
#   }
# }

# provider "github" {
#   owner = var.GITHUB_ORG
#   token = var.GITHUB_TOKEN
# }

# provider "kind" {}


# resource "kind_cluster" "this" {
#   name = "flux-bootstrap"
# }

# resource "github_repository" "this" {
#   name       = var.GITHUB_REPOSITORY
#   visibility = "private"
#   auto_init  = true
# }

# resource "tls_private_key" "flux" {
#   algorithm   = "ECDSA"
#   ecdsa_curve = "P256"
# }

# resource "github_repository_deploy_key" "this" {
#   title      = "flux-bootstrap"
#   repository = github_repository.this.name
#   key        = tls_private_key.flux.public_key_openssh
#   read_only  = false
# }

# resource "flux_bootstrap_git" "this" {
#   depends_on         = [github_repository.this]
#   embedded_manifests = true
#   path               = "clusters/my-cluster"
# }