provider "google" {
  credentials = "${file("${var.account_json}")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

resource "google_compute_instance" "default" {
  name               = "${var.instance_name}"
  zone               = "${var.zone}"
  machine_type       = "${var.machine_type}"

  boot_disk {
    initialize_params {
      image = "${var.image_name}"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata {
    block-project-ssh-keys = "true"
    ssh-keys = "key name:ssh public key \n"
  }
}
