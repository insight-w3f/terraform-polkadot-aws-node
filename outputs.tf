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

output "reader_aws_access_key_id" {
  value = join("", aws_iam_access_key.reader.*.id)
  sensitive = true
}

output "reader_aws_secret_access_key" {
  value = join("", aws_iam_access_key.reader.*.secret)
  sensitive = true
}

output "sync_bucket_uri" {
  value = join("", aws_s3_bucket.sync.*.bucket_domain_name)
  sensitive = true
}