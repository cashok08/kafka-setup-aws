# -- loadbalancer/variables.tf --
# this gets loaded from networking module
variable "public_sg" {

}

variable "public_subnets" {

}

variable "vpc_id" {

}


variable "kafka_lb_tg_port" {
  type = number
}

variable "kafka_lb_tg_protocol" {
  type = string
}
variable "kafka_lb_healthy_threshold" {
  type = number
}


variable "kafka_lb_unhealthy_threshold" {
  type = number
}

variable "kafka_lb_timeout" {
  type = number
}

variable "kafka_lb_interval" {
  type = number
}


variable "kafka_lb_listener_port" {
  type = number
}

variable "kafka_lb_listener_protocol" {
  type = string
}