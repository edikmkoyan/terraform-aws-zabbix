variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "src_image" {
  type = string
  default = "ami-0767046d1677be5a0"
    
  #	validation {
  ##    condition     = length(var.src_image) > 4 && substr(var.src_image, 0, 4) == "ami-"
  #    condition     = length(var.src_image[*]) > 4 #&& substr(var.src_image, 0, 4) == "ami-"
  #    error_message = "The image_id value must be a valid AMI id, starting with \"ami-\"."
  #  }
}

variable "instance_types" {
  #  type = map
  default = {
    "small"  = "t2.micro"
    "medium" = "t2.medium"
    "large"  = "t2.xlarge"
  }
}


variable "zabbix_playbook" {
  type = string
  #  default = "zabbix_proxy_playbook.yml" 
  default = "test_playbook.yml"
}

variable "ami_name" {
  type    = string
  default = "zabbix_test"
}

variable "credential_profile" {
  type    = string
  default = "narek"
}

