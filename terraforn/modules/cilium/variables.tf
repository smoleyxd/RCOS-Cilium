variable "kube_cluster_endpoint" {
  description = "Endpoint for the Kubernetes cluster."
  type        = string
}

variable "kube_cluster_token" {
  description = "Token for authentication to the Kubernetes cluster."
  type        = string
}

variable "kube_cluster_ca_certificate" {
  description = "CA certificate for the Kubernetes cluster, base64 encoded."
  type        = string
}

variable "cilium_version" {
  description = "The version of the Cilium Helm chart to deploy."
  type        = string
  default     = "1.9.1"
}

variable "namespace" {
  description = "The Kubernetes namespace in which to deploy Cilium."
  type        = string
  default     = "kube-system"
}
