# -- root/main.tf ----

# Create VPC 
module "networking" {
  source   = "./networking"
  vpc_cidr = "172.31.0.0/16"
}