region = "eu-central-1"
main_vpc_cidr = "10.0.0.0/16"
server_port = 10051
database_port = 3306
frontend_port = 80
main_subnet = "10.0.1.0/24"
key_path = "/home/karen/.ssh/id_rsa.pub"
instance_types = {"server" = "t2.micro",
                  "database" = "t2.micro",
                  "frontend" = "t2.micro"}
instance_amis = {"server" = "ami-0767046d1677be5a0",
                 "database" = "ami-0767046d1677be5a0",
                 "frontend" = "ami-0767046d1677be5a0"}
zabbix_server_ingress_rules = [
                {
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
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_db_ingress_rules = [
                {
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
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_frontend_ingress_rules = [
                {
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
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_server_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_db_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_frontend_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"
                  "cidr_block" = ["0.0.0.0/0"]}]

