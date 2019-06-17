#!/bin/bash -ex

instances="$1"
ssh_key="$2"
ssh_user="$3"
playbook="$4"

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i ${instances} \
                 -u ${ssh_user} \
                 --key-file=${ssh_key} \
                 -e ansible_python_interpreter=/usr/bin/python3 \
                 ${playbook} -v
