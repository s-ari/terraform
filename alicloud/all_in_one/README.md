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

# slb
name                       = "" - Set slb name.

# rds
engine                     = "" - Set database engine name.
engine_version             = "" - Set database engin version.
instance_type              = "" - Set database instance type.
instance_storage           = "" - Set instance disk size.
security_ips               = "" - Set permit ip address.


```

* Run terraform commands.

```
export TF_VAR_auth='{access_key = "YOUR_ACCESS_KEY_ID", secret_key = "YOUR_SECRET_KEY_ID"}'
export TF_VAR_ecs='{key_name = "SSHE_KEY_NAME"}'
export TF_VAR_prefix='PREFIX'

terraform plan
terraform apply
```
