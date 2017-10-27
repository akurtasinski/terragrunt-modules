resource "aws_ecs_task_definition" "ecs_task" {
  family = "${var.environment_name}_td"
  task_role_arn = "${aws_iam_role.ecs_taskrole.arn}"
  depends_on = ["aws_iam_role.ecs_taskrole"]
  container_definitions = <<DEFINITION
[
  {
    "cpu": "${var.cpuReservation}",
    "environment": ${var.envars},
    "essential": true,
    "image": "${var.docker_image_name}",
    "memoryReservation": "${var.memoryReservation}",
    "name": "${var.environment_name}",
    "portMappings": [{
      "hostPort": 0,
      "containerPort": "${var.container_port}",
      "protocol": "tcp"
    }],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
          "awslogs-group": "${var.log_group_name}",
          "awslogs-region": "${var.aws_region}",
          "awslogs-stream-prefix": "${var.environment_name}"
      }
    }
  }
]
DEFINITION

}

resource "aws_ecs_service" "ecs_service" {
  name = "${var.environment_name}_service"
  cluster = "${var.ecs_cluster_id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count = "${var.desired_count}"
  iam_role = "${aws_iam_role.ecs_servicerole.arn}"
  depends_on= ["aws_iam_role.ecs_servicerole"]

  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name = "${var.environment_name}"
    container_port = "${var.container_port}"
  }
}
