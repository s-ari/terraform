# Create ECS
resource "alicloud_instance" "ecs" {
  count                      = "${var.count}"
  image_id                   = "${var.image_id}"
  instance_type              = "${var.instance_type}"
  instance_name              = "${var.instance_name}${format("%02d", count.index + 1)}"
  host_name                  = "${var.host_name}${format("%02d", count.index + 1)}"
  system_disk_size           = "${var.system_disk_category}"
  system_disk_size           = "${var.system_disk_size}"
  security_groups            = ["${var.security_groups}"]
  vswitch_id                 = "${var.vswitch_id}"
  key_name                   = "${var.key_name}"
  internet_max_bandwidth_out = "${var.internet_max_bandwidth_out}"
  user_data                  = "${var.user_data}"
}
