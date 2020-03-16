#!/bin/bash

#Download and install updates
#Ask for the hostname
read -p "What is the hostname? " HOSTNAME
#Set the hostname
hostnamectl set-hostname $HOSTNAME

#Update the System's hosts file
echo "69.164.218.56 $HOSTNAME" >> /etc/hosts

#Setting the timezone
timedatectl set-timezone 'America/New_York'

#Create a limited user and set the password
read -p "Enter a username: " USERNAME
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
clear 
