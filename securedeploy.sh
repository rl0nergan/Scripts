#!bin/bash
#Ask for the root password and set it to $root
read -p "Set a root password: " root
#set the admin sshkey
key="`cat ~/.ssh/admin.pub`"
#Create and boot a new linode in us-east, on a 2GB Plan, Ubuntu 18.04 loaded with my ssh key
linode-cli linodes create --root_pass $root --region 'us-east' --type 'g6-standard-1' \
--image 'linode/ubuntu18.04' --authorized-keys $key --booted true 


