locals {
  playbook  = "${path.cwd}/${var.zabbix_playbook}"
  scripts_folder = "${path.root}/scripts"
#  root           = path.root
}

source "amazon-ebs" "basic-example" {
  region        = var.region
#  source_ami    =var.src_image["ubuntu_frankfurt"] 
#  source_ami    =var.src_image["ubuntu_frankfurt"] 
  instance_type = var.instance_types["small"]
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
    playbook_file = local.playbook
  }
}

