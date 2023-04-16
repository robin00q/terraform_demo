output "sjlee-terraform-aws-vpc-id" {
  value = aws_vpc.sjlee-terraform-aws-vpc.id
}

output "sjlee-terraform-aws-vpc-name" {
  value = aws_vpc.sjlee-terraform-aws-vpc.tags.Name
}

output "sjlee-terraform-public-aws-subnet-id" {
  value = aws_subnet.sjlee-terraform-public-aws-subnet.*.id
}