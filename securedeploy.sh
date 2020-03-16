#!bin/bash
read -p "Set a root password: " root

linode-cli linodes create --root_pass $root 