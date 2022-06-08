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

resource "aws_subnet" "kafka_subnet" {

    vpc_id = aws_vpc.kafka_vpc.id
    # We need one ZK and Kafka Brokers for each subnet
    count = length(var.public_cidrs)
    # This will loop and pull cidr block from each index of the list
    cidr_block = var.public_cidrs[count.index]

    # this is public subnet so that we can ssh from laptop and outside
    map_public_ip_on_launch = true
    # TODO Remove hardcoding
    availability_zone = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"][count.index]

    tags = {
        # this will create subnet 1 , 2, 3 
        Name = "kafka_subnet_${count.index + 1 }"
    }
}