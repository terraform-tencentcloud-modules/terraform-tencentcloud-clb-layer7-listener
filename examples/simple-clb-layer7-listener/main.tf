provider "tencentcloud" {
  region = "ap-guangzhou"
}

module "clb-instance" {
  source = "../../../terraform-tencentcloud-clb"

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
      instance_id = "ins-qizzaabq"
      port        = 8899
      weight      = 50
    },
    {
      instance_id = "ins-lis5m0xy"
      port        = 8900
      weight      = 50
    }
  ]
}