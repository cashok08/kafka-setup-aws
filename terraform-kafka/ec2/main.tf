# -- ec2/main.tf --

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

resource "random_id" "kafka_node_id" {
  byte_length = 2
  count       = var.instance_count # we need 1 in each az 
}

resource "aws_instance" "kafka_node" {
  count         = var.instance_count # 1
  instance_type = var.instance_type  # t2.medium
  ami           = data.aws_ami.server_ami.id
  tags = {
    # dec is decimal of random id
    Name = "kafka_node - ${random_id.kafka_node_id[count.index].dec}"
  }
  # key_name
  vpc_security_group_ids = [var.kafka_sg]
  subnet_id              = var.kafka_subnet[count.index]

  # user_data = ""

  root_block_device {
    volume_size = var.vol_size # 10 default size

  }

}



