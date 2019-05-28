# RDS

## This module is to create a rds instance.

### Set parameters

* prefix
* instance_name
* engine
* engine_version
* instance_type
* instance_storage
* vswitch_id

```
module "rds" {
  source           = "../modules/rds"
  instance_name    = "${var.prefix}-${terraform.workspace}-rds"
  engine           = "MySQL"
  engine_version   = "5.6"
  instance_type    = "rds.mysql.t1.small"
  instance_storage = "5"
  vswitch_id       = "${module.vswitch_az_a.vswitch_id}"
}
```
