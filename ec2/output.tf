output "sjlee-terraform-compute-cloud-ids" {
  value = aws_instance.sjlee-terraform-public-subnet-aws-instance.*.id
}