#!/bin/bash

# Setting up hostname:
echo "balaji-puppetmaster" >/etc/hostname
echo "HOSTNAME=balaji-puppetmaster" >>/etc/sysconfig/network
echo "preserve_hostname: true" >>/etc/cloud/cloud.cfg
hostname balaji-puppetmaster
servername=$(hostname)
ip=$(ifconfig | grep inet | head -1 | awk '{print $2}' | tr -d addr:)
echo "$ip $servername" >> /etc/hosts

# Installing Puppet Master
echo "Installing pupper master..."
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm 
yum install puppet-server -y
mv /etc/puppet/ /tmp/


# Installing git and clone the repository from the master
echo "Installing git..."
yum install git -y
cd /etc/
git clone https://github.com/Balajikailash/puppet
cd puppet/
git pull

# Starting the Puppet service:
systemctl start  puppetmaster.service
puppet resource service puppetmaster ensure=running enable=true
exit
