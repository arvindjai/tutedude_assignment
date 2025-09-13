output "BACKEND_URL" {
  value = "http://${aws_lb.alb.dns_name}/api"
}

