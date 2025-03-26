# ecs/service.tf
resource "aws_ecs_cluster" "main" {
  name = "production-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  
  container_definitions = jsonencode([{
    name      = "app-container"
    image     = "${var.docker_image}:${var.image_tag}"
    cpu       = 1024
    memory    = 2048
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    
    environment = [
      { name = "DB_HOST", value = aws_db_instance.main.endpoint },
      { name = "DB_NAME", value = var.db_name }
    ]
  }])
}
