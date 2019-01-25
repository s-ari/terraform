# Terraform v0.11.7

## Crate Alicloud Resources

* Set up resources.
  * VPC
  * VSwitch
  * Security group
  * ECS
  * SLB
  * RDS

* Edit perameters of stg.tf file.

```
# prefix
prefix                     = "" - Set common prefix.

# auth
access_key                 = "" - Set access key name.
secret_key                 = "" - Set secret key name.
region                     = "" - Jpan region name is ap-northeast-1.

# vpc
name                       = "" - Set vpc name.
cidr_block                 = "" - set vpc cider.

# vswitch
availability_zone          = "" - Set availability_zone(ap-northeast-1a).
cidr_block                 = "" - Set subnet cider.
name                       = "" - Set vswitch name.

# ecs
count                      = "" - Set ecs count.
image_id                   = "" - Set image id.
instance_type              = "" - Set instance type.
system_disk_size           = "" - Set intance disk size.
key_name                   = "" - Set used ssh key.
instance_name              = "" - SSH login user.
internet_max_bandwidth_out = "" - Set network bandwidth.

```

* Run terraform commands.

```
terraform plan
terraform apply
```
