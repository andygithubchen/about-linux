#!/bin/bash

# build new repository
# andychen (bootoo@sina.cn)


# === by ubuntu ===============================================================================
byUbuntu(){
  if [ ! -d "/srv/svn/" ];then
    echo ''
    echo 'you could no install SVN !'
    echo 'you can use install.sh file install SVN !'
    echo ''
    exit 0
  fi

  # --- check null repository ----------------------------------------
  cd /srv/svn
  num=$(ls -l | grep "null_" | wc -l)
  echo ''
  echo "you have $num null repository"
  echo ''
  find ./ -name "null_*" -exec basename {} \; | sort
  echo ''
  echo 'select a null repository as your new repository'
  echo ''
  read -p 'input null repository name:' name
echo $name
exit 0
  if [ ! -d "$name" ]; then
    echo ''
    echo "not found $name null repository"
    echo ''
    exit 0
  fi
  # --- config new repository ----------------------------------------
  echo 'config new repository'
  echo ''
  read -p 'input your new repository name:' new_name
  sudo mv $name $new_name
  sed -i "s/$name/$new_name/" ./$new_name/conf/svnserve.conf
  echo 'input your item developments user name and password'
  echo 'example "usr1-pwd1,usr2-pwd2,..."'
  read -p 'input:' users
  echo $users
#grounp_null_0_dev = user_0
#grounp_null_0_tes = user_0_tes
}

# === by centos ===============================================================================
byCentos(){
  echo "andy"
}







# === build view ==============================================================================
echo ''
echo '------------- build new repository for SVN -------------'
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

