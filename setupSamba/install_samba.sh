#!/bin/bash

# andychen (bootoo@sina.cn)
# date 2015-2-8
# install samba


# by Ubuntu
byUbuntu(){
  echo "byUbuntu"
  sudo apt-get update
  sudo apt-get install samba
  sudo mkdir /srv/shareFile
  sudo chmod 777 /srv/shareFile

  cp -f ./smb.conf /etc/
  sed -i "s/dir/srv\/shareFile/g" /etc/smb.conf
  cd /srv/shareFile
  sudo touch public.txt
  echo "this our share file! andychen (`date`)" > /srv/shareFile/public.txt

  sudo sercive smbd restart
  echo ''
  echo '+--------------------------------------+'
  echo '|  ********** install samba ***********|'
  echo '|              succeed!!               |'
  echo '+--------------------------------------+'
  echo ''
}


# by Centos
byCentos(){
  echo ""
  echo "developing...."
  echo ""
}


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

