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
  prefix      = "${var.prefix}"
  name        = "${var.prefix}_${terraform.workspace}_vpc"
  description = "${var.prefix} vpc"
  cidr_block  = "192.168.0.0/16"
}

module "vswitch_az_a" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_cidr_block        = "192.168.1.0/24"
  vswitch_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_description       = "${var.prefix} vswitch_az_a"
  vswitch_availability_zone = "ap-northeast-1a"
}

module "vswitch_az_b" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_cidr_block        = "192.168.2.0/24"
  vswitch_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_b"
  vswitch_description       = "${var.prefix} vswitch_az_b"
  vswitch_availability_zone = "ap-northeast-1b"
}

module "security_group" {
  source               = "../modules/security_group"
  vpc_id               = "${module.vpc.vpc_id}"
  prefix               = "${var.prefix}"
  name                 = "${var.prefix}_${terraform.workspace}_sg"
  description          = "${var.prefix} security group"
  rule_ssh_type        = "ingress"
  rule_ssh_ip_protocol = "tcp"
  rule_ssh_nic_type    = "intranet"
  rule_ssh_policy      = "accept"
  rule_ssh_port_range  = "22/22"
  rule_ssh_cidr_ip     = "0.0.0.0/0"
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
