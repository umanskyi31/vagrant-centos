#!/usr/bin/env bash

#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*
yum -y install epel-release

yum -y install mariadb-server mariadb

#systemctl start mariadb.service

#systemctl enable mariadb.service