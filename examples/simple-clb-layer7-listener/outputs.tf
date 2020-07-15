output "listener_id" {
  description = "Id of CLB listener."
  value       = module.clb-layer7-listener.listener_id
}

output "listener_name" {
  description = "Name of the CLB listener."
  value       = module.clb-layer7-listener.listener_name
}

output "rule_id" {
  description = "ID of the CLB listener rule."
  value       = module.clb-layer7-listener.rule_id
}

output "backend_instances" {
  description = "Information of the backends to be attached."
  value       = module.clb-layer7-listener.backend_instances
}