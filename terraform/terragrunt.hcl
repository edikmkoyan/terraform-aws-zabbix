locals {
  provider_content = [{"region": "eu-central-1", "alias": "reg1"}, {"region": "eu-central-1", "alias": "reg2"}, {"region": "eu-central-1", "alias": "reg3"},]
}

terraform {
  extra_arguments "common_vars" {
    commands = ["apply"]
    arguments = [
      "-var-file=./test.tfvars"
    ]
  }
}

generate "provider" {
  path    = "providers_for_proxy.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
%{for provider in local.provider_content}
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
%{for provider in local.provider_content}
resource "aws_instance" "${provider.alias}" {
  ami = var.instance_amis["proxy"]
  instance_type = var.instance_types["proxy"]
  provider = aws.${provider.alias}
}
%{endfor}
EOF
}
