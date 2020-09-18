module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "asg-lb"
  vpc_id      = var.vpc-id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}




resource "aws_lb" "alb" {
  name               = var.naming.application_load_balancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ module.security_group.this_security_group_id ]
  subnets            = var.subnet-ids 

  enable_deletion_protection = true

  access_logs {
    bucket  = var.s3-id
    prefix  = "my-lb"
    enabled = true
  }

  tags = var.naming.tags
}

resource "aws_lb_target_group" "tg" {
  name     = var.naming.target_group
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id

  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay
  health_check {
    path                = var.health_check.path
    interval            = var.health_check.interval
    timeout             = var.health_check.timeout
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }
  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.stickiness.cookie_duration
    enabled         = var.stickiness.enabled
  }

  tags = var.naming.tags

  depends_on = [aws_lb.alb]
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener" "front_end_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}