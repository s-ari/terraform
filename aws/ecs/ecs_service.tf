resource "aws_ecs_service" "ecs_service" {
  name            = "ecs_service"
  cluster         = "${aws_ecs_cluster.ecs_cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count   = 1 
}
