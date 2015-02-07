#!/bin/bash

# andychen (bootoo@sina.cn)
# 2015-2-6
# install memcache server


if [ ! -f memcached-1.4.22.tar.gz ];then
  wget http://www.memcached.org/files/memcached-1.4.22.tar.gz
fi
rm -rf memcached-1.4.22
tar -xzvf memcached-1.4.22.tar.gz
cd memcached-1.4.22
./configure --prefix=/usr/local/memcache -with-libevent=/usr/local/lib
make
make install
sudo memcached -d -m 128 -u root -l 127.0.0.1 -p 11211 -c 256 -P /tmp/memcached.pid
#sudo memcached -d -m 128 -u root -l 127.0.0.1 -p 11211 -c 256

