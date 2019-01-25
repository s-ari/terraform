variable "os_user" {}
variable "os_tenant" {}
variable "os_pass" {}

variable "os" {
  default = {
    auth_url        = ""
    instance_name   = ""
    image_id        = ""
    flavor_id       = ""
    key             = ""
    floatingip_pool = ""
    sec_allow_host  = ""
    instance_count  = ""
  }
}
