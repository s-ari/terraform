resource "aws_instance" "instance" {
  tags {
    Name = "${lookup(var.tag, "ec2")}"
  }

  ami                         = "${var.ami_id}"
  instance_type               = "t2.micro"
  key_name                    = "${var.instance_key_name}"
  iam_instance_profile        = "${aws_iam_instance_profile.ecs_profile.name}"
  vpc_security_group_ids      = ["${aws_security_group.sec_group.id}"]
  subnet_id                   = "${aws_subnet.subnet.id}"
  associate_public_ip_address = "true"
  user_data                   = "${file("user_data/ecs_config.sh")}"
}
