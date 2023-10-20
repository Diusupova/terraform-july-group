provider aws {
    region = var.region
}
resource "aws_vpc" "project2" {
  cidr_block = var.vpc_cidr
  
  tags = {
    Name = "project2"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.project2.id
  cidr_block = var.subnet_cidr1
  availability_zone = var.az1
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Sub1"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.project2.id
  cidr_block = var.subnet_cidr2
  availability_zone = var.az2
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Sub2"
  }
}
resource "aws_subnet" "sub3" {
  vpc_id     = aws_vpc.project2.id
  cidr_block = var.subnet_cidr3
  availability_zone = var.az3
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Sub3"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project2.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "route_tab" {
  vpc_id = aws_vpc.project2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  
  tags = {
    Name = "route-table"
  }
}
resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.route_tab.id
}
resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.route_tab.id
}
resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.route_tab.id
}