##########
# private subnet
##########
resource "aws_subnet" "sjlee-terraform-private-aws-subnet" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-terraform-aws-vpc.id

  cidr_block = "10.0.${var.cidr_number_private[count.index]}.0/24"
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
resource "aws_route_table" "sjlee-terraform-private-subnet-aws-route-table" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-terraform-aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.sjlee-terraform-aws-nat-gateway.*.id, count.index)
  }

  tags = {
    Name = "${var.vpc_name}-private-subnet-route-table-${count.index}"
  }
}

##########
# attach [privte subnet & privte subnet routing table]
##########
resource "aws_route_table_association" "sjlee-terraform-private-subnet-aws-route-table-association" {
  count = length(var.availability_zones)

  subnet_id = element(aws_subnet.sjlee-terraform-private-aws-subnet.*.id, count.index)
  route_table_id = element(aws_route_table.sjlee-terraform-private-subnet-aws-route-table.*.id, count.index)
}
