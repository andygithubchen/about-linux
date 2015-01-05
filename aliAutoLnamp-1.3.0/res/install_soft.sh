#!/bin/bash

#phpmyadmin
if [ ! -f phpMyAdmin-4.1.8-all-languages.zip ];then
  wget http://oss.aliyuncs.com/aliyunecs/onekey/phpMyAdmin-4.1.8-all-languages.zip
fi
rm -rf phpMyAdmin-4.1.8-all-languages
unzip phpMyAdmin-4.1.8-all-languages.zip
mv phpMyAdmin-4.1.8-all-languages /alidata/www/phpmyadmin

chown -R www:www /alidata/www/
