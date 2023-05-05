##########
# private subnet
##########
resource "aws_subnet" "sjlee-private-subnet" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-vpc.id

  cidr_block = var.private_cidr_block[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index}"
  }
}

##########
# private subnet routing table
# 0.0.0.0 -> nat-gw
# 10.0.0.0/16 -> local
##########
resource "aws_route_table" "sjlee-private-subnet-route-table" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.sjlee-nat-gateway.*.id, count.index)
  }

  tags = {
    Name = "${var.vpc_name}-private-subnet-route-table-${count.index}"
  }
}

##########
# attach [private subnet & private subnet routing table]
##########
resource "aws_route_table_association" "sjlee-private-subnet-route-table-association" {
  count = length(var.availability_zones)

  subnet_id = element(aws_subnet.sjlee-private-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.sjlee-private-subnet-route-table.*.id, count.index)
}
