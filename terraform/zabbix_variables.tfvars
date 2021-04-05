region = "eu-central-1"                                # aws region name
main_vpc_cidr = "10.0.0.0/16"                          # main vpc cidr block
server_port = 10051                                    # port for zabbix server
database_port = 3306                                   # port for zabbix database
frontend_port = 80                                     # port for zabbix frontend
main_subnet = "10.0.1.0/24"                            # main subnet cidr block
key_path = "/home/karen/.ssh/id_rsa.pub"               # ssh public key path
instance_types = {"server" = "t2.micro",                
                  "database" = "t2.micro",             # Zabbix components instance types
                  "frontend" = "t2.micro",
                  "proxy" = "t2.micro"}
instance_amis = {"server" = "ami-0767046d1677be5a0",
                 "database" = "ami-0767046d1677be5a0",
                 "frontend" = "ami-0767046d1677be5a0", # Zabbix components ami
                 "proxy" = "ami-0767046d1677be5a0"}
zabbix_server_ingress_rules = [
                {
                  "description" = "Allow SSH"
                  "port" = 22
                  "protocol" = "tcp"
                  "cidr_block" = ["0.0.0.0/0"]},
                {
                  "description" = "Allow connect to Zabbix server port"
                  "port" = 10051
                  "protocol" = "tcp"                           # server ingress rules
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
                  "protocol" = "tcp"                           $ database ingress rules
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
                  "cidr_block" = ["0.0.0.0/0"]},                    # frontend ingress rules
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
zabbix_proxy_ingress_rules = [
                {
         
                  "description" = "Allow SSH"
                  "port" = 22
                  "protocol" = "tcp"                                    # proxy ingress rules
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_server_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"                                     # server engress rules
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_db_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"                                     # database engress rules
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_frontend_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"                                      # frontend engress rules
                  "cidr_block" = ["0.0.0.0/0"]}]
zabbix_proxy_engress_rules = [
                {
                  "port" = 0
                  "protocol" = "-1"                                       # proxy engress rules
                  "cidr_block" = ["0.0.0.0/0"]}]
