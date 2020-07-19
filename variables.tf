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
variable "listener_certificate" {
  type = object({
    certificate_ssl_mode = string
    certificate_id       = string
    certificate_ca_id    = string
    sni_switch           = bool
  })
  description = "The CLB layer7 listener certificate settings. Supported fields are `certificate_ssl_mode`, `certificate_id`, `certificate_ca_id` and `sni_switch`. NOTES: Only supports listeners of 'HTTPS'."
  default = {
    certificate_ssl_mode = null
    certificate_id       = null
    certificate_ca_id    = null
    sni_switch           = false
  }
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

variable "health_check" {
  type = object({
    health_check_switch        = bool
    health_check_interval_time = number
    health_check_health_num    = number
    health_check_unhealth_num  = number
    health_check_http_code     = number
    health_check_http_path     = string
    health_check_http_domain   = string
    health_check_http_method   = string
  })
  description = "The CLB layer4 listener health check settings. Supported fields are `health_check_switch`, `health_check_interval_time`, `health_check_health_num`, `health_check_unhealth_num`, `health_check_http_code`, `health_check_http_path`, `health_check_http_domain` and `health_check_http_method`."
  default = {
    health_check_switch        = false
    health_check_interval_time = 5
    health_check_health_num    = 3
    health_check_unhealth_num  = 3
    health_check_http_code     = 31
    health_check_http_path     = null
    health_check_http_domain   = null
    health_check_http_method   = "HEAD"
  }
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

variable "rule_certificate" {
  type = object({
    certificate_ssl_mode = string
    certificate_id       = string
    certificate_ca_id    = string
  })
  description = "The CLB layer7 listener rule certificate settings. Supported fields are `certificate_ssl_mode`, `certificate_id` and `certificate_ca_id`. NOTES: Only supports listeners of 'HTTPS'."
  default = {
    certificate_ssl_mode = null
    certificate_id       = null
    certificate_ca_id    = null
  }
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