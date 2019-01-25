# Terraform v0.11.7

## Crate Alicloud Resources

* Set up resources.
  * VPC
  * VSwitch
  * Security group
  * CS(Container Servic)

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

# container service
master_instance_type       = "" - Set instance type for three k8s masters.
worker_instance_type       = "" - Set instance type for worker.
worker_number              = "" - Set instance count.
password                   = "" - Set k8s dashboard password.
pod_cidr                   = "" - Set k8s pod cidr.
service_cidr               = "" - Set k8s service cidr.

```

* Run terraform commands.

```
terraform plan
terraform apply
```
