# -- root/main.tf ----


# Create VPC 
module "networking" {
  source          = "./networking"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  # Pass this to networking module using variables
  public_cidrs = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]

}

module "loadbalancer" {
  source           = "./loadbalancer"
  public_sg        = module.networking.public_sg
  public_subnets   = module.networking.public_subnets
  vpc_id           = module.networking.vpc_id # from networking output
  kafka_lb_tg_port = 9092                     # bootstrap server # can be updated updated
  # in-place no replacement arn remains same
  kafka_lb_tg_protocol       = "HTTP"
  kafka_lb_healthy_threshold = 2

  kafka_lb_unhealthy_threshold = 2
  kafka_lb_timeout             = 3
  kafka_lb_interval            = 30
  kafka_lb_listener_port       = 80 # 443 for SSL
  kafka_lb_listener_protocol   = "HTTP"


}