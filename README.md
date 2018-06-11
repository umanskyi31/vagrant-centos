Vagrant development environment  
=======
It's easy configure and portable work development environment.

This project is pre-build package with CentOS 7.1, Apache 2.4, PHP 7.1, MariaDB 5.5 and other software like as composer and git.

## Getting Started

**Requirement**

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Install [Vagrant](http://www.vagrantup.com/)
* Clone or [download](https://github.com/umanskyi31/vagrant-centos) this repository to the root folder `git clone https://github.com/umanskyi31/vagrant-centos`
* Run `vagrant up` into root folder

The first time you run this, Vagrant will download the CentOS box image. Will run shell script which install next software (Apache 2.4, PHP 7.1, MariaDB 5.5 and etc.)

## How to use

* In your browser, head to `192.168.33.33`. If need to change the address, you can do this into Vagrantfile:
 
 ```  config.vm.network "private_network", ip: "192.168.33.33"```
* Database name is vagrant_db, user = vagrant / password = secret


**ENJOY**