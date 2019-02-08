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
  name              = "${var.prefix}-${lookup(var.vswitch_zone_a, "name")}"
}

# Create Cloud Disk
resource "alicloud_disk" "ecs_disk" {
  # cn-beijing
  availability_zone = "ap-northeast-1a"
  name              = "${var.prefix}-disk"
  description       = "${var.prefix}-disk"
  category          = "cloud_ssd"
  size              = "30"

  tags {
    Name = "${var.prefix}-disk"
  }
}

resource "alicloud_disk_attachment" "ecs_disk_att" {
  disk_id     = "${alicloud_disk.ecs_disk.id}"
  instance_id = "${alicloud_instance.ecs.id}"
}

# Create ECS
resource "alicloud_instance" "ecs" {
  count                      = "${lookup(var.ecs, "count")}"
  image_id                   = "${lookup(var.ecs, "image_id")}"
  instance_type              = "${lookup(var.ecs, "instance_type")}"
  system_disk_size           = "${lookup(var.ecs, "system_disk_size")}"
  security_groups            = ["${alicloud_security_group.sg.id}"]
  instance_name              = "${var.prefix}-${lookup(var.ecs, "instance_name")}${format(count.index + 1)}"
  vswitch_id                 = "${alicloud_vswitch.vswitch_zone_a.id}"
  key_name                   = "${lookup(var.ecs, "key_name")}"
  internet_max_bandwidth_out = "${lookup(var.ecs, "internet_max_bandwidth_out")}"
}

# Create Security group
resource "alicloud_security_group" "sg" {
  name        = "${lookup(var.sg, "name")}"
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

