#!/usr/bin/env bash

ansible-playbook -i inventory playbook_aws_infra.yml --tags "vpc_create" 

ansible-playbook -i inventory/ec2.py playbook_aws_ec2.yml