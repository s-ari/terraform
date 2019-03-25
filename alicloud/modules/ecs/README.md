# ECS

## This module is to create ECS instances.

### Set parameters

* source
* description
* vswitch_id
* security_groups
* count
* image_id
* instance_type
* system_disk_size
* instance_name
* host_name
* internet_max_bandwidth_out
* key_name


### Usage

```
module "ecs" {
  source                     = "../modules/ecs"
  description                = "${var.prefix} ecs"
  vswitch_id                 = "${module.vswitch.vswitch_zone_a_id}"
  security_groups            = "${module.security_group.security_group_id}"
  count                      = "2"
  image_id                   = "ubuntu_16_0402_64_20G_alibase_20180409.vhd"
  instance_type              = "ecs.t5-lc2m1.nano"
  system_disk_size           = "40"
  instance_name              = "${var.prefix}_${terraform.workspace}_ecs"
  host_name                  = "${var.prefix}-${terraform.workspace}-ecs"
  internet_max_bandwidth_out = "100"
  key_name                   = "${var.ssh_key}"
}
```
