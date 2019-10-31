#!/bin/bash
cd ./terraform
terraform apply -input=false -auto-approve
cd ..
cd playbook
ansible-playbook -i host-terra mediawiki.yml

