######### PRIVATE SUBNET GROUP #########
resource "aws_db_subnet_group" "ps_group" {
  name       = "private_subnet_db_group "
  subnet_ids = [var.private_subnet3_id, var.private_subnet4_id]

  tags = {
    Name = "${var.name_tag}-${var.env}-ps_db_group"
  }
}



############### DB INSTACE ###############
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.ps_group.name
  vpc_security_group_ids = [var.security_group_rds_id]
  skip_final_snapshot  = true
}
####