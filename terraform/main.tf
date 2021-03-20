terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}
provider "aws" {
  profile = "default"
  region  = var.region
}

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

resource "aws_security_group" "server_sg" {
  name = "security_group_zabbix_server"
  description = "Security group for zabbix server"
  vpc_id = aws_vpc.main.id
  dynamic ingress {
    for_each = var.zabbix_server_ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block 
    }
  }
  dynamic egress {
    for_each = var.zabbix_server_engress_rules
    content {
      from_port = egress.value.port
      to_port = egress.value.port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_block 
    }
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

resource "aws_instance" "server_instance" {
    instance_type     = var.instance_types["server"]
    ami               = var.instance_amis["server"]
    vpc_security_group_ids = [aws_security_group.server_sg.id]
    key_name = aws_key_pair.zabbix_key.id
    subnet_id = aws_subnet.main_subnet.id
    tags = {
      Name = "zabbix-server"
    }
    depends_on = [aws_instance.database_instance]
}

resource "aws_security_group" "database_sg" {
  name = "security_group_zabbix_database"
  description = "Security group for zabbix database"
  vpc_id = aws_vpc.main.id
  dynamic ingress {
    for_each = var.zabbix_db_ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks =ingress.value.cidr_block 
    }
  }
  dynamic egress {
    for_each = var.zabbix_db_engress_rules
    content {
      from_port = egress.value.port
      to_port = egress.value.port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_block 
    }
  }
}

resource "aws_instance" "database_instance" {
    instance_type     = var.instance_types["database"]
    ami               = var.instance_amis["database"]
    key_name = aws_key_pair.zabbix_key.id
    vpc_security_group_ids = [aws_security_group.database_sg.id]
    subnet_id = aws_subnet.main_subnet.id
    tags = {
      Name = "zabbix-database"
    }
}

resource "aws_security_group" "frontend_sg" {
  name = "security_group_zabbix_frontend"
  description = "Security group for zabbix frontend"
  vpc_id = aws_vpc.main.id
  dynamic ingress {
    for_each = var.zabbix_frontend_ingress_rules
    content {
      description = ingress.value.description
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_block 
    }
  }
  dynamic egress {
    for_each = var.zabbix_server_engress_rules
    content {
      from_port = egress.value.port
      to_port = egress.value.port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_block 
    }
  }
}

resource "aws_instance" "frontend_instance" {
    instance_type     = var.instance_types["frontend"]
    ami               = var.instance_amis["frontend"]
    key_name = aws_key_pair.zabbix_key.id
    vpc_security_group_ids = [aws_security_group.frontend_sg.id]
    subnet_id = aws_subnet.main_subnet.id
    tags = {
      Name = "zabbix-frontend"
    }
    depends_on = [aws_instance.database_instance, aws_instance.server_instance]
}
