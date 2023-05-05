###########
# External
###########
variable "vpc-id" {
  type = string
}

variable "public-subnet-ids" {
  type = list(string)
}

###########
# Internal
###########
variable "amazon-linux-2-ami-x86" {
  type = string
  default = "ami-03db74b70e1da9c56"
}

variable "t2-micro" {
  type = string
  default = "t2.micro"
}