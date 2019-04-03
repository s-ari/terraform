# Create k8s Container Service
resource "alicloud_cs_kubernetes" "kubernetes" {
  name               = "${var.name}"
  vswitch_ids               = ["${var.vswitch_ids}"]
  new_nat_gateway           = "${var.new_nat_gateway}"
  master_instance_types     = ["${var.master_instance_types}"]
  worker_instance_types     = ["${var.worker_instance_types}"]
  worker_numbers            = ["${var.worker_numbers}"]
  master_disk_category      = "${var.master_disk_category}"
  master_disk_size     = "${var.master_disk_size}"
  worker_disk_size          = "${var.worker_disk_size}"
  worker_data_disk_category = "${var.worker_data_disk_category}"
  worker_data_disk_size     = "${var.worker_data_disk_size}"
  pod_cidr                  = "${var.pod_cidr}"
  service_cidr              = "${var.service_cidr}"
  enable_ssh                = "${var.enable_ssh}"
  slb_internet_enabled      = "${var.slb_internet_enabled}"
  install_cloud_monitor     = "${var.install_cloud_monitor}"
  key_name                  = "${var.key_name}"
  availability_zone         = "${var.availability_zone}"
}
