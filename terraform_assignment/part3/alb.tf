resource "aws_lb" "alb" {
    name = "${var.project_name}-alb"
    security_groups = [aws_security_group.alb_sg.id]
    load_balancer_type = "application"
    subnets = module.vpc.public_subnets
}

resource "aws_lb_target_group" "frontend_tg" {
  name     = "${var.project_name}-frontend-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  
  health_check {
    path     = "/"
    interval = 30
    matcher  = "200-399"
    }
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.project_name}-backend-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  
  health_check {
    path     = "/"
    interval = 30
    matcher  = "200-399"
    }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}