output "subnet_id" {
  description = "Subnet ID"
  value = aws_subnet.terraform_public_subnet.id
}

output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.terraform_vpc.id
}

output "security_groups_id" {
 description = "sg-myos"
 value = aws_security_group.tcp_allow.id
}
