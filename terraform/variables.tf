variable "region" {
  default = "eu-central-1"
}

variable "main_vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "server_port" {
  default = 10051
}

variable "database_port" {
  default = 3306
}

variable "frontend_port" {
  default = 80
}

variable "main_subnet" {
  default = "10.0.1.0/24"
}

variable "instance_types" {
  type = "map"
  default = {
    "server" : "t2.micro",
    "database" : "t2.micro",
    "frontend" : "t2.micro",
  }
}

variable "instance_amis" {
  type = "map"
  default = {
    "server" : "ami-0767046d1677be5a0",
    "database" : "ami-0767046d1677be5a0",
    "frontend" : "ami-0767046d1677be5a0"
  }
}

variable "key" {
  default = "zabbix-key"
}

