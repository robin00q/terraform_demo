##########
# Internet Gateway
# public subnet -> router -> internet
##########
resource "aws_internet_gateway" "sjlee-terraform-aws-internet-gateway" {
  vpc_id = aws_vpc.sjlee-terraform-aws-vpc.id

  tags = {
    Name = "${var.vpc_name}-internet-gw"
  }
}