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
  source = "../modules/vswitch_az_a"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_a_cidr_block        = "192.168.1.0/24"
  vswitch_a_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_a_description       = "${var.prefix} vswitch_az_a"
  vswitch_availability_zone_a = "ap-northeast-1a"
}

module "vswitch_az_a2" {
  source = "../modules/vswitch_az_a"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_a_cidr_block        = "192.168.3.0/24"
  vswitch_a_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a2"
  vswitch_a_description       = "${var.prefix} vswitch_az_a2"
  vswitch_availability_zone_a = "ap-northeast-1a"
}

module "vswitch_az_b" {
  source = "../modules/vswitch_az_b"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_b_cidr_block        = "192.168.2.0/24"
  vswitch_b_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_b"
  vswitch_b_description       = "${var.prefix} vswitch_az_b"
  vswitch_availability_zone_b = "ap-northeast-1b"
}
