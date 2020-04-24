# terraform-polkadot-aws-sentry-node

WIP - Do not use

## Features

This module sets up

## Terraform versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-infrastructure/terraform-polkadot-aws-sentry-node"

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
| chain | Which Polkadot chain to join | `string` | `"kusama"` | no |
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_ansible | Boolean to make module or not | `bool` | `true` | no |
| environment | The environment | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | The name of the preexisting key to be used instead of the local public\_key\_path | `string` | `""` | no |
| logging\_filter | String for polkadot logging filter | `string` | `"sync=trace,afg=trace,babe=debug"` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| node\_exporter\_password | Password for node exporter | `string` | `"node_exporter_password"` | no |
| node\_exporter\_user | User for node exporter | `string` | `"node_exporter_user"` | no |
| node\_name | Name of the node | `string` | `""` | no |
| owner | Owner of the infrastructure | `string` | `""` | no |
| private\_key\_path | Path to private key | `string` | `""` | no |
| project | Name of the project for node name | `string` | `"project"` | no |
| public\_key | The public ssh key. key\_name takes precidence | `string` | `""` | no |
| relay\_node\_ip | Internal IP of Polkadot relay node | `string` | `""` | no |
| relay\_node\_p2p\_address | P2P address of Polkadot relay node | `string` | `""` | no |
| root\_volume\_size | Root volume size | `string` | `0` | no |
| security\_group\_id | The id of the security group to run in | `string` | n/a | yes |
| ssh\_user | Username for SSH | `string` | `"ubuntu"` | no |
| stage | The stage of the deployment | `string` | `""` | no |
| subnet\_id | The id of the subnet. | `string` | `""` | no |
| telemetry\_url | WSS URL for telemetry | `string` | `"wss://mi.private.telemetry.backend/"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| private\_ip | n/a |
| public\_ip | n/a |
| security\_group\_id | n/a |
| subnet\_id | n/a |
| user\_data | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

Module managed by [robc-io](github.com/robc-io)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.