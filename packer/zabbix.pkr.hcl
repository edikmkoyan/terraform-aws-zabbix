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
  iso_url = "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso"
  iso_checksum = "sha256:f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  cpus             = var.hw_resources["cpu"]
  memory           = var.hw_resources["mem"]
  disk_size        = var.hw_resources["disk_size"]
  ssh_username = var.ssh_params["username"]
  ssh_timeout =  var.ssh_params["timeout"]
  ssh_password = var.ssh_params["password"]
  pause_before_connecting = var.ssh_params["pause_before_connecting"]
  output_directory = var.output_dir 
  headless = false
  http_directory = "/"
  boot_command = [
        "<esc><wait>",
        "<esc><wait>",
        "<enter><wait>",
        "/install/vmlinuz",
        " auto=true",
        " url=https://raw.githubusercontent.com/geerlingguy/packer-boxes/b82c32943bb264d465397bd229842f8291564e30/ubuntu2004/http/preseed.cfg",
        " locale=en_US<wait>",
        " console-setup/ask_detect=false<wait>",
        " console-setup/layoutcode=us<wait>",
        " console-setup/modelcode=pc105<wait>",
        " debconf/frontend=noninteractive<wait>",
        " debian-installer=en_US<wait>",
        " fb=false<wait>",
        " initrd=/install/initrd.gz<wait>",
        " kbd-chooser/method=us<wait>",
        " keyboard-configuration/layout=USA<wait>",
        " keyboard-configuration/variant=USA<wait>",
        " netcfg/get_domain=vm<wait>",
        " netcfg/get_hostname=vagrant<wait>",
        " grub-installer/bootdev=/dev/sda<wait>",
        " noapic<wait>",
        " -- <wait>",
        "<enter><wait>"
      ]
  shutdown_command = "echo ${var.ssh_params["password"]} | sudo deluser --remove-home ${var.ssh_params["username"]}; echo ${var.ssh_params["password"]} | sudo -S shutdown -P now"
}


build {
  sources = [
    "source.amazon-ebs.aws_zabbix",
  ]
  provisioner "ansible" {
    playbook_file = local.playbook

  }

}

build {
  sources = [
    "sources.virtualbox-iso.vb_zabbix"
  ]

  provisioner "ansible" {
    playbook_file = local.playbook
	extra_arguments = [ "--extra-vars", "ansible_sudo_pass=${var.ssh_params["password"]}" ]

  }

  post-processor "vagrant" {
    keep_input_artifact = true
  }
}


