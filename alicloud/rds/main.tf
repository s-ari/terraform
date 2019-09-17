variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "prefix" {}
variable "ssh_key" {}

# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source      = "../modules/vpc"
  name        = "${var.prefix}_${terraform.workspace}_vpc"
  description = "${var.prefix} vpc"
  cidr_block  = "192.168.0.0/16"
}

module "vswitch_az_a" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"

  vswitch_cidr_block        = "192.168.1.0/24"
  vswitch_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_description       = "${var.prefix} vswitch_az_a"
  vswitch_availability_zone = "ap-northeast-1a"
}

module "vswitch_az_b" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"

  vswitch_cidr_block        = "192.168.2.0/24"
  vswitch_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_b"
  vswitch_description       = "${var.prefix} vswitch_az_b"
  vswitch_availability_zone = "ap-northeast-1b"
}

module "rds" {
  source           = "../modules/rds"
  instance_name    = "${var.prefix}-${terraform.workspace}-rds"
  engine           = "MySQL"
  engine_version   = "5.6"
  instance_type    = "rds.mysql.t1.small"
  instance_storage = "5"
  vswitch_id       = "${module.vswitch_az_a.vswitch_id}"
}

module "security_group" {
  source      = "../modules/security_group"
  vpc_id      = "${module.vpc.vpc_id}"
  name        = "${var.prefix}_${terraform.workspace}_sg"
  description = "${var.prefix} security group"
}

module "security_group_rule_ssh" {
  source            = "../modules/security_group_rule"
  security_group_id = "${module.security_group.security_group_id}"
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  cidr_ip           = "0.0.0.0/0"
}

module "ecs" {
  source                     = "../modules/ecs"
  description                = "${var.prefix} ecs"
  vswitch_id                 = "${module.vswitch_az_a.vswitch_id}"
  security_groups            = "${module.security_group.security_group_id}"
  count                      = "1"
  image_id                   = "ubuntu_18_04_64_20G_alibase_20190223.vhd"
  instance_type              = "ecs.t5-lc2m1.nano"
  system_disk_size           = "40"
  instance_name              = "${var.prefix}_${terraform.workspace}_ecs"
  host_name                  = "${var.prefix}-${terraform.workspace}-ecs"
  internet_max_bandwidth_out = "100"
  key_name                   = "${var.ssh_key}"
}
