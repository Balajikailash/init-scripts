#!/bin/bash
echo "balaji-app1" >/etc/hostname
echo "HOSTNAME=balaji-app1" >>/etc/sysconfig/network
echo "preserve_hostname: true" >>/etc/cloud/cloud.cfg
hostname balaji-app1
servername=$(hostname)
ip=$(ifconfig | grep inet | head -1 | awk '{print $2}' | tr -d addr:)
echo "$ip $servername" >> /etc/hosts 
echo "172.31.50.109 balaji-puppetmaster.ec2.internal" >>/etc/hosts
yum install puppet -y
puppet agent -t --server=balaji-puppetmaster.ec2.internal --no-daemonize --verbose
exit
