variable "elb_tag" {}

resource "aws_elb" "elb" {
  name = "${var.elb_tag}"
  subnets = [
    "${aws_subnet.subnet.id}"
  ]

#  access_logs {
#    bucket        = "elb"
#    bucket_prefix = ""
#    interval      = 60
#  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = ["${aws_instance.instance.*.id}"]
  security_groups             = ["${aws_security_group.sec_group.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "${var.elb_tag}"
  }
}
