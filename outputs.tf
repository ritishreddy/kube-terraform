# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.ritishvpc.id
}

# Output the public IP addresses of EC2 instances
output "instance_public_ips" {
  description = "Public IP addresses of the EC2 instances."
  value       = aws_instance.ritishvpc_instances[*].public_ip
}

# Output the private IP addresses of EC2 instances
output "instance_private_ips" {
  description = "Private IP addresses of the EC2 instances."
  value       = aws_instance.ritishvpc_instances[*].private_ip
}

# Output the SSH key name
output "ssh_key_name" {
  description = "The name of the SSH key pair."
  value       = aws_key_pair.ritishvpc_key_pair.key_name
}

# Output the security group ID
output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.ritishvpc_security_group.id
}
