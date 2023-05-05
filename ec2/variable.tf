###########
# External
###########
variable "vpc-id" {
  type = string
}

variable "vpc-name" {
  type = string
}

variable "vpc-cidr-block" {
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

variable "listener-listen-port" {
  type = number
  default = 80
}

variable "listener-listen-protocol" {
  type = string
  default = "HTTP"
}

variable "target-group-service-port" {
  type = number
  default = 8080
}