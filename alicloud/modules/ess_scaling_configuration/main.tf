# Create Scaling Configration
resource "alicloud_ess_scaling_configuration" "ess_scaling_configuration" {
  scaling_configuration_name = "${var.scaling_configuration_name}"
  scaling_group_id           = "${var.scaling_group_id}"
  image_id                   = "${var.image_id}"
  instance_type              = "${var.instance_type}"
  instance_name              = "${var.instance_name}"
  internet_charge_type       = "${var.internet_charge_type}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
  system_disk_category       = "${var.system_disk_category}"
  system_disk_size           = "${var.system_disk_size}"
  key_name                   = "${var.key_name}"
  security_group_id          = "${var.security_group_id}"
  force_delete               = "${var.force_delete}"
  user_data                  = "${var.user_data}"
}
