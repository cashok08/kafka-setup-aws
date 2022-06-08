#  -- networking/main.tf ---

# To deploy 100 VPCs and each VPC gets a random ID
resource "random_integer" "random" {
  min = 1
  max = 100

}

resource "aws_vpc" "kafka_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
      Name = "kafka_vpc-${random_integer.random.id}"
  }
}