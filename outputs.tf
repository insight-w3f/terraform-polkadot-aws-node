output "subnet_id" {
  value = var.subnet_id
}

output "security_group_id" {
  value = var.security_group_id
}

output "instance_id" {
  value = join("", aws_instance.this.*.id)
}

output "public_ip" {
  value = join("", aws_eip.this.*.public_ip)
}

output "private_ip" {
  value = join("", aws_instance.this.*.private_ip)
}

output "user_data" {
  value = join("", aws_instance.this.*.user_data)
}

output "fqdn" {
  value = join("", aws_route53_record.this.*.fqdn)
}
