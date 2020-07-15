variable "region" {
  description = "TencentCloud region to launch resources."
  default     = ""
}

# clb instance variables
variable "clb_id" {
  description = "Id of the CLB."
  type        = string
}

# clb listener variables
variable "listener_id" {
  description = "Id of the CLB listener"
  type        = string
  default     = ""
}

variable "listener_name" {
  description = "Name of the CLB listener, and available values can only be Chinese characters, English letters, numbers, underscore and hyphen '-'."
  type        = string
  default     = "tf-modules-clb-listener"
}

variable "port" {
  description = "Port of the CLB listener."
  type        = number
  default     = null
}

variable "protocol" {
  type        = string
  description = "Type of protocol within the listener, and available values are 'HTTP' and 'HTTPS'."
  default     = null
}

## certification variables
variable "listener_certificate_ssl_mode" {
  type        = string
  description = "Type of certificate, and available values are 'UNIDIRECTIONAL', 'MUTUAL'. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available."
  default     = null
}

variable "listener_certificate_id" {
  type        = string
  description = "Id of the server certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available."
  default     = null
}

variable "listener_certificate_ca_id" {
  type        = string
  description = "Id of the client certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when the ssl mode is 'MUTUAL'."
  default     = null
}

variable "sni_switch" {
  type        = bool
  description = "Indicates whether SNI is enabled, and only supported with protocol 'HTTPS'. If enabled, you can set a certificate for each rule, otherwise all rules have a certificate."
  default     = false
}

# clb listener rule variables
variable "rule_id" {
  type        = string
  description = "Id of the rule."
  default     = ""
}

variable "domain" {
  type        = string
  description = "Domain name of the listener rule."
  default     = null
}

variable "url" {
  type        = string
  description = "Url of the listener rule."
  default     = null
}

variable "health_check_switch" {
  type        = bool
  description = "Indicates whether health check is enabled."
  default     = false
}

variable "health_check_interval_time" {
  type        = number
  description = "Interval time of health check. The value range is 5-300 sec, and the default is 5 sec."
  default     = 5
}

variable "health_check_health_num" {
  type        = number
  description = "Health threshold of health check, and the default is 3. If a success result is returned for the health check 3 consecutive times, indicates that the forwarding is normal. The value range is 2-10."
  default     = 3
}

variable "health_check_unhealth_num" {
  type        = number
  description = "Unhealthy threshold of health check, and the default is 3. If the unhealth result is returned 3 consecutive times, indicates that the forwarding is abnormal. The value range is 2-10."
  default     = 3
}

variable "health_check_http_code" {
  type        = number
  description = "HTTP Status Code. The default is 31 and value range is 1-31. 1 means the return value '1xx' is health. 2 means the return value '2xx' is health. 4 means the return value '3xx' is health. 8 means the return value '4xx' is health. 16 means the return value '5xx' is health. If you want multiple return codes to indicate health, need to add the corresponding values. NOTES: The 'HTTP' health check of the 'TCP' listener only supports specifying one health check status code."
  default     = 31
}

variable "health_check_http_path" {
  type        = string
  description = "Path of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol."
  default     = null
}

variable "health_check_http_domain" {
  type        = string
  description = "Domain name of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol."
  default     = null
}

variable "health_check_http_method" {
  type        = string
  description = "Methods of health check. NOTES: Only supports listeners of 'HTTP' and 'HTTPS' protocol. The default is 'HEAD', the available value are 'HEAD' and 'GET'."
  default     = "HEAD"
}

variable "session_expire_time" {
  type        = number
  description = "Time of session persistence within the CLB listener. NOTES: Available when scheduler is specified as 'WRR'."
  default     = 0
}

variable "scheduler" {
  type        = string
  description = "Scheduling method of the CLB listener rules, and available values are 'WRR', 'IP HASH' and 'LEAST_CONN'. The default is 'WRR'."
  default     = "WRR"
}

variable "rule_certificate_ssl_mode" {
  type        = string
  description = "Type of certificate, and available values are 'UNIDIRECTIONAL', 'MUTUAL'. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available."
  default     = null
}

variable "rule_certificate_id" {
  type        = string
  description = "Id of the server certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when it is available."
  default     = null
}

variable "rule_certificate_ca_id" {
  type        = string
  description = "Id of the client certificate. NOTES: Only supports listeners of 'HTTPS' and must be set when the ssl mode is 'MUTUAL'."
  default     = null
}

# clb-attachment variables
variable "backend_instances" {
  type = list(object({
    instance_id = string
    port        = number
    weight      = number
  }))
  description = "Information of the backends to be attached. if omitted, will create CLB listener only without the attachment."
  default     = []
}