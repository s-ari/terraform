# Vswitch AZ B

## This module is to create vswitches.

### Set parameters

* source
* vpc_id
* prefix
* vswitch_b_cidr_block
* vswitch_b_name
* vswitch_b_description
* vswitch_availability_zone_b


### Usage

```
module "vswitch" {
  source = "../modules/vswitch"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "${var.prefix}"

  vswitch_b_cidr_block        = "192.168.2.0/24"
  vswitch_b_name              = "${var.prefix}_${terraform.workspace}_vswitch_az_b"
  vswitch_b_description       = "${var.prefix} vswitch_az_b"
  vswitch_availability_zone_b = "ap-northeast-1b"
}

```
