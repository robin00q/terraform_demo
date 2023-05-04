resource "aws_instance" "sjlee-terraform-public-subnet-aws-instance" {
  count = length(var.public_subnet_ids)

  ami = "ami-03db74b70e1da9c56"
  instance_type = "t2.micro"
  associate_public_ip_address = true # EC2 에 public IP 주소 할당할 것인지에 대한 여부
  vpc_security_group_ids = [aws_security_group.sjlee-terraform-aws-security-group-for-aws-instance.id]

  # sudo yum install java-17-amazon-corretto
  # sudo yum install git

  subnet_id = element("${var.public_subnet_ids.*}", count.index)
}

resource "aws_security_group" "sjlee-terraform-aws-security-group-for-aws-instance" {
  name = "public-subnet-aws-security-group"
  vpc_id = var.vpc_id

  # Allow 8080 port
  ingress {
    from_port = 8080 # HTTP Port
    to_port   = 8080 # HTTP Port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22 # HTTP Port
    to_port   = 22 # HTTP Port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80 # HTTP Port
    to_port   = 80 # HTTP Port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443 # HTTP Port
    to_port   = 443 # HTTP Port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0 # any port
    to_port   = 65535 # any port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}