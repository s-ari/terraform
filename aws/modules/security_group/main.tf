resource "aws_security_group" "security_group" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.name}"
  description = "${var.description}"

  ingress {
    from_port   = "${var.from_port}"
    to_port     = "${var.to_port}"
    protocol    = "${var.protocol}"
    cidr_blocks = ["${var.cidr_block}"]
  }

  tags = {
    Name = "${var.name}"
  }
}
