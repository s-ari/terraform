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

variable "k8s" {
  type = "map"

  default = {
    master_instance_type = "ecs.t5-lc1m2.large"
    worker_instance_type = "ecs.t5-lc1m2.small"
    worker_number        = "1"
    password             = ""
    pod_cidr             = "172.16.0.0/16"
    service_cidr         = "172.19.0.0/20"
  }
}
