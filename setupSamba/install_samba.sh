#!/bin/bash

# andychen (bootoo@sina.cn)
# date 2015-2-8
# install samba


# by Ubuntu
byUbuntu(){
  echo "byUbuntu"
  apt-get update
  apt-get install samba
  mkdir /srv/shareFile
  chmod 777 /srv/shareFile

  cp -f ./smb.conf /etc/samba/
  sed -i "s/dir/srv\/shareFile/g" /etc/samba/smb.conf
  cd /srv/shareFile
  touch public.txt
  echo "this our share file! andychen (`date`)" > /srv/shareFile/public.txt

  sercive smbd restart
  echo ''
  echo '+--------------------------------------+'
  echo '|  ********** install samba ***********|'
  echo '|              succeed!!               |'
  echo '+--------------------------------------+'
  echo ''
}


# by Centos
byCentos(){
  echo "byCentos"
  yum -y install samba
  mkdir /srv/shareFile
  chmod 777 /srv/shareFile

  cp -f ./smb.conf /etc/samba/
  sed -i "s/dir/srv\/shareFile/g" /etc/samba/smb.conf
  cd /srv/shareFile
  touch public.txt
  echo "this our share file! andychen (`date`)" > /srv/shareFile/public.txt

  /etc/init.d/smb start
  echo ''
  echo '+--------------------------------------+'
  echo '|  ********** install samba ***********|'
  echo '|              succeed!!               |'
  echo '+--------------------------------------+'
  echo ''
}


# 要求用root用户执行
if [ `whoami` != 'root' ];then
    echo "+----------------------------+"
    echo "|  plase use root user       |"
    echo "+----------------------------+"
    exit 1
fi

echo ''
echo '+--------------------------------------+'
echo '|  ********** install samba ***********|'
echo '|  1. byUbuntu                         |'
echo '|  2. byCentos                         |'
echo '+--------------------------------------+'
read -p 'plase select your system:' option
echo ''

case "$option" in
  1)
    byUbuntu ;;
  2)
    byCentos ;;
  *)
    echo ''
    echo "input error! try agin"
    echo ''
    ;;
esac

