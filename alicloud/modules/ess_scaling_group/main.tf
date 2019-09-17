# Create Scaling Group
resource "alicloud_ess_scaling_group" "ess_scaling_group" {
  scaling_group_name = "${var.scaling_group_name}"
  min_size           = "${var.min_size}"
  max_size           = "${var.max_size}"
  default_cooldown   = "${var.default_cooldown}"
  vswitch_ids        = ["${var.vswitch_ids}"]
  loadbalancer_ids   = ["${var.loadbalancer_ids}"]
  removal_policies   = ["${var.removal_policies}"]
}
