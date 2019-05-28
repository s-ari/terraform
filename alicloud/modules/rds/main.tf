# Create RDS
resource "alicloud_db_instance" "rds" {
  instance_name    = "${var.instance_name}"
  engine           = "${var.engine}"
  engine_version   = "${var.engine_version}"
  instance_type    = "${var.instance_type}"
  instance_storage = "${var.instance_storage}"
  vswitch_id       = "${var.vswitch_id}"
}
