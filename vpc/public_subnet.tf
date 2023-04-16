##########
# public subnet
##########
resource "aws_subnet" "sjlee-terraform-public-aws-subnet" {
  count = length(var.availability_zones)

  vpc_id = aws_vpc.sjlee-terraform-aws-vpc.id

  cidr_block = "10.0.${var.cidr_number_public[count.index]}.0/24"
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
resource "aws_route_table" "sjlee-terraform-public-subnet-aws-route-table" {
  vpc_id = aws_vpc.sjlee-terraform-aws-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sjlee-terraform-aws-internet-gateway.id
  }

  tags = {
    Name = "${var.vpc_name}-public-subnet-route-table"
  }
}

##########
# attach [public subnet & public subnet routing table]
##########
resource "aws_route_table_association" "sjlee-terraform-public-subnet-aws-route-table-association" {
  count = length(var.availability_zones)

  subnet_id = element(aws_subnet.sjlee-terraform-public-aws-subnet.*.id, count.index)
  route_table_id = aws_route_table.sjlee-terraform-public-subnet-aws-route-table.id
}