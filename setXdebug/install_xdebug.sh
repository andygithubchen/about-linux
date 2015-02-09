#!/bin/bash

# andychen (bootoo@sina.cn)
# date 2015-2-9
# install xdebug


# NOTE ------------------------------
#
# php.ini account
#
# error_reporting = E_ALL
# display_error = On
# html_error = On
#
# NOTE ------------------------------


CPU_NUM=$(cat /proc/cpuinfo | grep processor | wc -l)

if [ ! -f "xdebug-2.2.2.tgz" ]; then
  wget http://pecl.php.net/get/xdebug-2.2.2.tgz
fi
sudo rm -fr xdebug-2.2.2
tar -zvxf xdebug-2.2.2.tgz

cd xdebug-2.2.2
/alidata/server/php/bin/phpize
./configure --with-php-config=/alidata/server/php/bin/php-config
if [ $CPU_NUM -gt 1 ];then
    make -j$CPU_NUM
else
    make
fi
make install
cd ..
echo "
[Xdebug]
zend_extension=/alidata/server/php/lib/php/extensions/no-debug-non-zts-20090626/xdebug.so
xdebug.auto_trace=On
xdebug.show_mem_delta=On
xdebug.collect_params=On
xdebug.collect_return=On
xdebug.profiler_enable=On
xdebug.profiler_output_name=\"script\"
xdebug.trace_output_dir=\"/tmp/php_xdebug\"
xdebug.profiler_output_dir=\"/tmp/php_xdebug\"
" >> /alidata/server/php/etc/php.ini




