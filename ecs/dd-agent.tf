resource "aws_ecs_task_definition" "dd-agent-task-definition" {
  family                = "dd-agent"
  container_definitions = file("templates/dd-agent1.json.tpl")

  volume{
      name = "docker_sock"
      host_path = "/var/run/docker.sock"
    }
  volume{
      name = "proc"
      host_path = "/proc/"
    }
  volume{
      name = "cgroup"
      host_path = "/cgroup/"
    }
}

resource "aws_ecs_service" "dd-agent-service" {
  name            = "dd-agent"
  cluster         = aws_ecs_cluster.example-cluster.id
  task_definition = aws_ecs_task_definition.dd-agent-task-definition.arn
  desired_count   = 1
  depends_on      = [aws_iam_policy_attachment.ecs-service-attach1]


  lifecycle {
    ignore_changes = [task_definition]
  }
}