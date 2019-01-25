# Terraform 0.9.3

## GKE Cluster

* Set parameters.
  * Account auth json file
  * Project ID
  * Region
  * Zone (Do not include a zone No)
  * Cluster name
  * WEB UI login user name / password
  * Machine type / Disk size

```
variable "account_json" {
    default = ""
}

variable "project" {
  default = ""
}

variable "region" {
  default = ""
}

variable "zone" {
  default = ""
}

variable "cluster_name" {
  default = ""
}

variable "auth_uer" {
  default = ""
}

variable "auth_password" {
  default = ""
}

variable "machine_type" {
  default = ""
}

variable "disk_size" {
  default = ""
}
```

* When deploy a machine to a multi zone uncomment it's 

```
#  additional_zones = [
#    "${var.zone}-b",
#    "${var.zone}-c",
#  ]`
```

* Apply terraform

```
terraform plan
terraform apply
```
