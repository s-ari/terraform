# Configure the Alicloud Provider
provider "alicloud" {
  access_key = "${lookup(var.auth, "access_key")}"
  secret_key = "${lookup(var.auth, "secret_key")}"
  region     = "${lookup(var.auth, "region")}"
}

# Create VPC Network
resource "alicloud_vpc" "vpc" {
  name       = "${var.prefix}-${lookup(var.vpc, "name")}"
  cidr_block = "${lookup(var.vpc, "cidr_block")}"
}

# Create Vswitch
resource "alicloud_vswitch" "vswitch_zone_a" {
  vpc_id            = "${alicloud_vpc.vpc.id}"
  cidr_block        = "${lookup(var.vswitch_zone_a, "cidr_block")}"
  availability_zone = "${lookup(var.vswitch_zone_a, "availability_zone")}"
  name              = "${var.prefix}-${lookup(var.vswitch_zone_a, "name")}"
}

# Create ECS
resource "alicloud_instance" "ecs" {
  count                      = "${lookup(var.ecs, "count")}"
  image_id                   = "${lookup(var.ecs, "image_id")}"
  instance_type              = "${lookup(var.ecs, "instance_type")}"
  system_disk_size           = "${lookup(var.ecs, "system_disk_size")}"
  security_groups            = ["${alicloud_security_group.sg.id}"]
  instance_name              = "${var.prefix}${lookup(var.ecs, "instance_name")}${format(count.index + 1)}"
  vswitch_id                 = "${alicloud_vswitch.vswitch_zone_a.id}"
  key_name                   = "${lookup(var.ecs, "key_name")}"
  internet_max_bandwidth_out = "${lookup(var.ecs, "internet_max_bandwidth_out")}"
}

# Create Security group
resource "alicloud_security_group" "sg" {
  name        = "${var.prefix}-${lookup(var.sg, "name")}"
  description = "${lookup(var.sg, "description")}"
  vpc_id      = "${alicloud_vpc.vpc.id}"
}

# Create Security group rule ssh
resource "alicloud_security_group_rule" "sg_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "0.0.0.0/0"
}

# Create Security group rule http
resource "alicloud_security_group_rule" "sg_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  security_group_id = "${alicloud_security_group.sg.id}"
  cidr_ip           = "${lookup(var.vpc, "cidr_block")}"
}

# Create SLB for classic
resource "alicloud_slb" "classic" {
  name                 = "${var.prefix}-${lookup(var.slb, "name")}"
  internet             = true
  internet_charge_type = "paybytraffic"
  bandwidth            = 5
}

# Attach ECS instances in SLB
resource "alicloud_slb_attachment" "slb_attach" {
  load_balancer_id = "${alicloud_slb.classic.id}"
  instance_ids     = ["${alicloud_instance.ecs.*.id}"]
}

# Create http listener
resource "alicloud_slb_listener" "http" {
  load_balancer_id          = "${alicloud_slb.classic.id}"
  backend_port              = 80
  frontend_port             = 80
  bandwidth                 = 10
  protocol                  = "http"
  health_check              = "on"
  health_check_connect_port = "80"
  health_check_type         = "http"
  health_check_uri          = "/"
}

# Create Database
resource "alicloud_db_instance" "rds" {
  engine           = "${lookup(var.rds, "engine")}"
  engine_version   = "${lookup(var.rds, "engine_version")}"
  instance_type    = "${lookup(var.rds, "instance_type")}"
  instance_storage = "${lookup(var.rds, "instance_storage")}"
  vswitch_id       = "${alicloud_vswitch.vswitch_zone_a.id}"
  security_ips     = ["${lookup(var.rds, "security_ips")}"]
}
