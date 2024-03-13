resource "aws_vpc" "terraform_vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "terraform_vpc"
  }
}


resource "aws_internet_gateway" "gateway_terraform" {
  vpc_id = aws_vpc.terraform_vpc.id

  depends_on = [
  aws_vpc.terraform_vpc
  ]
}


resource "aws_route_table" "route_terraform_public" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
    cidr_block = var.route_table_cidr_block
    gateway_id = aws_internet_gateway.gateway_terraform.id
  }

  tags = {
    Name = "route_terraform_public"
  }

  depends_on = [
  aws_vpc.terraform_vpc,
  aws_internet_gateway.gateway_terraform
  ]

}

resource "aws_subnet" "terraform_public_subnet" {
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.subnet_availability_zone
  map_public_ip_on_launch = var.subnet_ip_launch

  tags = {
    Name = "terraform_public_subnet"
  }

 depends_on = [
  aws_vpc.terraform_vpc
  
  ]
}

resource "aws_route_table_association" "route_association_tf_public" {
  subnet_id = aws_subnet.terraform_public_subnet.id
  route_table_id = aws_route_table.route_terraform_public.id

  depends_on = [
  aws_subnet.terraform_public_subnet,
  aws_route_table.route_terraform_public
  ]
}

resource "aws_security_group" "tcp_allow"{
 name        = "webserver"
  description = "Allow HTTP from Anywhere"
  vpc_id      = aws_vpc.terraform_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
