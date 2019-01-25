provider "openstack" {
    user_name   = "${var.os_user}"
    tenant_name = "${var.os_tenant}"
    password    = "${var.os_pass}"
    auth_url    = "${var.os.auth_url}"
    endpoint_type   = "internal"
}

resource "openstack_networking_network_v2" "test_network" {
  name = "${var.os.instance_name}_network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "test_subnet" {
  name = "${var.os.instance_name}_subnet"
  network_id = "${openstack_networking_network_v2.test_network.id}"
  cidr = "192.168.0.0/24"
  ip_version = 4
  dns_nameservers = ["8.8.8.8"]
}

resource "openstack_networking_router_v2" "test_router" {
  name = "${var.os.instance_name}_router"
  external_gateway = "${var.os.floatingip_pool}"
}

resource "openstack_networking_router_interface_v2" "test_router_interface" {
  router_id = "${openstack_networking_router_v2.test_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.test_subnet.id}"
}

resource "openstack_compute_floatingip_v2" "test_floatip" {
  count = "${var.os.instance_count}"
  pool  = "${var.os.floatingip_pool}"
}

resource "openstack_compute_secgroup_v2" "test_secgroup" {
  name = "${var.os.instance_name}_sec"
  description = "${var.os.instance_name}_sec"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "${var.os.sec_allow_host}"
  }
}

#resource "openstack_blockstorage_volume_v1" "test_vol" {
#  name = "${var.os.instance_name}_vol"
#  description = "${var.os.instance_name}_vol"
#  size = 1
#}

resource "openstack_compute_instance_v2" "test_instance" {
  count           = "${var.os.instance_count}"
  name            = "${var.os.instance_name}${count.index}"
  image_id        = "${var.os.image_id}"
  flavor_id       = "${var.os.flavor_id}"
  key_pair        = "${var.os.key}"
  security_groups = ["${openstack_compute_secgroup_v2.test_secgroup.name}"]
  network {
    uuid = "${openstack_networking_network_v2.test_network.id}"
  }
  floating_ip     = "${element(openstack_compute_floatingip_v2.test_floatip.*.address, count.index)}"
#  volume {
#    volume_id = "${openstack_blockstorage_volume_v1.test_vol.id}"
#  }
}

#resource "openstack_objectstorage_container_v1" "test_container" {
#  name = "${var.os.instance_name}_container"
#}
