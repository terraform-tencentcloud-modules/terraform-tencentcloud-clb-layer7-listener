module "clb-instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"

  network_type = "INTERNAL"
  clb_name     = "tf-clb-module-internal"
  vpc_id       = "vpc-h70b6b49"
  subnet_id    = "subnet-fzpocfjk"
  project_id   = 0

  clb_tags = {
    test = "tf-clb-module"
  }
}

module "clb-layer7-listener" {
  source = "terraform-tencentcloud-modules/clb-layer7-listener/tencentcloud"

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
      instance_id = "ins-b8bowoum"
      port        = 8899
      weight      = 50
    },
    {
      instance_id = "ins-mabscyug"
      port        = 8900
      weight      = 50
    }
  ]
}