#  -- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.kafka_vpc.id
}

output "public_subnets" {
  value = aws_subnet.kafka_subnet.*.id
}

output "public_sg" {
  value = aws_security_group.kafka_sg["kafka_sg"].id
}