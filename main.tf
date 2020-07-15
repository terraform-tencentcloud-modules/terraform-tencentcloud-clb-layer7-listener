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
  certificate_ssl_mode = var.protocol == "HTTPS" ? var.listener_certificate_ssl_mode : null
  certificate_id       = var.protocol == "HTTPS" ? var.listener_certificate_id : null
  certificate_ca_id    = var.protocol == "HTTPS" && var.listener_certificate_ssl_mode == "MUTUAL" ? var.listener_certificate_ca_id : null
  sni_switch           = var.protocol == "HTTPS" ? var.sni_switch : null
}

resource "tencentcloud_clb_listener_rule" "this" {
  count = var.rule_id == "" ? 1 : 0

  clb_id                     = var.clb_id
  listener_id                = local.listener_id
  domain                     = var.domain
  url                        = var.url
  health_check_switch        = var.health_check_switch
  health_check_interval_time = var.health_check_interval_time
  health_check_health_num    = var.health_check_health_num
  health_check_unhealth_num  = var.health_check_unhealth_num
  health_check_http_code     = var.health_check_http_code
  health_check_http_path     = var.health_check_http_path
  health_check_http_domain   = var.health_check_http_domain
  health_check_http_method   = var.health_check_http_method
  certificate_ssl_mode       = var.protocol == "HTTPS" ? var.rule_certificate_ssl_mode : null
  certificate_id             = var.protocol == "HTTPS" ? var.rule_certificate_id : null
  certificate_ca_id          = var.protocol == "HTTPS" && var.rule_certificate_ssl_mode == "MUTUAL" ? var.rule_certificate_ca_id : null
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
  targets            = concat(tencentcloud_clb_attachment.this.*.targets, [""])[0]
  backend_instances_read = flatten([
    for _, obj in local.targets : {
      instance_id = lookup(obj, "instance_id")
      port        = lookup(obj, "port")
      weight      = lookup(obj, "weight")
    }
  ])
}