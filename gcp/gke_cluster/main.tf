provider "google" {
  credentials = "${file("${var.account_json}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_container_cluster" "cluster" {
  name               = "${var.cluster_name}"
  zone               = "${var.zone}-a"
  initial_node_count = 1

#  additional_zones = [
#    "${var.zone}-b",
#    "${var.zone}-c",
#  ]

  master_auth {
    username = "${var.auth_uer}"
    password = "${var.auth_password}"
  }

  node_config {
    machine_type = "${var.machine_type}"
    disk_size_gb = "${var.disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}
