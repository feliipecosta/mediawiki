#!/bin/bash
cd ./terraform
terraform init
terraform apply -input=false -auto-approve
sleep 20
cd ..
cd playbook
ansible-playbook -i host-terra mediawiki.yml

