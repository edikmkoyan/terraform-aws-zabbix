locals {
  playbook = "${path.cwd}/${var.zabbix_playbook}"
}

source "amazon-ebs" "aws_zabbix" {
  region = var.region
  #  source_ami    =var.src_image["ubuntu_frankfurt"] 
  instance_type = var.instance_types["small"]
  ssh_username  = "ubuntu"
  ami_name      = var.ami_name
  communicator  = "ssh"
  profile       = var.credential_profile
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

source "virtualbox-iso" "vb_zabbix" {
  guest_os_type = "Ubuntu_64"
  iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"
  iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
  cpus             = "1"
  memory           = "2048"
  disk_size        = "10240"
  ssh_username = "ubuntu"
  ssh_timeout = "2m"
#  ssh_password = "packer"
  pause_before_connecting = "3m"
  headless = true
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
}



build {
  sources = [
    "source.amazon-ebs.aws_zabbix",
    "sources.virtualbox-iso.vb_zabbix"
  ]

  provisioner "ansible" {
    playbook_file = local.playbook
  }

#  post-processor "vagrant" {
#    keep_input_artifact = true
# #   provider_override   = "virtualbox"
#  }
}


