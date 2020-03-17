#!/bin/bash
#Ask for the root password and set it to $root
#Change to secret entry once complete
read -p "Set a root password: " root
#set the admin sshkey. Paste it in for now
read -p "Enter SSH Key: " key
key_list+=( $key )
#Create and boot a new linode in us-east, on a 2GB Plan, Ubuntu 18.04 loaded with my ssh key
output=`linode-cli linodes create --root_pass $root --region 'us-east' --type 'g6-standard-1' \
--image 'linode/ubuntu18.04' --authorized_keys $key_list --booted true \
--label 'scripted' --json`

echo $output[0]

#running=false
#while [ $running == false ]
#  do
#    linode-cli linodes
#  done


#[{
    "id": 19775744, 
    "label": "scripted", 
    "status": "provisioning", 
    "type": "g6-standard-1", 
    "ipv4": ["45.79.180.221"], 
    "image": "linode/ubuntu18.04", 
    "region": "us-east"
    }]