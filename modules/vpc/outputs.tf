output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "private_subnets" {
  value       = aws_subnet.private[*].id
  description = "List of IDs of private subnets"
}
