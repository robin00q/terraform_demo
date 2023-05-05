##########
# Elastic IP form Nat Gateway
##########
resource "aws_eip" "sjlee-terraform-aws-eip" {
  count = length(var.availability_zones)

  vpc = true # VPC 에서 사용하는 EIP

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.vpc_name}-elastic-ip-${count.index}"
  }
}

##########
# NAT Gateway
# private subnet -> NAT Gateway -> router -> Internet Gateway -> internet
# elastic IP 가 필요하다.
# - 중간에서 GW 역할을 하려면 당현히 주소가 있어야함
##########
resource "aws_nat_gateway" "sjlee-nat-gateway" {
  count = length(var.availability_zones)

  subnet_id = element(aws_subnet.sjlee-public-subnet.*.id, count.index)
  allocation_id = element(aws_eip.sjlee-terraform-aws-eip.*.id, count.index) # allocate EIP

  tags = {
    Name = "${var.vpc_name}-nat-gw-${count.index}"
  }
}