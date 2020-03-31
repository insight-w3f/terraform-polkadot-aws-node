resource "random_pet" "this" {}

module "label" {
  source = "github.com/robc-io/terraform-null-label.git?ref=0.16.1"
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

resource "aws_key_pair" "this" {
  count      = var.key_name == "" && var.create ? 1 : 0
  public_key = var.public_key
}

resource "aws_eip" "this" {
  count = var.create_eip && var.create ? 1 : 0

  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = module.label.tags
}

resource "aws_eip_association" "this" {
  count = var.create_eip && var.create ? 1 : 0

  allocation_id = aws_eip.this.*.id[count.index]
  instance_id   = aws_instance.this.*.id[0]
}


resource "aws_instance" "this" {
  count = var.create ? 1 : 0

  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id

  user_data = module.user_data.user_data

  subnet_id = var.subnet_id

  vpc_security_group_ids = [var.security_group_id]

  monitoring = var.monitoring

  key_name = concat(aws_key_pair.this.*.key_name, [var.key_name])[0]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = var.root_volume_size
    delete_on_termination = true
  }

  tags = merge({ Name : var.node_name }, module.label.tags)
}
