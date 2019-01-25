# Terraform v0.9.11

## Crate AWS EC2 and ELB 

* Set up ec2 resources.
  * VPC (vpc/subnet/gateway/route table)
  * Security group
  * EC2 instance
  * Run Ansible fo ec2 instance
  * ELB (join ec2 instances)

* edit perameters.

```
# for ec2.tf
ec2_region            = "" - Region name.
ec2_instance_type     = "" - Instace type.
ec2_ami_id            = "" - AMI ID.
ec2_count             = "" - Create instance number.
ec2_instance_key_name = "" - Instance ssh key pair name.
ec2_tag               = "" - Intance Name tag.
ansible_ssh_key       = "" - SSH login key.
ansible_ssh_user      = "" - SSH login user.
ansible_playbook      = "" - Ansible playbook path.(site.yml, main.yml..)

# for vpc.tf
vpc_cidr_block        = "" - VPC cidr.(10.0.0.0/16)
vpc_subnet_cidr_block = "" - VPC subnet cider.(10.0.0.0/24)
vpc_tag               = "" - VPC Name tag.
vpc_subnet_tag        = "" - VPC subnet Name tag.
vpc_gateway_tag       = "" - VPC gateway Name tag.
vpc_route_table_tag   = "" - VPC route table Name tag.

# for security.tf
security_group_tag    = "" - Security group Name tag.
security_allow_ip_01  = "" - Allow ip address.(10.0.0.1/32)
security_allow_ip_02  = "" - Allow ip address.
security_allow_ip_03  = "" - Allow ip address.
security_allow_ip_04  = "" - Allow ip address.

# for elb.tf
elb_tag               = "" - ELB Name tag.
```

* Switch variable file for environment.

```
terraform plan -var-file=staging.tfvars
terraform apply -var-file=staging.tfvars
```
