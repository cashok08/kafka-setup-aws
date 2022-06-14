# -- loadbalancer/main.tf -- 

resource "aws_lb" "kafka_lb" {
  name            = "kafka-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  # hardcoded the timeout
  idle_timeout = 400
}

# target group for lb which will receive traffic from listener port of lb
resource "aws_lb_target_group" "kafka_tg" {
  # Generating a random name but this will make tf to replace :(
  name     = "kafka-lb-tg-${substr(uuid(), 0, 3)}"
  port     = var.kafka_lb_tg_port     # Port numbers should be bootstrap servers port 9092
  protocol = var.kafka_lb_tg_protocol # "HTTP"
  vpc_id   = var.vpc_id               # Get from networking module

  # hardcoded
  health_check {
    healthy_threshold   = var.kafka_lb_healthy_threshold   # 2
    unhealthy_threshold = var.kafka_lb_unhealthy_threshold # 2
    timeout             = var.kafka_lb_timeout             # 3
    interval            = var.kafka_lb_interval            # 30
  }
}

resource "aws_lb_listener" "kafka_lb_listener" {
  # Get from tf state file o/p
  load_balancer_arn = aws_lb.kafka_lb.arn
  port              = var.kafka_lb_listener_port     # 80 ( No SSL )
  protocol          = var.kafka_lb_listener_protocol # HTTP
  # Action that happens (default) after a request(s) hit listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.kafka_tg.arn
  }
}