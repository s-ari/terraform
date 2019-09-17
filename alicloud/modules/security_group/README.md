# Security group

## This module is to create security groups and rules.

### Set parameters

* source              
* vpc_id              
* name                
* description         

### Usage

```
module "security_group" {
  source               = "../modules/security_group"
  vpc_id               = "${module.vpc.vpc_id}"
  name                 = "${var.prefix}_${terraform.workspace}_sg"
  description          = "${var.prefix} security group"
}

```
