##########
# Security Group For External ALB
# IN
# - TCP (from : 80, to : 80)
# OUT
# - ANY
##########
resource "aws_security_group" "sjlee-security-group-for-external-alb" {
  name = "${var.vpc-name}-external-alb-security-group"
  vpc_id = var.vpc-id

  # Allow 80 port
  ingress {
    from_port = 80 # HTTP Port
    to_port   = 80 # HTTP Port
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0 # any port
    to_port   = 0 # any port
    protocol  = "-1" # any protocol
    cidr_blocks = [var.vpc-cidr-block]
  }
}

##########
# External ALB
##########
resource "aws_alb" "sjlee-external-aws-alb" {
  name = "${var.vpc-name}-external-alb"
  subnets = var.public-subnet-ids
  internal = false

  security_groups = [
    # security group 연결
    aws_security_group.sjlee-security-group-for-external-alb.id
  ]
}

##########
# External ALB Target Group
##########
resource "aws_alb_target_group" "sjlee-alb-target-group" {
  name = "${var.vpc-name}-t-group"
  port = var.target-group-service-port
  protocol = "HTTP"
  vpc_id = var.vpc-id
  # target_type = "instance" # default

  health_check {
    path               = "/"
    port               = var.target-group-service-port
    protocol           = "HTTP"
    timeout            = 5
    interval           = 30
    healthy_threshold  = 3
    unhealthy_threshold = 3
  }
}

##########
# External ALB Listener
# 1. ALB 붙임
# 2. target group 붙임
##########
resource "aws_alb_listener" "sjlee-external-alb-listener" {
  # arn = Amazon Resource Number
  load_balancer_arn = aws_alb.sjlee-external-aws-alb.arn
  port = var.listener-listen-port
  protocol = var.listener-listen-protocol

  default_action {
    target_group_arn = aws_alb_target_group.sjlee-alb-target-group.arn
    type = "forward"
  }
}