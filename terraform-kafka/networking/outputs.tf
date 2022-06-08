#  -- networking/outputs.tf ---

output "vpc_id" {
  value = aws_vpc.kafka_vpc.id
}