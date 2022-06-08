#  -- networking/main.tf ---

data "aws_availability_zones" "available" {

}



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
   
    #availability_zone = ["ap-southeast-1a","ap-southeast-1b","ap-southeast-1c"][count.index]
    # TODO this works only for 3 AZ regions
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
        # this will create subnet 1 , 2, 3 
        Name = "kafka_subnet_${count.index + 1 }"
    }
}

# Associate every subnet to route table 

resource "aws_route_table_association" "kafka_public_assoc" {
    count = 3
    subnet_id = aws_subnet.kafka_subnet.*.id[count.index]
    route_table_id = aws_route_table.kafka_public_rt.id
  
}

resource "aws_internet_gateway" "kafka_internet_gateway" {
  vpc_id = aws_vpc.kafka_vpc.id

  tags = {
      Name = "kafka_igw"
  }
}

resource "aws_route_table" "kafka_public_rt" {
  vpc_id = aws_vpc.kafka_vpc.id

  tags = {
    Name = "kafka_public"
  }
}


  # This is not the same as subnet default route table
resource "aws_route" "default_route" {
  route_table_id = aws_route_table.kafka_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  # Via Internet Gateway that we created `kafka_internet_gateway`

  gateway_id = aws_internet_gateway.kafka_internet_gateway.id
}

