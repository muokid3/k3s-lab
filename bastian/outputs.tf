output "bastian_sg_id" {
  value = aws_security_group.bastian.id
}

output "bastian_ip" {
  value = aws_instance.bastian.public_ip
}

output "bastian" {
  value = format("%s (%s)", aws_instance.bastian.public_dns, aws_instance.bastian.public_ip)
}

