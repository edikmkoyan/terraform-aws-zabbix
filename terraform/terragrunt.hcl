locals {
  proxy_content = [{"region": "eu-central-1", "alias": "reg1", "vpc_id": "vpc-9424a3fe", "subnet_id": "subnet-4958f005"},
                   {"region": "eu-central-1", "alias": "reg2", "vpc_id": "vpc-9424a3fe", "subnet_id": "subnet-4958f005"}, 
                   {"region": "eu-central-1", "alias": "reg3", "vpc_id": "vpc-9424a3fe", "subnet_id": "subnet-4958f005"}]
}

terraform {
  extra_arguments "common_vars" {
    commands = ["apply"]
    arguments = [
      "-var-file=./zabbix_variables.tfvars"
    ]
  }
}

generate "provider" {
  path    = "providers_for_proxy.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
%{for provider in local.proxy_content}
provider "aws" {
  region = "${provider.region}"
  alias  = "${provider.alias}"
}
%{endfor}
EOF
}

generate "aws_instance" {
  path = "instances_for_proxy.tf"
  if_exists = "overwrite_terragrunt"
  contents= <<-EOF
%{for provider in local.proxy_content}
resource "aws_instance" "proxy_instance_${provider.alias}" {
  ami = var.instance_amis["proxy"]
  instance_type = var.instance_types["proxy"]
  provider = aws.${provider.alias}
  vpc_security_group_ids = [aws_security_group.proxy_sg_${provider.alias}.id]
  subnet_id = "${provider.subnet_id}"
  tags = {
    Name = "proxy-${provider.alias}"
  }
}
%{endfor}
EOF
}

generate "security_group" {
  path = "security_group_for_proxy.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
%{for content in local.proxy_content}
  resource "aws_security_group" "proxy_sg_${content.alias}" {
    vpc_id = "${content.vpc_id}"
    provider = aws.${content.alias}
    dynamic ingress {
      for_each = var.zabbix_proxy_ingress_rules
      content {
        description = ingress.value.description
        from_port = ingress.value.port
        to_port = ingress.value.port
        protocol = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_block
      }
    }
    dynamic egress {
      for_each = var.zabbix_proxy_engress_rules
      content {
        from_port = egress.value.port
        to_port = egress.value.port
        protocol = egress.value.protocol
        cidr_blocks = egress.value.cidr_block
      }
    }
  }
%{endfor}
EOF
}
