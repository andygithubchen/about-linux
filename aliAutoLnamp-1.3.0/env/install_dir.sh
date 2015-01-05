#!/bin/bash

userdel www
groupadd www
useradd -g www -M -d /alidata/www -s /sbin/nologin www &> /dev/null

mkdir -p /alidata
mkdir -p /alidata/server
mkdir -p /alidata/www
mkdir -p /alidata/www/phpwind
mkdir -p /alidata/log
mkdir -p /alidata/log/php
mkdir -p /alidata/log/mysql
mkdir -p /alidata/log/nginx
mkdir -p /alidata/log/nginx/access
chown -R www:www /alidata/log

mkdir -p /alidata/server/${mysql_dir}
ln -s /alidata/server/${mysql_dir} /alidata/server/mysql

mkdir -p /alidata/server/${php_dir}
ln -s /alidata/server/${php_dir} /alidata/server/php


mkdir -p /alidata/server/${web_dir}
if echo $web |grep "nginx" > /dev/null;then
mkdir -p /alidata/log/nginx
mkdir -p /alidata/log/nginx/access
ln -s /alidata/server/${web_dir} /alidata/server/nginx
else
mkdir -p /alidata/log/httpd
mkdir -p /alidata/log/httpd/access
ln -s /alidata/server/${web_dir} /alidata/server/httpd
fi
