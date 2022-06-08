# -- root/main.tf ----

locals {
  # Warning ; in this way if you change the VPC tf crashes
  # because internet gateway is updated in place it is not 
  # destroyed and created ; so add life cycle policy for vpc 
  # to create one before destroying
  vpc_cidr = "172.31.0.0/16"
}

# Create VPC 
module "networking" {
  source   = "./networking"
  vpc_cidr = local.vpc_cidr
  # Pass this to networking module using variables
  public_cidrs = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]

}