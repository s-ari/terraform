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
  description = "${var.prefix} ${terraform.workspace} vpc"
  cidr_block  = "172.16.0.0/12"
}

module "vswitch_az_a" {
  source = "../modules/vswitch_az_a"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_a_cidr_block        = "172.16.0.0/24"
  vswitch_a_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_a_description       = "${var.prefix} ${terraform.workspace} vswitch_az_a"
  vswitch_availability_zone_a = "ap-northeast-1a"
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
  rule_ssh_cidr_ip     = "202.45.12.165/32"
}

module "ecs" {
  source                     = "../modules/ecs"
  description                = "${var.prefix} ecs"
  vswitch_id                 = "${module.vswitch_az_a.vswitch_zone_a_id}"
  security_groups            = "${module.security_group.security_group_id}"
  count                      = "1"
  image_id                   = "ubuntu_18_04_64_20G_alibase_20181212.vhd"
  instance_type              = "ecs.t5-lc1m4.large"
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = "50"
  instance_name              = "${var.prefix}_${terraform.workspace}"
  host_name                  = "${var.prefix}-${terraform.workspace}"
  internet_max_bandwidth_in  = "200"
  internet_max_bandwidth_out = "100"
  key_name                   = "${var.ssh_key}"
}
