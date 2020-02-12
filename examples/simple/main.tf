variable "public_key_path" {}
//variable "private_key_path" {}

module "network" {
  source = "github.com/robc-io/terraform-aws-polkadot-network"
}

module "sentry" {
  source            = "../.."
  public_key_path   = var.public_key_path
  subnet_id         = module.network.public_subnets[0]
  security_group_id = module.network.sentry_security_group_id

  //  playbook_file_path = "${path.cwd}/playbook.yml"
  //  private_key_path = var.private_key_path
}

