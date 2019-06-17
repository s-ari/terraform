provider "aws" {
    region = "ap-northeast-1"
}

variable "vpc_cidr_block" {
  default = ""
}

variable "subnet_cidr_block" {
  default = ""
}

variable "instance_key_name" {
  default = ""
}

variable "ami_id" {
  default = ""
}

variable "tag" {
  type = "map"
  default = {
    ec2            = ""
    vpc            = ""
    subnet         = ""
    gateway        = ""
    route_table    = ""
    security_group = ""
    ecs_cluster    = ""
    ecs_task       = ""
  }
}
