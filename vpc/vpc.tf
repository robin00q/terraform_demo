##########
# VPC
##########
resource "aws_vpc" "sjlee-vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}