# SLB 

## This module is to create a slb.

### Set parameters

* name
* specification
* vswitch_id
```
module "slb" {
  source        = "../modules/slb"
  name          = "${var.prefix}_${terraform.workspace}_slb"
  specification = "slb.s2.small"
  vswitch_id    = "${module.vswitch_az_a.vswitch_id}"
}
```
