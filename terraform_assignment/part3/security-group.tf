resource "aws_security_group" "alb_sg" {
    name = "${var.project_name}-alb-sg"
    vpc_id = module.vpc.vpc_id
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port =  0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


# Backend SG (Flask on port 8000)
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow inbound access to backend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow ALB to access backend"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id] # only allow ALB
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Frontend SG (Express on port 3000)
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Allow inbound access to frontend"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow ALB or public to access frontend"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # or restrict to ALB SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}