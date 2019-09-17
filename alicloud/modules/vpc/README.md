# VPC

## This module is to create a vpc.

### Set parameters

* name
* description
* cidr_block

```
module "vpc" {
  source = "../modules/vpc"
  name        = "${var.prefix}_${terraform.workspace}_vpc"
  description = "${var.prefix} vpc"
  cidr_block  = "192.168.0.0/16"
}
```
