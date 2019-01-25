provider "google" {
  credentials = "${file("${var.account_json}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_sql_database_instance" "db" {
  name             = "${var.database_name}"
  region           = "${var.region}"
  database_version = "${var.database_version}"
  
  settings {
    tier      = "${var.tier_type}"
    disk_size = "20"
    disk_type = "PD_SSD"
    ip_configuration = { 
      authorized_networks = {
        name  = "gke node01"
        value = "${var.allow_host01}"
      } 
      authorized_networks = {
        name  = "gke node02"
        value = "${var.allow_host02}"
      }
      authorized_networks = {
        name  = "gke node03"
        value = "${var.allow_host03}"
      }
    }
  }
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = "${google_sql_database_instance.db.name}"
  host     = "%"
  password = "${var.root_password}"
}
