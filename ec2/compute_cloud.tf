resource "aws_instance" "sjlee-public-subnet-ec2" {
  count = length(var.public-subnet-ids)

  ami = var.amazon-linux-2-ami-x86
  instance_type = var.t2-micro
  associate_public_ip_address = true # EC2 에 public IP 주소 할당할 것인지에 대한 여부
  vpc_security_group_ids = [aws_security_group.sjlee-security-group-for-ec2.id]

  # sudo yum install java-17-amazon-corretto
  # sudo yum install git

  subnet_id = element(var.public-subnet-ids.*, count.index)
}

resource "aws_security_group" "sjlee-security-group-for-ec2" {
  name = "public-subnet-aws-security-group"
  vpc_id = var.vpc-id

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