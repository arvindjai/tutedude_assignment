output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}
 output "Frontend_URL" {
    value = "http://${aws_instance.ec2.public_ip}:3000"
 }

  output "Backend_URL" {
    value = "http://${aws_instance.ec2.public_ip}:8000"
 }