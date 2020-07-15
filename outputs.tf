# clb outputs
output "clb_id" {
  description = "Id of CLB instance."
  value       = local.clb_id
}

# clb listener outputs
output "listener_id" {
  description = "Id of CLB listener."
  value       = local.listener_id
}

output "listener_name" {
  description = "Name of the CLB listener."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].listener_name : ""
}

output "port" {
  description = "Port of the CLB listener."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].port : null
}

output "protocol" {
  description = "Type of protocol within the listener."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].protocol : ""
}

output "listener_certificate_ssl_mode" {
  description = "Type of listener certificate."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].certificate_ssl_mode : ""
}

output "listener_certificate_id" {
  description = "Id of the server certificate."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].certificate_id : ""
}

output "listener_certificate_ca_id" {
  description = "Id of the client certificate."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].certificate_ca_id : ""
}

output "sni_switch" {
  description = "Indicates whether SNI is enabled, and only supported with protocol 'HTTPS'."
  value       = length(local.this_listener_info) > 0 ? local.this_listener_info[0].sni_switch : ""
}

# clb listener rule outputs
output "rule_id" {
  description = "Id of the rule."
  value       = local.rule_id
}

output "domain" {
  description = "Domain name of the listener rule."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].domain : ""
}

output "url" {
  description = "Url of the listener rule."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].url : ""
}

output "health_check_switch" {
  description = "Indicates whether health check is enabled."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_switch : ""
}

output "health_check_interval_time" {
  description = "Interval time of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_interval_time : ""
}

output "health_check_health_num" {
  description = "Health threshold of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_health_num : ""
}

output "health_check_unhealth_num" {
  description = "Unhealthy threshold of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_unhealth_num : ""
}

output "health_check_http_code" {
  description = "HTTP Status Code."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_http_code : ""
}

output "health_check_http_path" {
  description = "Path of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_http_path : ""
}

output "health_check_http_domain" {
  description = "Domain name of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_http_domain : ""
}

output "health_check_http_method" {
  description = "Methods of health check."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].health_check_http_method : ""
}

output "session_expire_time" {
  description = "Time of session persistence within the CLB listener."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].session_expire_time : ""
}

output "scheduler" {
  description = "Scheduling method of the CLB listener rules."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].scheduler : ""
}

output "rule_certificate_ssl_mode" {
  description = "Type of rule certificate."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].certificate_ssl_mode : ""
}

output "rule_certificate_id" {
  description = "Id of the server certificate."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].certificate_id : ""
}

output "rule_certificate_ca_id" {
  description = "Id of the client certificate."
  value       = length(local.this_rule_info) > 0 ? local.this_rule_info[0].certificate_ca_id : ""
}

# attachment outputs
output "backend_instances" {
  description = "Information of the backends to be attached."
  value       = length(local.targets) > 0 ? local.backend_instances_read : []
}