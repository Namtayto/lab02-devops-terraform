provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./security_group"
  vpc_id = module.vpc.vpc_id
}

module "route_table" {
  source = "./route_table"
  vpc_id = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
}

module "ec2" {
  source = "./ec2"
  public_subnet_id = module.subnets.public_subnet_id
  private_subnet_id = module.subnets.private_subnet_id
  private_sg_id = module.security_group.private_sg_id
  public_sg_id = module.security_group.public_sg_id
}
