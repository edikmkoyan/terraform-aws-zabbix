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


