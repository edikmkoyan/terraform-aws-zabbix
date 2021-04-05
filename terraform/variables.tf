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

variable "key_path" {
  default = "/home/karen/.ssh/id_rsa.pub"
}

variable "instance_types" {
  type = map
  default = {
    "server" = "t2.micro",
    "database" = "t2.micro",
    "frontend" = "t2.micro"
    "proxy" = "t2.micro"
  }
}

variable "instance_amis" {
  type = map
  default = {
    "server" = "ami-0767046d1677be5a0",
    "database" = "ami-0767046d1677be5a0",
    "frontend" = "ami-0767046d1677be5a0"
    "proxy" = "ami-0767046d1677be5a0"
  }
}

variable "zabbix_server_ingress_rules" {
  default = [{
    "description" = "Allow SSH"
    "port" = 22
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow connect to Zabbix server port"
    "port" = 10051
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow ICMP"
    "port" = -1
    "protocol" = "icmp"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

variable "zabbix_proxy_ingress_rules" {
  default = [{
    "description" = "Allow SSH"
    "port" = 22
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  ]
}


variable "zabbix_db_ingress_rules" {
  default = [{
    "description" = "Allow SSH"
    "port" = 22
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow connect to Zabbix database port"
    "port" = 3306
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow ICMP"
    "port" = -1
    "protocol" = "icmp"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

variable "zabbix_frontend_ingress_rules" {
  default = [{
    "description" = "Allow SSH"
    "port" = 22
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow connect to Zabbix frontend port"
    "port" = 80
    "protocol" = "tcp"
    "cidr_block" = ["0.0.0.0/0"]},
  {
    "description" = "Allow ICMP"
    "port" = -1
    "protocol" = "icmp"
    "cidr_block" = ["0.0.0.0/0"]}
 ]
}

variable "zabbix_server_engress_rules" {
  default = [{
    "port" = 0
    "protocol" = "-1"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

variable "zabbix_db_engress_rules" {
  default = [{
    "port" = 0
    "protocol" = "-1"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

variable "zabbix_frontend_engress_rules" {
  default = [{
    "port" = 0
    "protocol" = "-1"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

variable "zabbix_proxy_engress_rules" {
  default = [{
    "port" = 0
    "protocol" = "-1"
    "cidr_block" = ["0.0.0.0/0"]}
  ]
}

