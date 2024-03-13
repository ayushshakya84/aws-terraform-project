variable "instance_type"{
   type = string
   default =  "t2.micro"
}

variable "subnet_id" {
  type = string
  description = "ID of the subnet"
}


variable "vpc_id" {
  description = "ID of the VPC"
}

variable "security_groups_id" {
  description = "ID of sg-myos1"
}
