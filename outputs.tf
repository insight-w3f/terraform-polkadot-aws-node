output "subnet_id" {
  value = var.subnet_id
}

output "security_group_id" {
  value = var.security_group_id
}

output "instance_id" {
  value = aws_instance.this.*.id[0]
}

output "public_ip" {
  value = aws_eip.this[0].public_ip
}

output "private_ip" {
  value = aws_instance.this.*.private_ip[0]
}

output "user_data" {
  value = aws_instance.this.*.user_data[0]
}
