# Security group

## This module is to create security groups and rules.

### Set parameters

* source              
* vpc_id              
* prefix              
* name                
* description         

### Usage

```
module "security_group" {
  source               = "../modules/security_group"
  vpc_id               = "${module.vpc.vpc_id}"
  prefix               = "${var.prefix}"
  name                 = "${var.prefix}_${terraform.workspace}_sg"
  description          = "${var.prefix} security group"
}

```
