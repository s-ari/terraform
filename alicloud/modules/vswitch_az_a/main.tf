# Create Vswitch Zone A
resource "alicloud_vswitch" "vswitch_zone_a" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.vswitch_a_cidr_block}"
  availability_zone = "${var.vswitch_availability_zone_a}"
  name              = "${var.vswitch_a_name}"
  description       = "${var.vswitch_a_description}"
}