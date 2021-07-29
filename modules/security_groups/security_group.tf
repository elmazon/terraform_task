#################### SECURITY GROUPS ####################
###### SECURITY GROUPS FOR EC2 ######
resource "aws_security_group" "allow_from_lb" {
  name        = "${var.name_tag}-${var.env}-ec2-sg"
  description = "Allow http inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"] 
    security_groups =  [aws_security_group.lb_sg.id] 
  }
    ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    #cidr_blocks      = ["0.0.0.0/0"] 
    security_groups =  [aws_security_group.lb_sg.id] 
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name_tag}-${var.env}-ec2-sg"
  }
}

###### SECURITY GROUP FOR LOAD BALANCER ######
resource "aws_security_group" "lb_sg" {
  name        = "${var.name_tag}-${var.env}-lb-sg"
  description = "Allow http inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] 
      
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name_tag}-${var.env}-lb-sg"
  }
}

###### SECURITY GROUP FOR RDS ######
resource "aws_security_group" "rdssg" {
  name = "${var.name_tag}-${var.env}-rds_sg"
  vpc_id =  var.my_vpc_id

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = [var.private_subnet_1_nat_cidr_block, var.private_subnet_2_nat_cidr_block]
      #security_groups = aws_security_group.sg1.id

  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]

  }
}

###### OUTPUTS ######

output "security_group_ec2_id" {
  value = aws_security_group.allow_from_lb.id
}

output "security_group_lb_id" {
  value = aws_security_group.lb_sg.id
}

output "security_group_rds_id" {
  value = aws_security_group.rdssg.id
} 
###### end of file ######