#!/bin/bash

echo "Ansible Dependencies"

pip install -U passlib paramiko PyYAML Jinja2 httplib2 six 

echo "Ansible 2.0"
pip install -U ansible