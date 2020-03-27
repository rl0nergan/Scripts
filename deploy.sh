#!/bin/bash
#Ask for the root password and set it to $root
#Change to secret entry once complete
read -s -p "Set a root password: " root
#set the admin sshkey. Paste it in for now
echo
#read -p "Enter the SSH key: " key
key=`cat ~/.ssh/admin.pub`
key_list+=( $key  )
#Create and boot a new linode in us-east, on a 2GB Plan, Ubuntu 18.04 loaded with my ssh key
output=`linode-cli linodes create --root_pass $root --region 'us-east' --type 'g6-standard-1' \
--image 'linode/ubuntu18.04' --authorized_keys $key_list \
--label 'scripted' --text` 

echo $output > output.txt

ip_addr=`cat output.txt | egrep -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`

echo "Provisioning..."
sleep 30
echo "Booting..."
sleep 30
echo "Booting..."
sleep 20
echo "Beginning transfer..."

scp -i "/Users/rlonergan/.ssh/admin" -q "/Users/rlonergan/.ssh/admin.pub" "root@$ip_addr:~/"
scp -i "/Users/rlonergan/.ssh/admin" "setup.sh" "root@$ip_addr:~/"
#ssh -i "/Users/rlonergan/.ssh/admin" "root@$ip_addr" "./setup.sh $ip_addr"
echo "Linode Secure"
sleep 2
echo "Connecting"
ssh -i "~/.ssh/admin" "rlonergan@$ip_addr"
#[{
#    "id": 19775744, 
#    "label": "scripted", 
    #"status": "provisioning", 
    #"type": "g6-standard-1", 
    #"ipv4": ["45.79.180.221"], 
    #"image": "linode/ubuntu18.04", 
    #"region": "us-east"
    #}]

    