output "Frontend_public_dns" {
  value = aws_instance.instance_b.public_dns
}


output "Backend_public_dns" {
  value = aws_instance.instance_a.public_dns
}

output "Backend_URL" {
  value = "http://${aws_instance.instance_a.public_ip}:8000"
}

output "Frontend_URL" {
  value = "http://${aws_instance.instance_b.public_ip}:3000"
}
