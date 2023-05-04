variable "vpc_name" {
  type = string
  description = "Name of VPC"
  default = "sjlee-terraform-vpc"
}

variable "availability_zones" {
  type = list
  default = [
    "ap-northeast-2a",
    "ap-northeast-2c"
  ]
}

variable "cidr_number_public" {
  type = list
  default = ["0", "1"]
}

variable "cidr_number_private" {
  type = list
  default = ["4", "5"]
}