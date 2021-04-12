# Zabbix infrastructure with terraform

This is project deploys zabbix infrastructure with terraform.

## What is zabbix?

Zabbix is an open source monitoring software tool for diverse IT components, including networks, servers, virtual machines (VMs) and cloud services. 
For more information, see [What is zabbix](https://searchitoperations.techtarget.com/definition/Zabbix/).

## What does the project consists of?

The project consists of the following files:
 * server_configuration.tf: responsible for deployment of zabbix server part. Components are:
   * server instance
   * security group
 * frontend_configuration.tf: responsible for deployment of zabbix frontend part. Components are:
   * frontend instance 
   * security group
 * mysql_configuration.tf: responsible for deployment of zabbix database part. Components are:
   * database instance
   * security group).
 * network_configuration.tf: responsible for deployment of zabbix network part. Components are:
   * vpc
   * subnet
   * internet getwey
   * etc
 * terragrunt.hcl: responsible for deployment of zabbix proxy part. Components are:
   * proxy instances
   * security groups
   * multiple regions
 * variable.tf: Defined all default variables for zabbix infrastructure.
 
 ## Run the project

This is a simple Terraform configuration that will create an zabbix infrastructure using your AWS account. You must call `terragrunt apply` command,
to deploy zabbix infrastructure.

### What are the prerequisites?

- You must have an AWS account and provide your AWS Access Key ID and AWS Secret Access Key for terraform. 
For more information on how to configure your aws account, 
see [Configuration and credential file settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html).

- You must modify *zabbix_configuration.tfvars* file to initialize the values for variables to deploy zabbix project.

- To deploy proxy server you must specify values in `proxy_content` local variable (which is list of dictionaries) in *terragrunt.hcl* file, add as many dictionaries as you want: 
   * region
   * alias
   * vpc id
   * subnet id
 
**Note. alias id must be unique.**

