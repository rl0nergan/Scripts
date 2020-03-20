#!/bin/bash -x
#troubleshoot networking script for IP addresses
ping -c 5 -i 2 $1
echo
sudo nmap --top-ports 10 -sV -sS $1
