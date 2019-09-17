# Create SLB
resource "alicloud_slb_listener" "slb_listener" {
  load_balancer_id  = "${var.load_balancer_id}"
  server_group_id   = "${var.server_group_id}"
  backend_port      = "${var.backend_port}"
  frontend_port     = "${var.frontend_port}"
  protocol          = "${var.protocol}"
  bandwidth         = "${var.bandwidth}"
  health_check      = "${var.health_check}"
  health_check_type = "${var.health_check_type}"
}
