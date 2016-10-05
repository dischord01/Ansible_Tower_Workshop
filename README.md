# Ansible Tower Workshop

![ansible](https://www.redhat.com/cms/managed-files/Ansible-Tower-Logotype-Large-RGB-FullGrey-300x124.png)

`Ansible_Tower` is a ansible playbook to provision Ansible Tower in AWS. There are three different methods available in this playbook for provisioning AWS infrastructure & instances. It is up to the user on which methods they wish to use to provision infrastructure & instances in AWS.  

1. [Ansible Cloud Modules](http://docs.ansible.com/ansible/list_of_cloud_modules.html)
2. [AWS CloudFormation](https://aws.amazon.com/documentation/cloudformation/)
3. [Terraform](https://www.terraform.io/docs/providers/aws/index.html)

These modules all require that you have AWS API keys available to use to provision AWS resources. You also need to have IAM permissions set to allow you to create resources within AWS. There are several methods for setting up you AWS environment on you local machine. One way is to use the `awscli`. 

```
easy_install pip
pip install awscli
aws configure
   |------------------output--------------------|
	AWS Access Key ID [****************WFQ]:
	AWS Secret Access Key [****************TFHJw]:
	Default region name [us-east-1]:
	Default output format [None]:
```

Then your aws credentials should be picked up. If not the just export them by hand.

```
export AWS_ACCESS_KEY_ID='****************WFQ'
export AWS_SECRET_ACCESS_KEY='****************TFHJw'
```


## AWS Infrastructure

### Ansible Cloud Modules

To create infrastructure & a Ansible Tower instance via Ansible

```
ansible-playbook -i inventory aws_infra_ansible.yml --tags "vpc_create" 
```

To destroy

```
ansible-playbook -i inventory aws_infra_ansible.yml --tags "vpc_destroy" 
```


### AWS CloudFormation

To create infrastructure & a Ansible Tower instance via CloudFormation

```
ansible-playbook -i inventory aws_infra_cloudformation.yml --tags "cf_create" 
```
To destroy

```
ansible-playbook -i inventory aws_infra_cloudformation.yml --tags "cf_destroy" 
```

### Terraform

To create infrastructure & a Ansible Tower instance via Terraform 

```
brew install terraform

ansible-playbook -i inventory/terraform.py aws_infra_terraform.yml --tags "tf_create" 
```
To destroy

```
ansible-playbook -i inventory/terraform.py aws_infra_terraform.yml --tags "tf_destroy" 
```

## Configure Ansible Tower

To target the newly created EC2 instance use either the `ec2.py` or `terraform.py` module located in the `/inventory/` folder. The [ec2.py](http://docs.ansible.com/ansible/intro_dynamic_inventory.html) is a dynamic script that queries Amazon for your instances. The [terraform.py](https://github.com/CiscoCloud/terraform.py) script is a dynamic inventory script for parsing Terraform state files, to target your newly created instances by tags or id numbers. 


### 


### Use `ec2.py` to query AWS for your instance by AWS Tags

```
ansible-playbook -i inventory/ec2.py aws_ec2_instance.yml
```
Or

### Use `terraform.py` to target you instance by AWS Tags

```
ansible-playbook -i inventory/terraform.py aws_ec2_instance.yml
```

## Login to Ansible Tower

####Install Ansible Roles from [Galaxy](https://galaxy.ansible.com/)

```
ansible-galaxy install username.rolename
```

