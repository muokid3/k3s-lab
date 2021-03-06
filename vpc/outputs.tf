output "zone" {
  value = aws_route53_zone.zone
}

output "az" {
  value = data.aws_availability_zones.azs.names
}

output "id" {
  value = aws_vpc.k3s_lab
}

