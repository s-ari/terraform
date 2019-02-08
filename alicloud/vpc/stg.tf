variable "prefix" {
  default = ""
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

