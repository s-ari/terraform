# Create Security group rule
resource "alicloud_security_group_rule" "security_group_rule" {
  type              = "${var.type}"
  ip_protocol       = "${var.ip_protocol}"
  nic_type          = "${var.nic_type}"
  policy            = "${var.policy}"
  port_range        = "${var.port_range}"
  security_group_id = "${var.security_group_id}"
  cidr_ip           = "${var.cidr_ip}"
}
