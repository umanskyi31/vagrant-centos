#!/usr/bin/env bash

#THIS FILE START ONLY ONCE
echo "Start install data on CentOS"

yum install -y vim

#Testing file for vagrant
#Setup apache
yum update

yum install -y httpd

chkconfig httpd on

service httpd start

#install php
yum install -y php

#restart apache
service httpd restart