# backend S3 설정
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.tfstate_s3_bucket_name}"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning_1" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

# backend dynamoDB 설정
resource "aws_dynamodb_table" "tfstate_lock_1" {
  name = "${var.tfstate_dynamo_lock_name}"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# backend setting (`terraform init`)
terraform {
  backend "s3" {
    bucket = "sjlee-terraform-tfstate-bucket-1"
    dynamodb_table = "sjlee-terraform-tfstate-dynamo-1"
    region = "ap-northeast-2"
    key = "sjlee/terraform/demo/terraform.tfstate"
  }
}

# VPC Module
module "module-vpc" {
  source = "./vpc"
}

# LB Module
module "load-balancer" {
  source = "./load_balancer"

  vpc_id = module.module-vpc.sjlee-terraform-aws-vpc-id
  vpc_name = module.module-vpc.sjlee-terraform-aws-vpc-name
  public_subnet_ids = module.module-vpc.sjlee-terraform-public-aws-subnet-ids
  compute_cloud_ids = module.ec2.sjlee-terraform-compute-cloud-ids
}

module "ec2" {
  source = "./ec2"

  vpc_id = module.module-vpc.sjlee-terraform-aws-vpc-id
  public_subnet_ids = module.module-vpc.sjlee-terraform-public-aws-subnet-ids
}