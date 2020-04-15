variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  version = "~> 2.0"
}

variable "public_key" {}
variable "private_key_path" {}

module "network" {
  source         = "github.com/insight-w3f/terraform-polkadot-aws-network.git?ref=master"
  sentry_enabled = true
}

module "default" {
  source            = "../.."
  public_key        = var.public_key
  subnet_id         = module.network.public_subnets[0]
  security_group_id = module.network.sentry_security_group_id
  private_key_path  = var.private_key_path
  root_volume_size  = "30"
}
