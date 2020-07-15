# CLB Layer4 Listener Module Example

This module will create new CLB attachment instance and new CLB listener rule instance using existing CLB instance and CLB listener.

## Usage

To run this example, you need first replace the configuration like `clb_id`, `listener_id`, `domain` etc, then execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note, this example may create resources which cost money. Run `terraform destroy` if you don't need these resources.

## Outputs

| Name | Description |
|------|-------------|
| listener_id | Id of CLB listener.   |
| listener_name | Name of the CLB listener. |
| rule_id | ID of the CLB listener rule. |
| backend_instances | Information of the backends to be attached. |