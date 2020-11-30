# terraform-polkadot-aws-node

This module sets up single node deployments for polkadot, but can also be used to deploy nodes in a multi-node configuration.
Options include validator, API, and source of truth nodes. 

## Usage

```hcl
module "network" {
  source = "github.com/insight-infrastructure/terraform-aws-polkadot-network.git?ref=master"
  sentry_enabled = true
  num_azs = 1
}

module "default" {
  source            = "../.."
  public_key        = var.public_key
  subnet_id         = module.network.public_subnets[0]
  security_group_id = module.network.sentry_security_group_id
  private_key_path  = var.private_key_path
  create_ansible    = var.create_ansible
}
```

## Examples

- [simple](https://github.com/insight-infrastructure/terraform-polkadot-aws-sentry-node/tree/master/examples/simple)

## Known issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_path | Alternate base path for Polkadot client | `string` | `""` | no |
| chain | Which Polkadot chain to join | `string` | `"polkadot"` | no |
| chain\_stub | Short-name of the Polkadot chain to join, i.e. kusama = ksmm3, polkadot = polkadot. | `string` | `"polkadot"` | no |
| consul\_enabled | Bool to enable Consul | `bool` | `true` | no |
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_ansible | Boolean to make module or not | `bool` | `true` | no |
| default\_telemetry\_enabled | Bool to enable telemetry submission to telemetry.polkadot.io | `bool` | `false` | no |
| environment | The environment | `string` | `""` | no |
| health\_check\_enabled | Bool to enable client health check agent | `bool` | `true` | no |
| health\_check\_port | Port number for the health check | `string` | `"5500"` | no |
| instance\_count | Iteration number for this instance | `string` | `"0"` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | The name of the preexisting key to be used instead of the local public\_key\_path | `string` | `""` | no |
| logging\_filter | String for polkadot logging filter | `string` | `"sync=trace,afg=trace,babe=debug"` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| mount\_volumes | Bool to enable non-root volume mounting | `bool` | `false` | no |
| name | The name of the deployment | `string` | `"polkadot-api"` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| network\_settings | Map of network settings to apply. Use either this or set individual variables. | `map(map(string))` | `null` | no |
| network\_stub | The stub name of the Polkadot chain (polkadot = polkadot, kusama = ksmcc3) | `string` | `"ksmcc3"` | no |
| node\_exporter\_enabled | Bool to enable node exporter | `bool` | `true` | no |
| node\_exporter\_hash | SHA256 hash of Node Exporter binary | `string` | `"b2503fd932f85f4e5baf161268854bf5d22001869b84f00fd2d1f57b51b72424"` | no |
| node\_exporter\_password | Password for node exporter | `string` | `"node_exporter_password"` | no |
| node\_exporter\_url | URL to Node Exporter binary | `string` | `"https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz"` | no |
| node\_exporter\_user | User for node exporter | `string` | `"node_exporter_user"` | no |
| node\_name | Name of the node | `string` | `""` | no |
| node\_purpose | What type of node are you deploying? (validator/library/truth) | `string` | `"library"` | no |
| owner | Owner of the infrastructure | `string` | `""` | no |
| polkadot\_additional\_common\_flags | Optional common flags for Polkadot client | `string` | `""` | no |
| polkadot\_additional\_validator\_flags | Optional validator flags for Polkadot client | `string` | `""` | no |
| polkadot\_client\_hash | SHA256 hash of Polkadot client binary | `string` | `"cdf31d39ed54e66489d1afe74ed7549d5bcdf8ff479759e8fc476d17d069901e"` | no |
| polkadot\_client\_url | URL to Polkadot client binary | `string` | `"https://github.com/w3f/polkadot/releases/download/v0.8.23/polkadot"` | no |
| polkadot\_prometheus\_port | Port number for the Prometheus Metrics exporter built into the Polkadot client | `string` | `"9610"` | no |
| polkadot\_restart\_day | Client cron restart day | `string` | `""` | no |
| polkadot\_restart\_enabled | Bool to enable client restart cron job | `bool` | `false` | no |
| polkadot\_restart\_hour | Client cron restart hour | `string` | `""` | no |
| polkadot\_restart\_minute | Client cron restart minute | `string` | `""` | no |
| polkadot\_restart\_month | Client cron restart month | `string` | `""` | no |
| polkadot\_restart\_weekday | Client cron restart weekday | `string` | `""` | no |
| private\_key\_path | Path to private key | `string` | `""` | no |
| project | Name of the project for node name | `string` | `"project"` | no |
| public\_key | The public ssh key. key\_name takes precidence | `string` | `""` | no |
| root\_volume\_size | Root volume size | `string` | `0` | no |
| rpc\_api\_port | Port number for the JSON RPC API | `string` | `"9933"` | no |
| security\_group\_id | The id of the security group to run in | `string` | n/a | yes |
| source\_of\_truth\_enabled | Bool to enable SoT sync (for use with library nodes) | `bool` | `false` | no |
| ssh\_user | Username for SSH | `string` | `"ubuntu"` | no |
| stage | The stage of the deployment | `string` | `""` | no |
| storage\_driver\_type | Type of EBS storage the instance is using (nitro/standard) | `string` | `"standard"` | no |
| subnet\_id | The id of the subnet. | `string` | `""` | no |
| sync\_aws\_access\_key\_id | AWS access key ID for SoT sync | `string` | `""` | no |
| sync\_aws\_secret\_access\_key | AWS access key for SoT sync | `string` | `""` | no |
| sync\_bucket\_uri | S3 bucket URI for SoT sync | `string` | `null` | no |
| sync\_region | AWS region for SoT sync | `string` | `""` | no |
| telemetry\_url | WSS URL for telemetry | `string` | `""` | no |
| wss\_api\_port | Port number for the Websockets API | `string` | `"9944"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| private\_ip | n/a |
| public\_ip | n/a |
| reader\_aws\_access\_key\_id | n/a |
| reader\_aws\_secret\_access\_key | n/a |
| security\_group\_id | n/a |
| subnet\_id | n/a |
| sync\_aws\_access\_key\_id | n/a |
| sync\_aws\_secret\_access\_key | n/a |
| sync\_bucket\_uri | n/a |
| user\_data | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.