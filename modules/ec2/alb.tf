resource "aws_lb_target_group" "aws_tg" {
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 10
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
    healthy_threshold   = 2
  }
}

resource "aws_lb" "my-alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  enable_deletion_protection = false 
  subnets            = concat(aws_subnet.terraform_public_subnet_1b[*].id, [var.subnet_id])

}

resource "aws_lb_listener" "my-alb-listner" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
  target_group_arn = aws_lb_target_group.aws_tg.arn
  type             = "forward"
    }
  }

resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  count           = length(aws_instance.myos1)
  target_group_arn = aws_lb_target_group.aws_tg.arn
  target_id       = aws_instance.myos1[count.index].id
}

resource "aws_subnet" "terraform_public_subnet_1b" {
  vpc_id = var.vpc_id
  cidr_block = "192.168.2.0/24" 
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform_public_subnet_1b"
  }
}
