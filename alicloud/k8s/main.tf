# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${lookup(var.auth, "access_key")}"
  secret_key = "${lookup(var.auth, "secret_key")}"
  region     = "${lookup(var.auth, "region")}"
}

# Create VPC Network
resource "alicloud_vpc" "vpc" {
  name       = "${var.prefix}${lookup(var.vpc, "name")}"
  cidr_block = "${lookup(var.vpc, "cidr_block")}"
}

# Create Vswitch
resource "alicloud_vswitch" "vswitch_zone_a" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "${lookup(var.vswitch_zone_a, "cidr_block")}"
  availability_zone = "${lookup(var.vswitch_zone_a, "availability_zone")}"
  name              = "${var.prefix}${lookup(var.vswitch_zone_a, "name")}"
}

# Create k8s Container Service
resource "alicloud_cs_kubernetes" "main" {
  name_prefix           = "${var.prefix}k8s"
  availability_zone     = "${lookup(var.vswitch_zone_a, "availability_zone")}"
  new_nat_gateway       = true
  master_instance_types  = ["${lookup(var.k8s, "master_instance_type")}"]
  worker_instance_types  = ["${lookup(var.k8s, "worker_instance_type")}"]
  worker_numbers         = ["${lookup(var.k8s, "worker_number")}"]
  vswitch_ids            = ["${alicloud_vswitch.vswitch_zone_a.id}"]
  password              = "${lookup(var.k8s, "password")}"
  pod_cidr              = "${lookup(var.k8s, "pod_cidr")}"
  service_cidr          = "${lookup(var.k8s, "service_cidr")}"
  enable_ssh            = true
  install_cloud_monitor = true
}
