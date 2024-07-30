variable "CLIENT_SECRET" {
  type        = string
  description = "Password for the azure cli user"
}
variable "CLIENT_ID" {
  type        = string
  description = "appId for the azure cli user"
}
variable "TENANT_ID" {
  type        = string
  description = "tenant id for the rcos-cilium_group resource group"
}
variable "SUBSCRIPTION_ID" {
  type        = string
  description = "subscription id for the rcos-cilium_group resource group"
}
variable "RESOURCE_GROUP_LOCATION" {
  type        = string
  description = "location for the rcos-cilium resource group"
  #For some reason we can't add a new 
}
variable "GITHUB_REPOSITORY" {
  type        = string
  description = "github repository of the rcos-cilium github repository"
}
variable "GITHUB_ORG" {
  type        = string
  description = "github organization of the rcos-cilium github repository"
}
variable "GITHUB_TOKEN" {
  type        = string
  default     = ""
  description = "github token of the rcos-cilium github repository"
}
