###########
# VPC Variable
###########
variable "vpc_name" {
  description = "VPC 의 이름"
  default = "sjlee-vpc"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR"
  default = "10.0.0.0/16"
}

###########
# Subnet Variable
###########
variable "availability_zones" {
  type = list(string)
  default = [
    "ap-northeast-2a",
    "ap-northeast-2c"
  ]
}

variable "public_cidr_block" {
  type = list(string)
  default = [
    "10.0.0.0/24",
    "10.0.1.0/24"
  ]
}

variable "private_cidr_block" {
  type = list(string)
  default = [
    "10.0.4.0/24",
    "10.0.5.0/24"
  ]
}