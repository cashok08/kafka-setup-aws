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

resource "aws_key_pair" "kafka_ssh_tf_key" {
  key_name = var.key_name
  # using file module to extract the contents of generated key
  # path can be dynamic # moved the .pub manually to same directory
  # should use ${path.root}/
  public_key = file(var.public_key_path)
}

resource "aws_instance" "kafka_node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.server_ami.id
  tags = {
    # dec is decimal of random id
    Name = "kafka_node - ${random_id.kafka_node_id[count.index].dec}"
  }
  # key_name
  key_name = aws_key_pair.kafka_ssh_tf_key.id


  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]

  user_data = templatefile(var.user_data_path,
  {
    swapvalue = "1"
  }
  
  )

  root_block_device {
    volume_size = var.vol_size # 10 default size

  }

}



