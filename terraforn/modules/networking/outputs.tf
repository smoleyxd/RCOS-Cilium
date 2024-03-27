output "elb_dns_name" {
  value       = aws_elb.k8s_elb.dns_name
  description = "The DNS name of the ELB created for the Kubernetes cluster."
}

output "route53_dns_record" {
  value       = aws_route53_record.k8s_dns.name
  description = "The Route 53 DNS record for the Kubernetes cluster."
}
