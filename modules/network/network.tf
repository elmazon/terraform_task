############################## vpc ##############################

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.name_tag}-${var.env}-vpc"
  }

}


######################## SUBNETS ########################

###### PUBLIC SUBNETS ###### 
resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_1_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.name_tag}-${var.env}-pub_sub_1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_2_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.name_tag}-${var.env}-pub_sub_2"
  }
}

###### PRIVATE SUBNETS WITH NAT ######
resource "aws_subnet" "private1nat" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_1_nat_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_1_nat"
  }
}

resource "aws_subnet" "private2nat" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_2_nat_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_2_nat"
  }
}

###### PRIVATE SUBNETS ######
resource "aws_subnet" "private3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_3_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_3"
  }
}

resource "aws_subnet" "private4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_4_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_4"
  }
}

resource "aws_subnet" "private5" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_5_cidr_block
  availability_zone = var.availability_zone_1

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_5"
  }
}

resource "aws_subnet" "private6" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_6_cidr_block
  availability_zone = var.availability_zone_2

  tags = {
    Name = "${var.name_tag}-${var.env}-prv_sub_6"
  }
}

######################### OUTPUTS #########################
output "my_vpc_id" {
    value = aws_vpc.main.id
}

output "public_subnet1_id" {
    value = aws_subnet.public1.id
}

output "public_subnet2_id" {
    value = aws_subnet.public2.id
}

output "private_subnet1_nat_id" {
    value = aws_subnet.private1nat.id
}

output "private_subnet2_nat_id" {
    value = aws_subnet.private2nat.id
}

output "private_subnet3_id" {
    value = aws_subnet.private3.id 
}

output "private_subnet4_id" {
    value = aws_subnet.private4.id 
}

output "private_subnet5_id" {
    value = aws_subnet.private5.id 
}

output "private_subnet6_id" {
    value = aws_subnet.private6.id 
}