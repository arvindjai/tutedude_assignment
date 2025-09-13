# Part 2: Deploy Flask and Express on Separate EC2 Instances

resource "aws_security_group" "sg_a" {
    name = "Instance-a-sg"
    description = "Security group for Instance A"
    vpc_id = var.vpc
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "sg_b" {
    name = "Instance-b-sg"
    description = "Security group for Instance B"
    vpc_id = var.vpc
    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "a_to_b" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = aws_security_group.sg_a.id
    security_group_id = aws_security_group.sg_b.id
}

resource "aws_security_group_rule" "b_to_a" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    source_security_group_id = aws_security_group.sg_b.id
    security_group_id = aws_security_group.sg_a.id
}



resource "aws_instance" "instance_a" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        Name = "Backend"
        # Backend Instance
        "app" = "Backend"
        "Assignment" = "Terraform-part-2"
    }
    security_groups = [aws_security_group.sg_a.name]


    connection {
    type        = "ssh"
    user        = "ubuntu"               # or ec2-user
    private_key = file("~/.ssh/aws-tutedude.pem")
    host        = aws_instance.instance_a.public_ip
    }

    provisioner "file" {
        source      = "./user_script_a.sh"
        destination = "/home/ubuntu/user_script_backend.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/user_script_backend.sh",
      "bash /home/ubuntu/user_script_backend.sh"
    ]
  }
        

}

resource "aws_instance" "instance_b" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        # Frontend Instance
        Name = "Frontend"
        "Assignment" = "Terraform-part-2"
        "app" = "Frontend"
    }
    security_groups = [aws_security_group.sg_b.name]

    connection {
    type        = "ssh"
    user        = "ubuntu"               # or ec2-user
    private_key = file("~/.ssh/aws-tutedude.pem")
    host        = aws_instance.instance_b.public_ip
    }

    provisioner "file" {
        content     = templatefile("${path.module}/user_script_b.sh.tpl", {
            backend_ip = aws_instance.instance_a.public_ip
            })
        destination = "/home/ubuntu/user_script_frontend.sh"
    }
    provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/user_script_frontend.sh",
      "bash /home/ubuntu/user_script_frontend.sh"
    ]
  }

}
