# Part 1: Deploy Both Flask and Express on a Single EC2 Instance

resource "aws_instance" "ec2" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
        "assignment" = "Terraform"
        Name = var.instance_name
    }

}

resource "null_resource" "copy_file" {
  depends_on = [aws_instance.ec2]

  connection {
      type        = "ssh"
      user        = "ubuntu"               # or ec2-user
      private_key = file("~/.ssh/aws-tutedude.pem")
      host        = aws_instance.ec2.public_ip
    }

  provisioner "file" {
    source      = "./user_script.sh"
    destination = "/home/ubuntu/user_script_on_ec2.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /home/ubuntu/user_script_on_ec2.sh",
        "sudo bash  /home/ubuntu/user_script_on_ec2.sh"
    ]
  }

  triggers = {
    always_run = timestamp()  # forces re-run on each `apply`
  }
}
