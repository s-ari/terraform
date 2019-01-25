variable "prefix" {
  default = "stg-"
}

variable "auth" {
  type = "map"

  default = {
    # Set your access key
    access_key = ""
    secret_key = ""
    region     = "ap-northeast-1"
  }
}

variable "vpc" {
  type = "map"

  default = {
    name       = "vpc"
    cidr_block = "10.0.0.0/16"
  }
}

variable "vswitch_zone_a" {
  type = "map"

  default = {
    availability_zone = "ap-northeast-1a"
    cidr_block        = "10.0.1.0/24"
    name              = "vswitch_a"
  }
}

variable "ecs" {
  type = "map"

  default = {
    count            = "1"
    #image_id         = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"
    image_id         = "centos_6_09_64_20G_alibase_20180326.vhd"
    instance_type    = "ecs.sn2.large"
    system_disk_size = "40"

    # Set your ssh key
    key_name                   = ""
    instance_name              = "ecs"
    internet_max_bandwidth_out = "100"
  }
}

variable "sg" {
  type = "map"

  default = {
    name        = "sg"
    description = "This security group is for staging."
  }
}

