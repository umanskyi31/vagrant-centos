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

mysql -u root -e "CREATE DATABASE IF NOT EXISTS vagrant_db"
mysql -u root -e "GRANT ALL PRIVILEGES ON vagrant_db.* TO 'vagrant'@'localhost' IDENTIFIED BY 'secret'"
mysql -u root -e "FLUSH PRIVILEGES"
sudo yum -y install unzip
#----END MARIADB-----

echo "INCLUDE PHP"
#Install and enable EPEL and Remi repository to your CentOS 7 system
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

#You need to install yum-utils, a collection of useful programs for managing yum repositories and packages.
# It has tools that basically extend yum’s default features.
sudo yum install -y yum-utils

#One of the programs provided by yum-utils is yum-config-manager,
# which you can use to enable Remi repository as the default repository for installing different PHP versions as shown
sudo yum-config-manager --enable remi-php71

sudo yum install -y php php-opcachec
#install php
sudo yum install -y php71 php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo  php-mbstring php-xml php-opcache
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

echo "CREATE SYMBOLIC LINK"
sudo ln -s /vagrant/ /var/www/html/

echo "CREATE VIRTUAL HOST"
# Create virtual host for Apache
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DirectoryIndex index.php
  DocumentRoot "/var/www/html/vagrant/"
  ServerName localhost
  <Directory "/var/www/html/vagrant/">
    AllowOverride All
  </Directory>
</VirtualHost>
EOF
)

sudo echo "$VHOST" >> /etc/httpd/conf/httpd.conf

echo "RESTART APACHE END OF CONFIGURATION"
# Restart apache
sudo systemctl restart httpd.service

