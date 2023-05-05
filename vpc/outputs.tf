output "sjlee-vpc-id" {
  description = "VPC ID"
  value = aws_vpc.sjlee-vpc.id
}

output "sjlee-vpc-name" {
  description = "VPC NAME"
  value = aws_vpc.sjlee-vpc.tags.Name
}

output "sjlee-public-subnet-ids" {
  description = "Public Subnet Ids"
  value = aws_subnet.sjlee-public-subnet.*.id
}

output "sjlee-private-subnet-ids" {
  description = "Private Subnet Ids"
  value = aws_subnet.sjlee-private-subnet.*.id
}