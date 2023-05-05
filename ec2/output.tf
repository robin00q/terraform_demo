output "sjlee-ec2-ids" {
  value = aws_instance.sjlee-public-subnet-ec2.*.id
}