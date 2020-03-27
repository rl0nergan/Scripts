#!/bin/bash
#ip_addr=$1
#Download and install updates
#Ask for the hostname
#read -p "What is the hostname? " HOSTNAME
#Set the hostname
hostnamectl set-hostname "wireguard"

#Update the System's hosts file
#Create a csv with new linode info with deploy.sh to be used by setup.sh? 
echo "172.104.25.175 wireguard" >> /etc/hosts

#Setting the timezone
timedatectl set-timezone 'America/New_York'

USERNAME="rlonergan"
#PASS="p00pcak3s"

#Create a limited user and set the password
#read -p "Enter a username: " USERNAME
read -s -p "Enter a password: " PASS
echo
adduser --disabled-login $USERNAME
echo "$USERNAME:$PASS" | chpasswd
adduser $USERNAME sudo

#Switch to limited user, create .ssh directory and updating permissions
mkdir -p /home/$USERNAME/.ssh && chmod -R 700 /home/$USERNAME/.ssh/
sed -i -e "s/PermitRootLogin yes/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i -e "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config

#Restart sshd to load new config 
systemctl restart sshd
apt-get update -y && apt-get upgrade -y

#Add public key to authorized_keys file
read -p "Enter your public key: " SSHKEY
chown -R $USERNAME:$USERNAME /home/$USERNAME/
echo $SSHKEY >> /home/$USERNAME/.ssh/authorized_keys

#Download, setup, and enable UFW
#apt install ufw -y
#ufw default allow outgoing
#ufw default deny incoming
#ufw allow ssh
#ufw enable 

su - $USERNAME
 
