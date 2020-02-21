resource "random_pet" "this" {}

locals {
  subnet_id           = concat([var.subnet_id], data.aws_subnet.public_tag_filter.*.id, [""])[0]
  vpc_id              = concat([var.vpc_id], data.aws_subnet.public_tag_filter.*.vpc_id, [""])[0]
  security_group_name = concat([var.security_group_name], ["sentry-sg"])[0]
  security_group_id   = concat([var.security_group_id], data.aws_security_group.map_filter.*.id, data.aws_security_group.name_filter.*.id, [""])[0]
}

module "label" {
  source = "github.com/insight-infrastructure/terraform-null-label.git?ref=0.16.1"
  tags = {
    NetworkName = var.network_name
    Owner       = var.owner
    Terraform   = true
    VpcType     = "main"
  }

  environment = var.environment
  namespace   = var.namespace
  stage       = var.stage
}

module "user_data" {
  source = "github.com/insight-infrastructure/terraform-polkadot-user-data.git?ref=master"
  type   = "sentry"
}

module "ec2" {
  source = "github.com/insight-infrastructure/terraform-aws-ec2-basic.git?ref=master"

  name = var.node_name

  monitoring = var.monitoring
  create_eip = var.create_eip

  ebs_volume_size  = var.ebs_volume_size
  root_volume_size = var.root_volume_size

  instance_type = var.instance_type
  volume_path   = var.volume_path

  subnet_id              = local.subnet_id
  vpc_security_group_ids = [local.security_group_id]

  user_data        = module.user_data.user_data
  local_public_key = var.public_key_path

  tags = module.label.tags
}

//module "ansible" {
//  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.6.0"
//
//  playbook_file_path = var.playbook_file_path
//  private_key_path   = var.private_key_path
//  user               = var.user
//}
