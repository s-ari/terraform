# Create Vswitch
resource "alicloud_vswitch" "vswitch" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.vswitch_cidr_block}"
  availability_zone = "${var.vswitch_availability_zone}"
  name              = "${var.vswitch_name}"
  description       = "${var.vswitch_description}"
}
