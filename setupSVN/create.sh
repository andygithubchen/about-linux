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
  check_null_rep(){
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

    if [ "$name" = 'q' ]; then
      exit 0
    fi

    if [ ! -d "$name" ]; then
      echo ''
      echo "not found $name null repository, try again"
      echo ''
      check_null_rep
    fi
  }

  # --- config new repository ----------------------------------------
  conf_new_rep(){
    echo 'config new repository'
    echo ''
    read -p 'input your new repository name:' new_name

    if [ "$new_name" = 'q' ]; then
      exit 0
    fi

    str=$(echo "$new_name" | awk '/^([0-9a-zA-Z]+)-([0-9a-zA-Z]+)$/')
    len=${#str}
    if [ "$len" -le 0 ]; then
echo ''
    fi
    sudo mv $name $new_name
    sed -i "s/$name/$new_name/" ./$new_name/conf/svnserve.conf
    sed -i "s/$name/$new_name/g" ./conf/authz
  }

  echo 'input your item developments user name and password'
  echo 'example "usr1-pwd1,usr2-pwd2,..."'
  read -p 'input:' users

  # --- check $users ---
  if [ -z "$users" ]; then
    echo ''
    echo 'you input anything!'
    echo ''
  fi

  arr=$(strToarray , $users)
  if [ "${#arr[@]}" -le 0 ]; then
    echo ''
    echo 'input error!'
    echo ''
  fi

  for s in $arr; do
    str=$(echo "$s" | awk '/^([0-9a-zA-Z]+)-([0-9a-zA-Z]+)$/')
    len=${#str}
    if [ "$len" -le 0 ]; then
      echo ''
      echo 'input users error, please try again!'
      echo ''
      break
    fi
  done

  # --- edit passwd file ---
  num=${name##*_}
    #user_0 = 123456
    #user_0_tes = 123456

  sed -i "/$num_tes/a\ \n"
  sed -i "/boss/a\ \ngrounp_null_${num}_dev = user_${num}\ngrounp_null_${num}_tes = user_${num}_tes" ./conf/authz
  # --- edit authz  file ---

#grounp_null_0_dev = user_0
#grounp_null_0_tes = user_0_tes

#[null_0:/]
#@admin = rw
#@grounp_null_0_dev = rw
#@grounp_null_0_tes = r
#*=r

}

# === string to array function ===
# string to array
# @param $1 IFS
# @param $2 string
strToarray(){
  LD_IFS="$IFS"
  IFS="$1"
  arr=($2)
  IFS="$OLD_IFS"
  echo ${arr[@]}
  #for s in ${arr[@]}
  #do
  #   echo "$s"
  #done

}

# === by centos ===============================================================================
byCentos(){
  echo "andy"
}







# === build view ==============================================================================
#echo ''
#echo '------------- build new repository for SVN -------------'
#echo ''
#echo '1.Ubuntu'
#echo '2.Centos'
#echo ''
#read -p 'palse select option:' option
#
#case "$option" in
#	1)
#		byUbuntu;;
#	2)
#		byCentos;;
#	*)
#		echo ''
#		echo "select error!!"
#		echo '';;
#esac










    #str=$(echo "$s" | awk '/^([0-9a-zA-Z]+)-([0-9a-zA-Z]+)$/')
read -p 'input:' new_name
#echo "$new_name" | awk '/^[0-9a-zA-Z]+$/'
echo "$new_name" | awk '/^[a-z0-9_-]+$/'




