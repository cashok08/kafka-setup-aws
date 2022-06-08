# -- root/main.tf ----

# Create VPC 
module "networking" {
  source   = "./networking"
  vpc_cidr = "172.31.0.0/16"
  # Pass this to networking module using variables
  public_cidrs = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]

}