# Create SLB
resource "alicloud_slb" "slb" {
  name          = "${var.name}"
  specification = "${var.specification}"
  vswitch_id    = "${var.vswitch_id}"
  internet      = "${var.internet}"
}
