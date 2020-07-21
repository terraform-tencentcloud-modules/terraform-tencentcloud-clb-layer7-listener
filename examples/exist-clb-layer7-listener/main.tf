module "clb-layer7-listener" {
  source = "../../../terraform-tencentcloud-clb-layer7-listener"

  clb_id      = "lb-hbj2quqs"
  listener_id = "lbl-a7iumoma"

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