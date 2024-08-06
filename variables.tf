# variables.tf

variable "CLIENT_SECRET" {
  type        = string
  description = "Password for the Azure CLI user"
}

variable "CLIENT_ID" {
  type        = string
  description = "appId for the Azure CLI user"
}

variable "TENANT_ID" {
  type        = string
  description = "Tenant ID for the RCOS-Cilium_group resource group"
}

variable "SUBSCRIPTION_ID" {
  type        = string
  description = "Subscription ID for the RCOS-Cilium_group resource group"
}

variable "RESOURCE_GROUP_LOCATION" {
  type        = string
  description = "Location for the RCOS-Cilium resource group"
}

variable "GRAFANA_API_KEY" {
  type = string
  description = "API key for loki/grafana"
}
