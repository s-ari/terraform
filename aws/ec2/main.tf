variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "prefix" {}
variable "ssh_key" {}

# Configure the AWS Provider
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source               = "../modules/vpc"
  prefix               = "${var.prefix}"
  name                 = "${var.prefix}_${terraform.workspace}_vpc"
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
}

module "subnet_az_a" {
  source            = "../modules/subnet"
  vpc_id            = "${module.vpc.vpc_id}"
  prefix            = "${var.prefix}"
  cidr_block        = "192.168.1.0/24"
  name              = "${var.prefix}_${terraform.workspace}_subnet_az_a"
  availability_zone = "ap-northeast-1a"
}

module "subnet_az_c" {
  source            = "../modules/subnet"
  vpc_id            = "${module.vpc.vpc_id}"
  prefix            = "${var.prefix}"
  cidr_block        = "192.168.2.0/24"
  name              = "${var.prefix}_${terraform.workspace}_subnet_az_c"
  availability_zone = "ap-northeast-1c"
}

module "igw" {
  source = "../modules/internet_gateway"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"
  name   = "${var.prefix}_${terraform.workspace}_igw"
}

module "route_table" {
  source     = "../modules/route_table"
  vpc_id     = "${module.vpc.vpc_id}"
  prefix     = "${var.prefix}"
  name       = "${var.prefix}_${terraform.workspace}_route_table"
  cidr_block = "0.0.0.0/0"
  gateway_id = "${module.igw.gateway_id}"
}

module "route_table_association_az_a" {
  source         = "../modules/route_table_association"
  subnet_id      = "${module.subnet_az_a.subnet_id}"
  route_table_id = "${module.route_table.route_table_id}"
}

module "route_table_association_az_c" {
  source         = "../modules/route_table_association"
  subnet_id      = "${module.subnet_az_c.subnet_id}"
  route_table_id = "${module.route_table.route_table_id}"
}

module "security_group" {
  source      = "../modules/security_group"
  vpc_id      = "${module.vpc.vpc_id}"
  prefix      = "${var.prefix}"
  name        = "${var.prefix}_${terraform.workspace}_sg"
  description = "for ${var.prefix}_${terraform.workspace}_sg"
  cidr_block  = "0.0.0.0/0"
  from_port   = "22"
  to_port     = "22"
  protocol    = "tcp"
}

module "security_group_rule" {
  source      = "../modules/security_group_rule"
  cidr_block  = "0.0.0.0/0"
  from_port   = "80"
  to_port     = "80"
  protocol    = "tcp"
  security_group_id = "${module.security_group.security_group_id}"
}

module "ec2" {
  source                      = "../modules/instance"
  prefix                      = "${var.prefix}"
  name                        = "${var.prefix}_${terraform.workspace}_ec2"
  key_name                    = "${var.ssh_key}"
  ami                         = "ami-09c81ecf1c2b2ef70"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = "${module.security_group.security_group_id}"
  subnet_id                   = "${module.subnet_az_a.subnet_id}"
  associate_public_ip_address = "true"
}
