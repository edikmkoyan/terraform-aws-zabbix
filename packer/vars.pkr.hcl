variable "region" {
  type = string
  default = "eu-central-1"
}

variable "src_image" {
#  type = map
  default = {
     "ubuntu_frankfurt" = "ami-0767046d1677be5a0"
     "ubuntu_oregon" = "ami-0ca5c3bd5a268e7db"
	 "custom_ubuntu_frankfurt" = ""
	 "custom_ubuntu_oregon" = ""
	}
}

variable "instance_types" {
#  type = map
  default =  {
       "small" = "t2.micro"
       "medium" = "t2.medium"
       "large" = "t2.xlarge"
	 }
}


variable "zabbix_playbook" {
  type = string
  default = "zabbix_proxy_playbook.yml" 
	 
}

