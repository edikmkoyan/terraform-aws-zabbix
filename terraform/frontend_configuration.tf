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
