data "aws_ami" "aws_ami_myos1" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


resource "aws_instance" "myos1" {
  ami = data.aws_ami.aws_ami_myos1.id
  count = 1
  instance_type = var.instance_type
  key_name = "my_learning_aws_key"
  subnet_id = var.subnet_id
  security_groups = [var.security_groups_id]

}
