############### PUBLIC ROUTE ###############

###### IGW ######
resource "aws_internet_gateway" "gw" {
  vpc_id = var.my_vpc_id
  tags = {
    Name = "${var.name_tag}-${var.env}-igw"
  }
}

###### PUBLIC ROUTE ######
resource "aws_route_table" "public_rt" {
  vpc_id = var.my_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.name_tag}-${var.env}-public_rt"
  }
}

############## PRIVATE ROUTE WITH NAT ##############
###### EIP AND NAT ######
resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.lb.id
  subnet_id     = var.public_subnet1_id

  tags = {
    Name = "${var.name_tag}-${var.env}-nat"
  }
  depends_on = [aws_internet_gateway.gw]
}


###### PRIVATE ROUTE ######
resource "aws_route_table" "private_rt_nat" {
  vpc_id = var.my_vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.name_tag}-${var.env}-privat_rt_nat"
  }
}  

#################### PRIVATE ROUTE   ####################
resource "aws_route_table" "private_rt" {
  vpc_id = var.my_vpc_id
  tags = {
    Name = "${var.name_tag}-${var.env}-private_rt"
  }
}


################################ ROUTE TABLE ASSOCIATION ################################
###### PUBLIC ROUTE TABLE ASSOCIATION ######
resource "aws_route_table_association" "publicas1" {
  subnet_id      = var.public_subnet1_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "publicas2" {
  subnet_id      = var.public_subnet2_id
  route_table_id = aws_route_table.public_rt.id
}

###### PRIVATE ROUT TABLE NAT ASSOCIATION ######
resource "aws_route_table_association" "privateas1nat" {
  subnet_id      = var.private_subnet1_nat_id
  route_table_id = aws_route_table.private_rt_nat.id
}

resource "aws_route_table_association" "privateas2nat" {
  subnet_id      = var.private_subnet2_nat_id
  route_table_id = aws_route_table.private_rt_nat.id
}


###### PRIVATE ROUTE TABLE ASSOCIATION ######
resource "aws_route_table_association" "privateas3" {
  subnet_id      = var.private_subnet3_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "privateas4" {
  subnet_id      = var.private_subnet4_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "privateas5" {
  subnet_id      = var.private_subnet5_id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "privateas6" {
  subnet_id      = var.private_subnet6_id
  route_table_id = aws_route_table.private_rt.id
}

