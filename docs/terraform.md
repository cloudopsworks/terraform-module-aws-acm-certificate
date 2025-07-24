## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.4 |
| <a name="provider_aws.cross_account"></a> [aws.cross\_account](#provider\_aws.cross\_account) | ~> 6.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.imported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cross_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_acm_certificate_validation.local_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.cross_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.local_cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_acmpca_certificate_authority.private_ca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acmpca_certificate_authority) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route53_zone.cross_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.local_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret.imported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.imported](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alerts"></a> [alerts](#input\_alerts) | Enable alerts for ACM certificate | <pre>object({<br/>    enabled       = optional(bool, false)<br/>    priority      = optional(number, 3)<br/>    sns_topic_arn = optional(string, "")<br/>  })</pre> | `{}` | no |
| <a name="input_certificate_type"></a> [certificate\_type](#input\_certificate\_type) | The type of ACM certificate to create, either 'internal', 'external' or 'imported'. Defaults to 'external'. | `string` | `"external"` | no |
| <a name="input_create"></a> [create](#input\_create) | Flag to create the ACM certificate. Defaults to true. | `bool` | `true` | no |
| <a name="input_cross_account"></a> [cross\_account](#input\_cross\_account) | The cross account to use for the Certificate domain, aws.cross\_account provider must be set to module. | `bool` | `false` | no |
| <a name="input_domain_alias"></a> [domain\_alias](#input\_domain\_alias) | The domain alias to use for the Certificate domain | `string` | `""` | no |
| <a name="input_domain_alternates"></a> [domain\_alternates](#input\_domain\_alternates) | The domain alternate aliases to use for the Certificate domain | `list(string)` | `[]` | no |
| <a name="input_domain_zone"></a> [domain\_zone](#input\_domain\_zone) | The domain zone to use for the Certificate domain zone | `string` | `"example.com"` | no |
| <a name="input_early_renewal_days"></a> [early\_renewal\_days](#input\_early\_renewal\_days) | The duration in days before the certificate expires to start early renewal, only available for internal Certs. Defaults to 30 days. | `string` | `0` | no |
| <a name="input_external_dns_zone"></a> [external\_dns\_zone](#input\_external\_dns\_zone) | (optional) allows the module work with external record validation out of Route53, defaults to false | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_imported_cert_secret_name"></a> [imported\_cert\_secret\_name](#input\_imported\_cert\_secret\_name) | The name of the secret in AWS Secrets Manager where the imported certificate is stored. | `string` | `""` | no |
| <a name="input_internal_ca_arn"></a> [internal\_ca\_arn](#input\_internal\_ca\_arn) | The ARN of the internal CA to use for the Certificate domain, if not provided, a new CA will be created. | `string` | `""` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Establish this is a HUB or spoke configuration | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ACM certificate module, used for naming resources. | `string` | `""` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix for the ACM certificate module, used for naming resources. | `string` | `"managed-cert"` | no |
| <a name="input_options"></a> [options](#input\_options) | Additional options for the ACM certificate, such as tags and validation methods. | `any` | `{}` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_private_zone"></a> [private\_zone](#input\_private\_zone) | Required to search the Route53 zone in a private zone. Defaults to false | `bool` | `false` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | n/a | `string` | `"001"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | n/a |
| <a name="output_acm_certificate_expire_date"></a> [acm\_certificate\_expire\_date](#output\_acm\_certificate\_expire\_date) | n/a |
| <a name="output_acm_certificate_renewal_elegibility"></a> [acm\_certificate\_renewal\_elegibility](#output\_acm\_certificate\_renewal\_elegibility) | n/a |
| <a name="output_acm_certificate_status"></a> [acm\_certificate\_status](#output\_acm\_certificate\_status) | n/a |
| <a name="output_acm_certificate_validation_options"></a> [acm\_certificate\_validation\_options](#output\_acm\_certificate\_validation\_options) | n/a |
