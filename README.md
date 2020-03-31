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
## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_eip | Boolean to create elastic IP | `bool` | `false` | no |
| environment | The environment | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"t2.micro"` | no |
| key\_name | The name of the preexisting key to be used instead of the local public\_key\_path | `string` | `""` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| node\_name | Name of the node | `string` | `""` | no |
| owner | Owner of the infrastructure | `string` | `""` | no |
| public\_key | The public ssh key. key\_name takes precidence | `string` | `""` | no |
| root\_volume\_size | Root volume size | `string` | `0` | no |
| security\_group\_id | The id of the security group to run in | `string` | n/a | yes |
| stage | The stage of the deployment | `string` | `""` | no |
| subnet\_id | The id of the subnet. | `string` | `""` | no |

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