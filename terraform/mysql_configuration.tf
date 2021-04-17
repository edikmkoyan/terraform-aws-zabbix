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
