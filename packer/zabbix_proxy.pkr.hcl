source "amazon-ebs" "basic-example" {
  region        = "eu-central-1"
#  source_ami    = "ami-009b16df9fcaac611"
  instance_type = "t2.micro"
  ssh_username  = "ubuntu"
  ami_name      = "packer_test_zabbix_agent_{{timestamp}}"
  communicator  = "ssh"
  profile       = "narek"
    source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
}

build {
  sources = [
    "source.amazon-ebs.basic-example"
  ]

  provisioner "ansible" {
    playbook_file = "zabbix_proxy_playbook.yml"
  }
}

