resource "aws_ecs_cluster" "cluster" {
    name = "${var.project_name}-cluster"
}


resource "aws_cloudwatch_log_group" "ecs" {
    name = "/ecs/${var.project_name}"
    retention_in_days = 14
}