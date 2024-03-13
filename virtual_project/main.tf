module "ec2" {
	source = "../modules/ec2/"
	subnet_id = module.vpc.subnet_id
	vpc_id = module.vpc.vpc_id
	security_groups_id = module.vpc.security_groups_id
}

module "vpc" {
	source = "../modules/vpc/"

}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

