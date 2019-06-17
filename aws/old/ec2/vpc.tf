variable "vpc_cidr_block" {}
variable "vpc_subnet_cidr_block" {}
variable "vpc_tag" {}
variable "vpc_subnet_tag" {}
variable "vpc_gateway_tag" {}
variable "vpc_route_table_tag" {}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = "true"
  tags {
    Name = "${var.vpc_tag}"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.vpc_subnet_cidr_block}"
  tags {
    Name = "${var.vpc_subnet_tag}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.vpc_gateway_tag}"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags {
    Name = "${var.vpc_route_table_tag}"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}
