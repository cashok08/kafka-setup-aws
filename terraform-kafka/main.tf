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
  source = "./loadbalancer"
  public_sg = module.networking.public_sg
  public_subnets= module.networking.public_subnets
}