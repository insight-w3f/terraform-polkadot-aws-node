variable "public_key_path" {}

module "network" {
  source = "github.com/insight-infrastructure/terraform-aws-polkadot-network"
}

module "sentry" {
  source            = "../.."
  public_key_path   = var.public_key_path
  subnet_id         = module.network.public_subnets[0]
  security_group_id = module.network.sentry_security_group_id
}

