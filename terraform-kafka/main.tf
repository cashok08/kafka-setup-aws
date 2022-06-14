# -- root/main.tf ----
# Need to handle better by not declaring the ami here ; redundant should 
# be in ec2 module
data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["309956199498"]
  #ami-0cebc9110ef246a50 rhel 8
  filter {
    name = "name"
    # https://ap-southeast-1.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-1#ImageDetails:imageId=ami-0cebc9110ef246a50
    #https://ap-southeast-1.console.aws.amazon.com/ec2/v2/home?region=ap-southeast-1#Images:visibility=public-images;v=3;search=:ubuntu,:ami-04d9e855d716f9c99
    #values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    values = ["RHEL-8.5.0_HVM-*-x86_64-0-Hourly2-GP2"]

  }
}

# Create VPC 
module "networking" {
  source          = "./networking"
  vpc_cidr        = local.vpc_cidr
  access_ip       = var.access_ip
  security_groups = local.security_groups
  # Pass this to networking module using variables
  public_cidrs = ["172.31.0.0/20", "172.31.16.0/20", "172.31.32.0/20"]

}

# Creating ELB 
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

module "kafkaec2" {
  source         = "./ec2"
  public_sg      = module.networking.public_sg
  public_subnets = module.networking.public_subnets
  instance_count = 3 # one in each az's
  instance_type  = "t2.medium"
  ami            = data.aws_ami.server_ami.id
  vol_size       = 10
  key_name = "kafkassh"
  public_key_path = "kafkassh.pub"
  user_data_path = "${path.root}/userdata.tpl"


}