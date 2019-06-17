resource "aws_vpc" "vpc" {
  tags {
    Name = "${lookup(var.tag, "vpc")}"
  }

  cidr_block = "${var.vpc_cidr_block}"
}

resource "aws_subnet" "subnet" {
  tags {
    Name = "${lookup(var.tag, "subnet")}"
  }

  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet_cidr_block}"
}

resource "aws_internet_gateway" "gw" {
  tags {
    Name = "${lookup(var.tag, "gateway")}"
  }

  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table" "route_table" {
  tags {
    Name = "${lookup(var.tag, "route_table")}"
  }

  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.route_table.id}"
}
