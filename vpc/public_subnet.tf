##########
# public subnet
##########
resource "aws_subnet" "sjlee-public-subnet" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-vpc.id

  cidr_block = var.public_cidr_block[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index}"
  }
}

##########
# public subnet routing table
# 0.0.0.0 -> igw
# 10.0.0.0/16 -> local
##########
resource "aws_route_table" "sjlee-public-subnet-route-table" {
  vpc_id = aws_vpc.sjlee-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sjlee-internet-gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-public-subnet-route-table"
  }
}

##########
# attach [public subnet & public subnet routing table]
##########
resource "aws_route_table_association" "sjlee-public-subnet-route-table-association" {
  count = length(var.availability_zones)

  subnet_id = element(aws_subnet.sjlee-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.sjlee-public-subnet-route-table.id
}