# -- loadbalancer/main.tf -- 

resource "aws_lb" "kafka_lb" {
  name = "kafka-loadbalancer"
  subnets = var.public_subnets
  security_groups = [var.public_sg]
  # hardcoded the timeout
  idle_timeout = 400
}