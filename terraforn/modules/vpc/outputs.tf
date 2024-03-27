output "vpc_id" {
  value       = aws_vpc.k8s_vpc.id
  description = "The ID of the VPC created for the Kubernetes cluster."
}

output "public_subnets" {
  value       = aws_subnet.public_subnet.*.id
  description = "The IDs of the public subnets created in the VPC."
}

output "private_subnets" {
  value       = aws_subnet.private_subnet.*.id
  description = "The IDs of the private subnets created in the VPC."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.id
  description = "The ID of the Internet Gateway attached to the VPC."
}
