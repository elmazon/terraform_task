resource "aws_instance" "test1" {
  ami           = "ami-083ac7c7ecf9bb9b0"
  instance_type = "t2.micro"
  key_name = "MyKey"
  subnet_id = var.private_subnet1_nat_id
  security_groups = [var.security_group_ec2_id]
  private_ip = "10.0.3.120"
  user_data = "${file("install_httpd.sh")}"
  tags = {
    Name = "${var.name_tag}-${var.env}-ec2"
  }
}

resource "aws_instance" "test2" {
  ami           = "ami-083ac7c7ecf9bb9b0"
  instance_type = "t2.micro"
  key_name = "MyKey"
  subnet_id = var.private_subnet2_nat_id
  private_ip = "10.0.4.121"
  security_groups = [var.security_group_ec2_id]
  user_data = "${file("install_httpd.sh")}"
  tags = {
    Name = "${var.name_tag}-${var.env}-ec2_backup"
  }
}


###### OUTPUTS ######
output "ec2_test1_id" {
    value = aws_instance.test1.id
}

output "ec2_test2_id" {
    value = aws_instance.test2.id
}