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
    count            = "2"
    image_id         = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"
    instance_type    = "ecs.t5-lc2m1.nano"
    system_disk_size = "40"

    # Set your ssh key
    key_name                   = ""
    instance_name              = "ecs"
    internet_max_bandwidth_out = "5"
  }
}

variable "sg" {
  type = "map"

  default = {
    name        = "sg"
    description = "This security group is for staging."
  }
}

variable "slb" {
  type = "map"

  default = {
    name = "slb"
  }
}

variable "rds" {
  type = "map"

  default = {
    engine           = "MySQL"
    engine_version   = "5.6"
    instance_type    = "rds.mysql.t1.small"
    instance_storage = "10"
    security_ips     = "10.0.0.0/16"
  }
}

