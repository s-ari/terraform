resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${lookup(var.tag, "ecs_cluster")}"
}
