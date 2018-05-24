#!/usr/bin/env bash

rpm -y -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum -y install yum-utils

yum update

yum-config-manager --enable remi-php71

yum -y install php php-opcache

yum -y install php php-opcache

yum -y install php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-soap curl curl-devel