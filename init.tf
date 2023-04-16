# backend S3 설정
resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.account_id}-ap-northeast-2-tfstate"
}

resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = aws_s3_bucket.tfstate.id

  versioning_configuration {
    status = "Enabled"
  }
}

# backend dynamoDB 설정
resource "aws_dynamodb_table" "tfstate_lock" {
  name = "terraform-lock"
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
    bucket = "sjlee-terraform-demo-ap-northeast-2-tfstate"
    dynamodb_table = "terraform-lock"
    region = "ap-northeast-2"
    key = "sjlee/terraform/demo/terraform.tfstate"
  }
}