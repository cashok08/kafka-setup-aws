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
    /*
    kafkaaa_sg = {
      name        = "kafkaaa_sg"
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
         custom_tcp3 = {
          description = "Kafka Broker Topics UI"
          from        = 8081
          to          = 8081
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
         custom_tcp2 = {
          description = "Kafka Broker Topics"
          from        = 8082
          to          = 8082
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
         custom_tcp2 = {
          description = "Kafka Broker jump"
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }*/
rdsss_sg = {
      name        = "rdsss_sg"
      description = "Security Group for RDS"
      ingress = {
        
        custom_tcp = {
          description = "Ingress access"
          from        = 5432
          to          = 5432
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
      egress = {
        
        custom_tcp = {
          description = "Egress access"
          from        = 5432
          to          = 5432
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }

  }
}