# -- root/local.tf ----


locals {
  # Warning ; in this way if you change the VPC tf crashes
  # because internet gateway is updated in place it is not 
  # destroyed and created ; so add life cycle policy for vpc 
  # to create one before destroying
  vpc_cidr = "172.31.0.0/16"
}

locals {
  security_groups = {
    kafka_sg = {
      name        = "kafka_sg"
      description = "Security Group for Kafka and Zookeeper access"
      ingress = {
        ssh = {
          description = "SSH Access to server"
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        custom_tcp = {
          description = "Zookeeper default port access"
          from        = 2181
          to          = 2181
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        custom_tcp1 = {
          description = "Kafka Broker SSL Access"
          from        = 9093
          to          = 9093
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        custom_tcp2 = {
          description = "Kafka Broker Default Access"
          from        = 9092
          to          = 9092
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }
  }
}