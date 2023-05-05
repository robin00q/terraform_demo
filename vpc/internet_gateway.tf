##########
# Internet Gateway
# public subnet -> router -> internet
##########
resource "aws_internet_gateway" "sjlee-internet-gateway" {
  vpc_id = aws_vpc.sjlee-vpc.id

  tags = {
    Name = "${var.vpc_name}-internet-gw"
  }
}