# Create Security group
resource "alicloud_security_group" "security_group" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"
}

# Create Security group rule ssh
resource "alicloud_security_group_rule" "rule_ssh" {
  type              = "${var.rule_ssh_type}"
  ip_protocol       = "${var.rule_ssh_ip_protocol}"
  nic_type          = "${var.rule_ssh_nic_type}"
  policy            = "${var.rule_ssh_policy}"
  port_range        = "${var.rule_ssh_port_range}"
  security_group_id = "${alicloud_security_group.security_group.id}"
  cidr_ip           = "${var.rule_ssh_cidr_ip}"
}
