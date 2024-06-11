variable "cluster_name" {
  description = "The name of the Kubernetes cluster. Used for naming."
  type        = string
}

variable "availability_zones" {
  description = "The availability zones in which to deploy the ELB."
  type        = list(string)
}

variable "subnets" {
  description = "The subnets for the ELB."
  type        = list(string)
}

variable "route53_zone_id" {
  description = "The Route 53 hosted zone ID for DNS records."
  type        = string
}

variable "route53_zone_name" {
  description = "The Route 53 hosted zone name for DNS records."
  type        = string
}
