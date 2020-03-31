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
  count = var.create ? 1 : 0

  vpc = true

  lifecycle {
    prevent_destroy = false
  }

  tags = module.label.tags
}

resource "aws_eip_association" "this" {
  count = var.create ? 1 : 0

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

module "ansible" {
  source = "github.com/insight-infrastructure/terraform-aws-ansible-playbook.git?ref=v0.12.0"
  create = var.create_ansible && var.create

  ip = join("", aws_eip_association.this.*.public_ip)

  user = "ubuntu"

  private_key_path = var.private_key_path

  playbook_file_path = "${path.module}/ansible/main.yml"

  playbook_vars = {
    id = module.label.id

    node_exporter_user : var.node_exporter_user,
    node_exporter_password : var.node_exporter_password,
    chain : var.chain,
    ssh_user : var.ssh_user,
    project : var.project,

    polkadot_binary_url : "https://github.com/w3f/polkadot/releases/download/v0.7.21/polkadot",
    polkadot_binary_checksum : "sha256:af561dc3447e8e6723413cbeed0e5b1f0f38cffaa408696a57541897bf97a34d",
    node_exporter_binary_url : "https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz",
    node_exporter_binary_checksum : "sha256:b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424",
    polkadot_restart_enabled : true,
    polkadot_restart_minute : "50",
    polkadot_restart_hour : "10",
    polkadot_restart_day : "1",
    polkadot_restart_month : "*",
    polkadot_restart_weekday : "*",
    telemetry_url : var.telemetry_url,
    logging_filter : var.logging_filter,
    relay_ip_address : var.relay_node_ip,
    relay_p2p_address : var.relay_node_p2p_address,
  }

  requirements_file_path = "${path.module}/ansible/requirements.yml"
}
