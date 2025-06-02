output "vpc_ids" {
  description = "List of VPC IDs created"
  value       = [for vpc in values(aws_vpc.use1) : vpc.id]
}

output "public_subnet_ids" {
  description = "List of Public Subnet IDs created"
  value       = [for subnet in aws_subnet.useusubnet1 : subnet.id]  
}

