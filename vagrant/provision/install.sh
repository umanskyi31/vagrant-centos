#!/usr/bin/env bash

#THIS FILE START ONLY ONCE
echo "Start install data on CentOS"

yum install -y vim

#Testing file for vagrant
#Setup apache
yum update

yum install -y httpd



#I thinks need sudo
#chkconfig httpd on

#systemctl start httpd.service

#systemctl enable httpd.service


#firewall - in not running - start running
#firewall-cmd --permanent --zone=public --add-service=http
#firewall-cmd --permanent --zone=public --add-service=https
#firewall-cmd --reload