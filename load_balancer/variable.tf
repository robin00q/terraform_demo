#########
# External VPC
#########
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

#########
# External EC2
#########
variable "compute-cloud-ids" {
  type = list(string)
}

########
# Internal
########
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