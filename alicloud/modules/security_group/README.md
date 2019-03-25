# Security group

## This module is to create security groups and rules.

### Set parameters

* source              
* vpc_id              
* prefix              
* name                
* description         
* rule_ssh_type       
* rule_ssh_ip_protocol
* rule_ssh_nic_type   
* rule_ssh_policy     
* rule_ssh_port_range
* rule_ssh_cidr_ip   


### Usage

```
module "security_group" {
  source               = "../modules/security_group"
  vpc_id               = "${module.vpc.vpc_id}"
  prefix               = "${var.prefix}"
  name                 = "${var.prefix}_${terraform.workspace}_sg"
  description          = "${var.prefix} security group"
  rule_ssh_type        = "ingress"
  rule_ssh_ip_protocol = "tcp"
  rule_ssh_nic_type    = "intranet"
  rule_ssh_policy      = "accept"
  rule_ssh_port_range  = "22/22"
  rule_ssh_cidr_ip     = "0.0.0.0/0"
}

```
