locals {
  playbook = "${path.cwd}/${var.zabbix_playbook}"
  #  scripts_folder = "${path.root}/scripts"
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

source "virtualbox-iso" "basic-example" {
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
    "sources.virtualbox-iso.basic-example"
  ]

  # provisioner "ansible" {
  #   playbook_file = local.playbook
  # }

}

#build {
#  sources = [
#    "source.amazon-ebs.basic-example",
#    "sources.vmware-iso.basic-example"
#  ]
#
#  provisioner "ansible" {
#    playbook_file = local.playbook
#  }
#
###  post-processor "vagrant" {
###    keep_input_artifact = true
### #   provider_override   = "virtualbox"
###  }
#}
#

#source "vmware-iso" "basic-example" {
#  iso_url          = "http://old-releases.ubuntu.com/releases/precise/ubuntu-12.04.2-server-amd64.iso"
#  iso_checksum     = "md5:af5f788aee1b32c4b2634734309cc9e9"
#  boot_wait        = "10s"
#  remote_type      = "esx5"
#  remote_host      = "host" 
#  remote_datastore = "data"
#  remote_username  = "test"
#  remote_password  =  "test"
#  keep_registered  = true
#  skip_export      = true
#}
