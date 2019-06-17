resource "aws_security_group" "sec_group" {
  tags {
  Name = "${lookup(var.tag, "security_group")}"
  }

  name        = "sec_group"
  description = "Allow ssh inbound traffic from office network"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["202.143.66.52/32"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["219.166.46.195/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
