#!/usr/bin/env bash

# andychen (bootoo@sina.cn)
# 2015-2-6
# install redis server
# from https://github.com/jaggerwang/devops.git, and I modified some!

if [ $# -gt 0 ]; then
  version=$1
else
  version=2.8.9
fi
redis_src=redis-$version.tar.gz
redis_dir=${redis_src%.tar.gz}
install_dir=/usr/local/redis
data_dir=$install_dir/data

if [ ! -f $redis_src ]
then
  wget http://download.redis.io/releases/$redis_src
fi
if [ -d $redis_dir ]; then
  rm -rf $redis_dir
fi
tar zxf $redis_src
cd $redis_dir
make
make PREFIX=$install_dir install
cd ..

mkdir -p $install_dir/conf/
cp redis.conf $install_dir/conf/
sed -i "s%\$dir%$install_dir%g" $install_dir/conf/*

cd $install_dir
ln -sf $install_dir/bin/redis-cli redis-cli

mkdir -p $data_dir
cd $install_dir
bin/redis-server conf/redis.conf

