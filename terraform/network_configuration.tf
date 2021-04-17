resource "aws_key_pair" "zabbix_key"{
  key_name = "zabbix"
  public_key = file(var.key_path)
}

resource "aws_subnet" "main_subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.main_subnet
    map_public_ip_on_launch = true
    tags = {
        Name = "main_subnet"
    }
}

resource "aws_route_table_association" "main_subnet" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_vpc" "main" {
  cidr_block       = var.main_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "Igw"
    }
}
