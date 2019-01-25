resource "aws_ecs_task_definition" "ecs_task" {
  family                = "${lookup(var.tag, "ecs_task")}"
  container_definitions = "${file("ecs_files/service.json")}"
}
