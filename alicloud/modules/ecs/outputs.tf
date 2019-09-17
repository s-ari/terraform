output "instance_id" {
  value = ["${alicloud_instance.ecs.*.id}"]
}
