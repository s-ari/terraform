# Create VPC Network
resource "alicloud_vpc" "vpc" {
  name       = "${var.name}"
  cidr_block = "${var.cidr_block}"
  description = "${var.description}"
}
