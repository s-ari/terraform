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

module "vswitch" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_a_cidr_block        = "192.168.1.0/24"
  vswitch_a_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_a_description       = "${var.prefix} vswitch_az_a"
  vswitch_availability_zone_a = "ap-northeast-1a"

#  vswitch_b_cidr_block        = "192.168.2.0/24"
#  vswitch_b_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_b"
#  vswitch_b_description       = "${var.prefix} vswitch_az_b"
#  vswitch_availability_zone_b = "ap-northeast-1b"

#  vswitch_b_cidr_block  = "192.168.3.0/24"
##  vswitch_b_name        = "${var.prefix}_${terraform.workspace}_vswitch_az_b2"
#  vswitch_b_description = "${var.prefix} vswitch_az_b2"
}

module "kubernetes" {
  source                    = "../modules/kubernetes"
  name                      = "${var.prefix}-${terraform.workspace}-kubernetes"
  vswitch_ids               = "${module.vswitch.vswitch_zone_a_id}"
  new_nat_gateway           = "true"
  master_instance_types     = "ecs.t5-lc1m2.large"
  worker_instance_types     = "ecs.t5-c1m4.xlarge"
  worker_numbers            = "2"
  master_disk_category      = "cloud_efficiency"
  master_disk_size          = "40"
  worker_disk_size          = "30"
  worker_data_disk_category = "cloud_ssd"
  worker_data_disk_size     = "30"
  pod_cidr                  = "10.0.0.0/8"
  service_cidr              = "172.16.0.0/24"
  enable_ssh                = "true"
  slb_internet_enabled      = "true"
  install_cloud_monitor     = "true"
  key_name                  = "${var.ssh_key}"
  availability_zone         = "ap-northeast-1a"
}
