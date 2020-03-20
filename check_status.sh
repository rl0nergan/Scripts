

#regex for an IP address([0-9]{1,3}[\.]){3}[0-9]{1,3}
id="19329751"
#id="19720539"
running=false
while [ $running == false ]
  do
    resp=`linode-cli linodes view $id --format 'status,ipv4' --text` 
    if [[ `echo $resp | grep "running"` -eq "" ]]
    then 
        echo "Still waiting..."
        sleep 5
    else
        ipv4=`echo $resp | egrep -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}"`
        echo "Linode is up and now loading."
        sleep 15
        running=true
    fi
  done
    echo "Out of the loop and complete"
    #scp -i "/Users/rlonergan/.ssh/admin" -o HostBasedAuthentication=yes StrictHostKeyChecking=no "/Users/rlonergan/Documents/Scripts/setup.sh" root@$ipv4:~/
    #sleep 2