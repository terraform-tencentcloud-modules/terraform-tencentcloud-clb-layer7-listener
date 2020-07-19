# TencentCloud CLB Layer4 Listener Module for Terraform

## terraform-tencentcloud-clb-layer7-listener

A terraform module used to create TencentCloud CLB layer7 listener, CLB listener rule and CLB attachment.

The following resources are included.

* [CLB Listener](https://www.terraform.io/docs/providers/tencentcloud/r/clb_listener.html)
* [CLB Attachment](https://www.terraform.io/docs/providers/tencentcloud/r/clb_attachment.html)
* [CLB_Listener_Rule](https://www.terraform.io/docs/providers/tencentcloud/r/clb_listener_rule.html)

## Usage


```hcl
module "clb-layer7-listener" {
  source = "../../../terraform-tencentcloud-clb-layer7-listener"

  clb_id        = module.clb-instance.clb_id
  listener_name = "tf-clb-listener7-module"
  port          = 80
  protocol      = "HTTPS"

  listener_certificate = {
    certificate_ssl_mode = "MUTUAL"
    certificate_id       = "VjANRdz8"
    certificate_ca_id    = "ZFWbtucO"
    sni_switch           = false
  }

  domain = "foo.net"
  url    = "/bar"

  health_check = {
    health_check_switch        = true
    health_check_interval_time = 5
    health_check_health_num    = 3
    health_check_unhealth_num  = 3
    health_check_http_code     = 2
    health_check_http_path     = "/"
    health_check_http_domain   = "www.foo.com"
    health_check_http_method   = "GET"
  }

  rule_certificate = {
    certificate_ssl_mode = "MUTUAL"
    certificate_id       = "VjANRdz8"
    certificate_ca_id    = "ZFWbtucO"
    sni_switch           = false
  }

  session_expire_time = 30
  scheduler           = "WRR"

  backend_instances = [
    {
      instance_id = "ins-hkdom3go"
      port        = 8899
      weight      = 50
    },
    {
      instance_id = "ins-m16vpbkc"
      port        = 8900
      weight      = 50
    }
  ]
}
```

## Conditional Creation

This module can create CLB listener, CLB listener rule and CLB attachment.
It is possible to use existing CLB listener when specify `listener_id` parameter.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| rule_certificate | The CLB layer7 listener rule certificate settings. Supported fields are `certificate_ssl_mode`, `certificate_id` and `certificate_ca_id`. NOTES: Only supports listeners of 'HTTPS'. | object | {} | no 
| listener_id | Id of the CLB listener | string |  | no 
| port | Port of the CLB listener. | number | null | no 
| listener_certificate | The CLB layer7 listener certificate settings. Supported fields are `certificate_ssl_mode`, `certificate_id`, `certificate_ca_id` and `sni_switch`. NOTES: Only supports listeners of 'HTTPS'. | object | {} | no 
| domain | Domain name of the listener rule. | string | null | no 
| url | Url of the listener rule. | string | null | no 
| health_check | The CLB layer4 listener health check settings. Supported fields are `health_check_switch`, `health_check_interval_time`, `health_check_health_num`, `health_check_unhealth_num`, `health_check_http_code`, `health_check_http_path`, `health_check_http_domain` and `health_check_http_method`. | map | {} | no 
| region | TencentCloud region to launch resources. | string |  | no 
| clb_id | Id of the CLB. | string |  | yes 
| listener_name | Name of the CLB listener, and available values can only be Chinese characters, English letters, numbers, underscore and hyphen '-'. | string | tf-modules-clb-listener | no 
| session_expire_time | Time of session persistence within the CLB listener. NOTES: Available when scheduler is specified as 'WRR'. | number | 0 | no 
| backend_instances | Information of the backends to be attached. if omitted, will create CLB listener only without the attachment. | list | [] | no 
| protocol | Type of protocol within the listener, and available values are 'HTTP' and 'HTTPS'. | string | null | no 
| scheduler | Scheduling method of the CLB listener rules, and available values are 'WRR', 'IP HASH' and 'LEAST_CONN'. The default is 'WRR'. | string | WRR | no 
| rule_id | Id of the rule. | string |  | no 


## Outputs

| Name | Description |
|------|-------------|
| protocol | Type of protocol within the listener. |
| rule_id | Id of the rule. |
| backend_instances | Information of the backends to be attached. |
| clb_id | Id of CLB instance. |
| listener_id | Id of CLB listener. |
| listener_name | Name of the CLB listener. |
| port | Port of the CLB listener. |


## Authors

Created and maintained by [TencentCloud](https://github.com/tencentcloudstack/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details. 