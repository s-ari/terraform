variable "security_group_tag" {}
variable "security_allow_ip_01" {}
variable "security_allow_ip_02" {}
variable "security_allow_ip_03" {}
variable "security_allow_ip_04" {}

resource "aws_security_group" "sec_group" {
  tags {
  Name = "${var.security_group_tag}"
  }

  name        = "sec_group"
  description = "Allow ssh inbound traffic from office network"
  vpc_id      = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.security_allow_ip_01}"]
  }

  ingress {
    from_port   = 22 
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.security_allow_ip_02}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.security_allow_ip_03}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.security_allow_ip_04}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
