# Provide Elastic Load Balancer and attach instances
resource "aws_lb" "lb" {
  name               = "aws-homework-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_group_id

  enable_deletion_protection = false

  tags = {
    owner = var.tag_owner
    Name = "aws-homework-lb"
  }
}

resource "aws_lb_target_group" "lb-tg" {
  name     = "aws-homework-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  tags = {
    owner = var.tag_owner
    Name = "aws-homework-lb-tg"
  }
}

resource "aws_lb_target_group_attachment" "lb-tg-attachmets" {
  count            = length(var.subnet_ids)
  target_group_arn = aws_lb_target_group.lb-tg.arn
  target_id        = aws_instance.wordpress-servers[count.index].private_ip
  port             = 80
}

resource "aws_lb_listener" "wordpress" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb-tg.arn
  }
}
