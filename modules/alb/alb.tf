######################## ALB ########################
###### ALB ######
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_lb_id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  tags = {
    Name = "${var.name_tag}-${var.env}-lb"
  }
}

###### TARGET GROUP ######
resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
  target_type = "instance"
}

###### TARGET GROUP ATTACHMENT ######
resource "aws_lb_target_group_attachment" "instance1" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.ec2_test1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance2" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.ec2_test2_id
  port             = 80
}

###### LOAD BALANCER LISTENER ######
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}