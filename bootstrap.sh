#!/usr/bin/env bash

echo "START INSTALL FROM BASH FILES"

# Install Apache
echo "INSTALL APACHE"
sudo yum -y update
sudo yum -y install httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service

#firewall - in not running - start running
echo "RUNNING FIREWALL"
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
#----END APACHE-----------

echo "INCLUDE MARIADB"
# Install MariaDB
# ---------------
sudo yum -y install mariadb-server mariadb
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service

mysql -u root -e "CREATE DATABASE IF NOT EXISTS project"
mysql -u root -e "GRANT ALL PRIVILEGES ON project.* TO 'project'@'localhost' IDENTIFIED BY 'password'"
mysql -u root -e "FLUSH PRIVILEGES"
sudo yum -y install unzip
#----END MARIADB-----

echo "INCLUDE PHP"
#Install and enable EPEL and Remi repository to your CentOS 7 system
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

#You need to install yum-utils, a collection of useful programs for managing yum repositories and packages.
# It has tools that basically extend yum’s default features.
yum install -y yum-utils

#One of the programs provided by yum-utils is yum-config-manager,
# which you can use to enable Remi repository as the default repository for installing different PHP versions as shown
yum-config-manager --enable remi-php71

#install php
yum install -y php71 php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo  php-mbstring php-xml
#---END PHP----

echo "INCLUDE ADDITIONAL SOFT"

sudo yum update -y

#Install composer
echo "INSTALL COMPOSER"
cd /tmp
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

#Install GIT
echo "INSTALL GIT"
sudo yum install -y git

#Install VIM for user
echo "INSTALL VIM"
sudo yum install -y vim

echo "START CONFIGURED PROJECT"

echo "CREATE FOLDER"
sudo mkdir /vagrant/public_html/

echo "CREATE SYMBOLIC LINK"
sudo ln -s /vagrant/public_html/ /var/www/html/

echo "CREATE VIRTUAL HOST"
# Create virtual host for Apache
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DirectoryIndex index.php
  DocumentRoot "/var/www/html/public_html"
  ServerName localhost
  <Directory "/var/www/html/public_html">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)

sudo echo "$VHOST" >> /etc/httpd/conf/httpd.conf

echo "RESTART APACHE \n END OF CONFIGURATION"
# Restart apache
sudo systemctl restart httpd.service

