provider "tencentcloud" {
  version = ">=1.19.0"
  region  = var.region != "" ? var.region : null
}

resource "tencentcloud_clb_listener" "this" {
  count = var.listener_id == "" ? 1 : 0

  clb_id               = var.clb_id
  listener_name        = var.listener_name
  port                 = var.port
  protocol             = var.protocol
  certificate_ssl_mode = var.protocol == "HTTPS" ? lookup(var.listener_certificate, "certificate_ssl_mode", null) : null
  certificate_id       = var.protocol == "HTTPS" ? lookup(var.listener_certificate, "certificate_id", null) : null
  certificate_ca_id    = var.protocol == "HTTPS" && lookup(var.listener_certificate, "certificate_ssl_mode") == "MUTUAL" ? lookup(var.listener_certificate, "certificate_ca_id") : null
  sni_switch           = var.protocol == "HTTPS" ? lookup(var.listener_certificate, "sni_switch", false) : null
}

resource "tencentcloud_clb_listener_rule" "this" {
  count = var.rule_id == "" ? 1 : 0

  clb_id                     = var.clb_id
  listener_id                = local.listener_id
  domain                     = var.domain
  url                        = var.url
  health_check_switch        = lookup(var.health_check, "health_check_switch", false)
  health_check_interval_time = lookup(var.health_check, "health_check_interval_time", 5)
  health_check_health_num    = lookup(var.health_check, "health_check_health_num", 3)
  health_check_unhealth_num  = lookup(var.health_check, "health_check_unhealth_num", 3)
  health_check_http_code     = lookup(var.health_check, "health_check_http_code", 31)
  health_check_http_path     = lookup(var.health_check, "health_check_http_path", null)
  health_check_http_domain   = lookup(var.health_check, "health_check_http_domain", null)
  health_check_http_method   = lookup(var.health_check, "health_check_http_method", "HEAD")
  certificate_ssl_mode       = var.protocol == "HTTPS" ? lookup(var.rule_certificate, "certificate_ssl_mode", null) : null
  certificate_id             = var.protocol == "HTTPS" ? lookup(var.rule_certificate, "certificate_id") : null
  certificate_ca_id          = var.protocol == "HTTPS" && lookup(var.rule_certificate, "certificate_ssl_mode") == "MUTUAL" ? lookup(var.rule_certificate, "certificate_ca_id", null) : null
  session_expire_time        = var.scheduler == "WRR" ? var.session_expire_time : null
  scheduler                  = var.scheduler
}

resource "tencentcloud_clb_attachment" "this" {
  count = length(var.backend_instances) > 0 ? 1 : 0

  clb_id      = local.clb_id
  listener_id = local.listener_id
  rule_id     = local.rule_id
  dynamic "targets" {
    for_each = local.backend_instances
    content {
      instance_id = lookup(targets.value, "instance_id")
      port        = lookup(targets.value, "port")
      weight      = lookup(targets.value, "weight")
    }
  }
}

data "tencentcloud_clb_listeners" "this" {
  clb_id      = local.clb_id
  listener_id = local.listener_id
}

data "tencentcloud_clb_listener_rules" "this" {
  clb_id      = local.clb_id
  listener_id = local.listener_id
  rule_id     = local.rule_id
}

locals {
  backend_instances = flatten([
    for _, obj in var.backend_instances : {
      instance_id = lookup(obj, "instance_id")
      port        = lookup(obj, "port")
      weight      = lookup(obj, "weight", 10)
    }
  ])

  clb_id      = var.clb_id
  listener_id = var.listener_id != "" ? var.listener_id : concat(tencentcloud_clb_listener.this.*.id, [""])[0]
  rule_id     = var.rule_id != "" ? var.rule_id : concat(tencentcloud_clb_listener_rule.this.*.id, [""])[0]

  this_listener_info = data.tencentcloud_clb_listeners.this.listener_list
  this_rule_info     = data.tencentcloud_clb_listener_rules.this.rule_list
  targets            = concat(tencentcloud_clb_attachment.this.*.targets, [{}])[0]
  backend_instances_read = flatten([
    for _, obj in local.targets : {
      instance_id = lookup(obj, "instance_id")
      port        = lookup(obj, "port")
      weight      = lookup(obj, "weight")
    }
  ])
}