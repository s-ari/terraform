# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${lookup(var.auth, "access_key")}"
  secret_key = "${lookup(var.auth, "secret_key")}"
  region     = "${lookup(var.auth, "region")}"
}

# Create VPC Network
resource "alicloud_vpc" "vpc" {
  name       = "${var.prefix}${lookup(var.vpc, "name")}"
  cidr_block = "${lookup(var.vpc, "cidr_block")}"
}

# Create Vswitch
resource "alicloud_vswitch" "vswitch_zone_a" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "${lookup(var.vswitch_zone_a, "cidr_block")}"
  availability_zone = "${lookup(var.vswitch_zone_a, "availability_zone")}"
  name              = "${var.prefix}${lookup(var.vswitch_zone_a, "name")}"
}
