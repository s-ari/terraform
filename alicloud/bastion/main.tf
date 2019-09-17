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
  description = "${var.prefix} ${terraform.workspace} vpc"
  cidr_block  = "172.16.0.0/12"
}

module "vswitch_az_a" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"

  vswitch_cidr_block        = "172.16.0.0/24"
  vswitch_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_description       = "${var.prefix} ${terraform.workspace} vswitch_az_a"
  vswitch_availability_zone = "ap-northeast-1a"
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
  image_id                   = "ubuntu_18_04_64_20G_alibase_20181212.vhd"
  instance_type              = "ecs.t5-c1m1.large"
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = "50"
  instance_name              = "${var.prefix}_${terraform.workspace}"
  host_name                  = "${var.prefix}-${terraform.workspace}"
  internet_max_bandwidth_out = "100"
  key_name                   = "${var.ssh_key}"
}
