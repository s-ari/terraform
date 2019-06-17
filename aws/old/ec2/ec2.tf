variable "ec2_region" {}
variable "ec2_ami_id" {}
variable "ec2_instance_type" {}
variable "ec2_count" {}
variable "ec2_instance_key_name" {}
variable "ec2_tag" {}
variable "ansible_ssh_key" {} 
variable "ansible_ssh_user" {}
variable "ansible_playbook" {}

provider "aws" {
  region = "${var.ec2_region}"
}

resource "aws_instance" "instance" {
  ami                         = "${var.ec2_ami_id}"
  instance_type               = "${var.ec2_instance_type}"
  key_name                    = "${var.ec2_instance_key_name}"
  vpc_security_group_ids      = ["${aws_security_group.sec_group.id}"]
  subnet_id                   = "${aws_subnet.subnet.id}"
  associate_public_ip_address = "true"
  count                       = "${var.ec2_count}"
  tags {
    Name = "${format("${var.ec2_tag}%02d", count.index + 1)}"
  }
  provisioner "remote-exec" {
    connection {
    type        = "ssh"
    user        = "${var.ansible_ssh_user}"
    private_key = "${file(var.ansible_ssh_key)}"
    }
  }
}

resource "null_resource" "instance_provisioning" {
  triggers {
    instance_ids = "${join(",", aws_instance.instance.*.id)}"
  }
  provisioner "local-exec" {
    command = "../ansible/ansible.sh ${join(",", aws_instance.instance.*.public_ip)}, ${var.ansible_ssh_key} ${var.ansible_ssh_user} ${var.ansible_playbook}"
  }
}
