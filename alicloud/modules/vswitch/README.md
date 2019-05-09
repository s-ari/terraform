# Vswitch AZ A

## This module is to create vswitches.

### Set parameters

* source
* vpc_id
* prefix
* vswitch_a_cidr_block
* vswitch_a_name
* vswitch_a_description
* vswitch_availability_zone


### Usage

```
module "vswitch" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_a_cidr_block        = "192.168.1.0/24"
  vswitch_a_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_a"
  vswitch_a_description       = "${var.prefix} vswitch_az_a"
  vswitch_availability_zone   = "ap-northeast-1a"
}

```
