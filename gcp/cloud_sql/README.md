# Terraform 0.9.3

## Coud SQL

* Set parameters.
  * Account auth json file
  * Project ID
  * Region
  * Database name / Version
  * Machine type
  * Permit IP
  * Root password

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

variable "database_name" {
  default = ""
}

variable "database_version" {
  default = "MYSQL_5_7"
}

variable "tier_type" {
  default = ""
}

variable "allow_host01" {
  default = ""
}

variable "allow_host02" {
  default = ""
}

variable "allow_host03" {
  default = ""
}

variable "root_password" {
  default = ""
}
```

* Apply terraform

```
terraform plan
terraform apply
```
