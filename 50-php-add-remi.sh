#!/bin/bash

#Setup and install PHP 7.4 from Remi repos

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y yum-utils
yum-config-manager --enable remi-php74
yum update -y

yum install -y php74 php74-php php74-php-bcmath php74-php-cli php74-php-common php74-php-curl php74-php-devel php74-php-fpm php74-php-gd php74-php-gmp php74-php-intl php74-php-json php74-php-mbstring php74-php-mcrypt php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pear php74-php-pecl-apcu php74-php-pecl-geoip php74-php-pecl-imagick php74-php-pecl-json-post php74-php-pecl-memcache php74-php-pecl-xmldiff php74-php-pecl-zip php74-php-process php74-php-pspell php74-php-simplexml php74-php-soap php74-php-tidy php74-php-xml php74-php-xmlrpc
ln -s /usr/bin/php74 /usr/bin/php