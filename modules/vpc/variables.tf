variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}

variable "route_table_cidr_block" {
  default = "0.0.0.0/0"
}

variable "subnet_cidr_block" {
  default = "192.168.1.0/24"
}

variable "subnet_availability_zone" {
  default = "ap-south-1a"
}

variable "subnet_ip_launch" {
  default = "true"
}
