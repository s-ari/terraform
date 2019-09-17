# Security group

## This module is to create security groups and rules.

### Set parameters

* source              
* vpc_id              
* name                
* description         
* type       
* ip_protocol
* nic_type   
* policy     
* port_range
* cidr_ip   


### Usage

```
module "security_group" {
  source      = "../modules/security_group"
  type        = "ingress"
  ip_protocol = "tcp"
  nic_type    = "intranet"
  policy      = "accept"
  port_range  = "22/22"
  cidr_ip     = "0.0.0.0/0"
}

```
