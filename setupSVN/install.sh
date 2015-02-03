#!/bin/bash

# set up item SVN service for shell script
# author andy chen
# email  bootoo@sina.cn


# === set up for Ubuntu ========================================================================
byUbuntu(){
#	sudo apt-get update
#	sudo apt-get install subversion
#	cd /srv
#	sudo mkdir svn
#	cd ./svn
#	sudo mkdir Warehouse
#	sudo svnadmin create Warehouse

  # --- build conf file and child files authz,passwd ------------------
  sudo mkdir conf
  sudo touch ./conf/authz ./conf/passwd

  # --- build user groups ---------------------------------------------
  echo "
[aliases]
# joe = /C=XZ/ST=Dessert/L=Snake City/O=Snake Oil, Ltd./OU=Research Institute/CN=Joe Average

[groups]
admin = admin,boss
"	> /srv/svn/conf/authz

  # --- build users and password --------------------------------------
	echo "
[users]
admin = 123456
boss  = 135246
# harry = harryssecret
# sally = sallyssecret
"	> /srv/svn/conf/passwd

  # --- create 10 null repository -------------------------------------
  file_num=10
  for((i=0; i<$file_num; i++)); do
    sudo svnadmin create null_$i
    sudo rm ./null_$i/conf/authz
    sudo rm ./null_$i/conf/passwd
    editSvnserve $i
    editAuthz $i
    echo -e "\nuser_$i = 123456\nuser_${i}_tes = 123456" >> ./conf/passwd
    num=$((file_num - i - 1))
    sed -i "/boss/a\ \ngrounp_null_${num}_dev = user_${num}\ngrounp_null_${num}_tes = user_${num}_tes" ./conf/authz
  done

  # --- start svnserve ------------------------------------------------
  sudo svnserve -d -r /srv/svn
  echo ''
  echo 'succeed!!!'
  echo 'use create.sh build your new repository'
  echo ''
  echo 'builded 10 SVN repository:'
  find ./ -name "null_*" | sort
  echo ''
}

# --- edit svnserve.conf file -----------------------------------------
editAuthz(){
  echo "
[null_$1:/]
@admin = rw
@grounp_null_$1_dev = rw
@grounp_null_$1_tes = r
*=r
"	>> /srv/svn/conf/authz
}

# --- edit svnserve.conf file -----------------------------------------
editSvnserve(){
	echo "
[general]
anon-access = none
auth-access = write
password-db = /srv/svn/conf/passwd
authz-db = /srv/svn/conf/authz
realm = null_$1
# force-username-case = none

[sasl]
# use-sasl = true
# min-encryption = 0
# max-encryption = 256
"	> /srv/svn/null_$1/conf/svnserve.conf

}


# === set up for Ubuntu =======================================================================
byCentos(){
	echo "byCentos"
}


# === install view  ===========================================================================
echo ''
echo '------------- begin set up SVN -------------'
echo ''
echo '1.Ubuntu'
echo '2.Centos'
echo ''
read -p 'palse select option:' option

case "$option" in
	1)
		byUbuntu;;
	2)
		byCentos;;
	*)
		echo ''
		echo "select error!!"
		echo '';;
esac

