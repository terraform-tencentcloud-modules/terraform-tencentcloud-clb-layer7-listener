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

  clb_id                        = module.clb-instance.clb_id
  listener_name                 = "tf-clb-listener7-module"
  port                          = 80
  protocol                      = "HTTPS"
  listener_certificate_ssl_mode = "MUTUAL"
  listener_certificate_id       = "VjANRdz8"
  listener_certificate_ca_id    = "ZFWbtucO"

  domain                     = "foo.net"
  url                        = "/bar"
  health_check_switch        = true
  health_check_interval_time = 5
  health_check_health_num    = 3
  health_check_unhealth_num  = 3
  health_check_http_code     = 2
  health_check_http_path     = "/"
  health_check_http_domain   = "www.foo.com"
  health_check_http_method   = "GET"
  rule_certificate_ssl_mode  = "MUTUAL"
  rule_certificate_id        = "VjANRdz8"
  rule_certificate_ca_id     = "ZFWbtucO"
  session_expire_time        = 30
  scheduler                  = "WRR"

  backend_instances = [
    {
      instance_id = "ins-xxxxxxxx"
      port        = 8899
      weight      = 50
    },
    {
      instance_id = "ins-xxxxxxxx"
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
| listener_certificate_id | Id of the server certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available. | string | null | no 
| listener_certificate_ca_id | Id of the client certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when the ssl mode is 'MUTUAL'. | string | null | no 
| health_check_http_domain | Domain name of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol. | string | null | no 
| listener_certificate_ssl_mode | Type of certificate, and available values are 'UNIDIRECTIONAL', 'MUTUAL'. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available. | string | null | no 
| port | Port of the CLB listener. | number | null | no 
| listener_id | Id of the CLB listener | string |  | no 
| rule_certificate_ca_id | Id of the client certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when the ssl mode is 'MUTUAL'. | string | null | no 
| health_check_http_path | Path of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol. | string | null | no 
| health_check_http_method | Methods of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol. The default is 'HEAD', the available value are 'HEAD' and 'GET'. | string | HEAD | no 
| rule_certificate_ssl_mode | Type of certificate, and available values are 'UNIDIRECTIONAL', 'MUTUAL'. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available. | string | null | no 
| backend_instances | Information of the backends to be attached. if omitted, will create CLB listener only without the attachment. | list | [] | no 
| protocol | Type of protocol within the listener, and available values are 'HTTP' and 'HTTPS'. | string | null | no 
| domain | Domain name of the listener rule. | string | null | no 
| health_check_unhealth_num | Unhealthy threshold of health check, and the default is 3. If the unhealth result is returned 3 consecutive times, indicates that the forwarding is abnormal. The value range is 2-10. | number | 3 | no 
| health_check_http_code | HTTP Status Code. The default is 31 and value range is 1-31. 1 means the return value '1xx' is health. 2 means the return value '2xx' is health. 4 means the return value '3xx' is health. 8 means the return value '4xx' is health. 16 means the return value '5xx' is health. If you want multiple return codes to indicate health, need to add the corresponding values. NOTES: The 'HTTP' health check of the 'TCP' listener only supports specifying one health check status code. | number | 31 | no 
| session_expire_time | Time of session persistence within the CLB listener. NOTES: Available when scheduler is specified as 'WRR'. | number | 0 | no 
| clb_id | Id of the CLB. | string |  | yes 
| sni_switch | Indicates whether SNI is enabled, and only supported with protocol 'HTTPS'. If enabled, you can set a certificate for each rule, otherwise all rules have a certificate. | bool | false | no 
| health_check_interval_time | Interval time of health check. The value range is 5-300 sec, and the default is 5 sec. | number | 5 | no 
| listener_name | Name of the CLB listener, and available values can only be Chinese characters, English letters, numbers, underscore and hyphen '-'. | string | tf-modules-clb-listener | no 
| url | Url of the listener rule. | string | null | no 
| health_check_switch | Indicates whether health check is enabled. | bool | false | no 
| health_check_health_num | Health threshold of health check, and the default is 3. If a success result is returned for the health check 3 consecutive times, indicates that the forwarding is normal. The value range is 2-10. | number | 3 | no 
| region | TencentCloud region to launch resources. | string |  | no 
| scheduler | Scheduling method of the CLB listener rules, and available values are 'WRR', 'IP HASH' and 'LEAST_CONN'. The default is 'WRR'. | string | WRR | no 
| rule_certificate_id | Id of the server certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available. | string | null | no 
| rule_id | Id of the rule. | string |  | no 


## Outputs

| Name | Description |
|------|-------------|
| listener_id | Id of CLB listener. |
| listener_certificate_ca_id | Id of the client certificate. |
| health_check_health_num | Health threshold of health check. |
| health_check_http_path | Path of health check. |
| protocol | Type of protocol within the listener. |
| listener_certificate_ssl_mode | Type of listener certificate. |
| sni_switch | Indicates whether SNI is enabled, and only supported with protocol 'HTTPS'. |
| rule_id | Id of the rule. |
| url | Url of the listener rule. |
| health_check_http_code | HTTP Status Code. |
| health_check_http_domain | Domain name of health check. |
| rule_certificate_id | Id of the server certificate. |
| listener_name | Name of the CLB listener. |
| port | Port of the CLB listener. |
| domain | Domain name of the listener rule. |
| health_check_unhealth_num | Unhealthy threshold of health check. |
| session_expire_time | Time of session persistence within the CLB listener. |
| backend_instances | Information of the backends to be attached. |
| clb_id | Id of CLB instance. |
| listener_certificate_id | Id of the server certificate. |
| health_check_switch | Indicates whether health check is enabled. |
| health_check_interval_time | Interval time of health check. |
| health_check_http_method | Methods of health check. |
| scheduler | Scheduling method of the CLB listener rules. |
| rule_certificate_ssl_mode | Type of rule certificate. |
| rule_certificate_ca_id | Id of the client certificate. |


## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details. 