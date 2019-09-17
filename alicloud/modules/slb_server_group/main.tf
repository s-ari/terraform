# Create SLB
resource "alicloud_slb_server_group" "slb_server_group" {
  load_balancer_id = "${var.load_balancer_id}"
  name             = "${var.name}"
  servers {
    server_ids = ["${var.server_ids}"]
    port       = 80
    weight     = 100
  }
}
