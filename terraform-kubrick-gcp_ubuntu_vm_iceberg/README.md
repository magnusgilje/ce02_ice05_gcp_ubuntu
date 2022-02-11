## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.linux_vm](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [local_file.pub](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_name"></a> [admin\_name](#input\_admin\_name) | default VM Admin user | `string` | n/a | yes |
| <a name="input_application"></a> [application](#input\_application) | Target Application | `string` | n/a | yes |
| <a name="input_cohort"></a> [cohort](#input\_cohort) | Cohort ID | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Target environment | `string` | n/a | yes |
| <a name="input_metadata_startup_script"></a> [metadata\_startup\_script](#input\_metadata\_startup\_script) | custom VM setup commands | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | VM Prefixing | `string` | n/a | yes |
| <a name="input_public_key_filename"></a> [public\_key\_filename](#input\_public\_key\_filename) | filename for SSH public key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP deployment region | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | VM Size | `string` | `"f1-micro"` | no |
| <a name="input_user"></a> [user](#input\_user) | End User | `string` | n/a | yes |
| <a name="input_vmid"></a> [vmid](#input\_vmid) | Unique identifier for the VM | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | Public IP Address |
