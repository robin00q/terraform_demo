variable "account_id" {
  type = string
  default = "sjlee-terraform-demo"
}

variable "tfstate_s3_bucket_name" {
  type = string
  default = "sjlee-terraform-tfstate-bucket-1"
}

variable "tfstate_dynamo_lock_name" {
  type = string
  default = "sjlee-terraform-tfstate-dynamo-1"
}

variable "ap_northeast_2" {
  type = string
  default = "ap-northeast-2"
}