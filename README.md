# Ansible Tower Workshop

![ansible](https://www.redhat.com/cms/managed-files/Ansible-Tower-Logotype-Large-RGB-FullGrey-300x124.png)

`Ansible_Tower` is a ansible playbook to provision Ansible Tower in AWS. There are three different methods available in this playbook for provisioning AWS infrastructure & instances. It is up to the user on which methods they wish to use to provision infrastructure & instances in AWS.  

1. [Ansible Cloud Modules](http://docs.ansible.com/ansible/list_of_cloud_modules.html)
2. [AWS CloudFormation](https://aws.amazon.com/documentation/cloudformation/)
3. [Terraform](https://www.terraform.io/docs/providers/aws/index.html)

These modules all require that you have AWS API keys available to use to provision AWS resources. You also need to have IAM permissions set to allow you to create resources within AWS. There are several methods for setting up you AWS environment on you local machine. One way is to export them by hand.

```
export AWS_ACCESS_KEY_ID='****************WFQ'
export AWS_SECRET_ACCESS_KEY='****************TFHJw'
```


## AWS Infrastructure Roles
Three options for provisioning AWS Infrastucture:


### aws.infra.ansible 

To create infrastructure and a Ansible Tower instance via Ansible

```
ansible-playbook -i inventory aws_infra_ansible.yml --tags "vpc_create" 
```

To destroy

```
ansible-playbook -i inventory aws_infra_ansible.yml --tags "vpc_destroy" 
```


### aws.infra.cloudformation

To create infrastructure and a Ansible Tower instance via CloudFormation

```
ansible-playbook -i inventory aws_infra_cloudformation.yml --tags "cf_create" 
```
To destroy

```
ansible-playbook -i inventory aws_infra_cloudformation.yml --tags "cf_destroy" 
```

### aws.infra.terraform

To create infrastructure and a Ansible Tower instance via Terraform

```
brew install terraform
```

Then edit `roles/aws.terraform/vars/main.yml` and fill in the vars with your AWS api info. This role can also provide easy domain name mapping to all the instances if you have a domain registered in AWS Route 53. 


```
#####################################################
# Domain Name you own
#####################################################
domain_name: ""
zone_id: ""

#####################################################
# AWS API Keys for terraform.tfvars file
#####################################################
aws_access_key: ""
aws_secret_key: ""
```

```
ansible-playbook -i inventory aws_infra_terraform.yml --tags "tf_create" 
```

To destroy

```
ansible-playbook -i inventory aws_infra_terraform.yml --tags "tf_destroy" 
```

## Configure Ansible Tower




### ansible.tower

The ansible.tower role configures the instance with the `tower-cli`. By default the `ansible.tower` role installs 15 student accounts and associates them with a default `Lab Team` & `Lab Organization`.

To target the newly created EC2 instance use either the `ec2.py` or `terraform.py` module located in the `/inventory/` folder. The [ec2.py](http://docs.ansible.com/ansible/intro_dynamic_inventory.html) is a dynamic script that queries Amazon for your instances. The [terraform.py](https://github.com/CiscoCloud/terraform.py) script is a dynamic inventory script for parsing Terraform state files, to target your newly created instances by tags or id numbers. 

The instances that get created have the same tag so using just the inventory folder will work as well. 
 
```
ansible-playbook -i inventory aws_ec2_instance.yml
```

## Login to Ansible Tower

browse to the public ip of the EC2 instance and enter the `admin` password located in `roles/ansible.tower/vars/main.yml`. 

![Login](https://s3.amazonaws.com/dischord01/img/ansible-tower.png)

####Install Ansible Roles from [Galaxy](https://galaxy.ansible.com/)

This repo also contains a Ansible Galaxy file to install any remote roles from galaxy. To add additional roles add the role name to the `galaxy.yml` file and install it as shown below. 

```
ansible-galaxy install username.rolename
```

