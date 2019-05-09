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

module "kubernetes" {
  source                    = "../modules/kubernetes"
  name                      = "${var.prefix}-${terraform.workspace}-kubernetes"
  vswitch_ids               = "${module.vswitch_az_a.vswitch_id}"
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
