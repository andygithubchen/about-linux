#!/bin/bash

# build new repository for SVN
# andychen (bootoo@sina.cn)


# === by ubuntu ===============================================================================
byUbuntu(){
  if [ ! -d "/srv/svn/" ];then
    echo ''
    echo '  +--------------------------------------------+'
    echo '  | you could no install SVN !                 |'
    echo '  | you can use install.sh file install SVN !  |'
    echo '  +--------------------------------------------+'
    echo ''
    exit 0
  fi

  cd /srv/svn
  export NAME=''

  # --- check null repository ---
  check_null_rep

  # --- config new repository ---
  conf_new_rep $NAME

  # --- check input users ---
  check_users dev $NAME
  check_users tes $NAME

}

# ---------------------------------------------------------------------------------------------------------------------

# ===  check null repository ===
# check null repository
# @param
# @return $name
check_null_rep(){
  num=$(ls -l | grep "null_" | wc -l)
  echo ''
  echo "you have $num null repository"
  echo ''
  find ./ -name "null_*" -exec basename {} \; | sort
  echo ''
  echo 'select a null repository as your new repository'
  read -p 'input null repository name:' name

  if [ "$name" = 'q' ]; then
    exit 0
  fi

  arr_ls=$(ls | grep 'null_')
  is_in=$(echo "$arr_ls" | grep "$name")
  if [ ! "$is_in" ]; then
    echo ''
    echo 'name error! try again'
    echo ''
    check_null_rep
  fi

  NAME=$name
}

# ===  config new repository ===
# config new repository
# @param  $1=>$name
# @return $new_name
conf_new_rep(){
  echo ''
  echo 'config new repository'
  read -p 'input your new repository name:' new_name

  if [ "$new_name" = 'q' ]; then
    exit 0
  fi

  if [ -d "./$new_name" ]; then
    echo ''
    echo "\"$new_name\" Already exists"
    echo ''
    conf_new_rep
  fi

  str=$(echo "$new_name" | awk '/^[0-9a-zA-Z][a-z0-9A-Z_-]+$/')
  len=${#str}
  if [ "$len" -le 0 ]; then
    echo ''
    echo 'File name format error! try again'
    echo ''
    conf_new_rep
  fi

  sudo mv $1 $new_name
  # --- edit svnserve.conf and authz file ---
  sed -i "s/$1/$new_name/" ./$new_name/conf/svnserve.conf
  sed -i "s/$1/$new_name/g" ./conf/authz
  echo $new_name
}


# === check input users ===
# check input users
# @param  $1=>dev[or tes]
# @param  $2=>$name
# @return $new_name
check_users(){
  typ='tests'
  if [ "$1" = 'dev' ]; then
    typ='developments'
  fi
  echo "input your item $typ user name and password"
  echo 'example "usr1-pwd1,usr2-pwd2,..."'
  read -p 'input:' users

  if [ "$users" = 'q' ]; then
    exit 0  #///////////////////////////////////////////////////////////////////////////////////////////////
  fi

  if [ -z "$users" ]; then
    echo ''
    echo 'you input anything!'
    echo ''
    check_users $1
  fi

  arr=$(strToarray , $users)
  if [ "${#arr[@]}" -le 0 ]; then
    echo ''
    echo 'input error! try again'
    echo ''
    check_users $1
  fi

  for s in $arr; do
    str=$(echo "$s" | awk '/^([0-9a-zA-Z]+)-([0-9a-zA-Z]+)$/')  # ///////////////////////////////////////////////
    len=${#str}
    if [ "$len" -le 0 ]; then
      echo ''
      echo 'input users error, please try again!'
      echo ''
      break
      check_users $1
    fi
  done
  # --- Check if the user already exists ---
  for uStr in $arr; do
    uArr=$(strToarray - $uStr)
    uArr=($uArr)
    uName=${uArr[0]}
    have=$(grep -w $uName /srv/svn/conf/passwd)
    if [ "$have" ]; then
      echo ''
      echo 'the user already exists, try again'
      echo ''
      check_users $1
    fi
  done

  # --- edit passwd file ---
  num=${2##*_}
    #user_0 = 123456
    #user_0_tes = 123456
  for uStr in $arr; do
    uArr=$(strToarray -, ${uStr})
    uArr=($uArr)
    uName=${uArr[0]}
    uPawd=${uArr[1]}
    sed -i "/${num}_tes/a\ ${uName} = ${uPawd}\n" ./conf/passwd
    users_str+=', '$uName
  done

  # --- edit authz  file ---
  re_str="user_${num}_tes"
  if [ "$1" = 'dev' ]; then
    re_str="user_${num}"
  fi

  sed -i "s/${re_str}/${users_str}/" ./conf/authz
  #grounp_null_0_dev = user_0
  #grounp_null_0_tes = user_0_tes
}


# ---------------------------------------------------------------------------------------------------------------------

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




#read -p 'input:' new_name
#echo "$new_name" | awk '/^[0-9a-zA-Z]+$/'
#echo "$new_name" | awk '/^[0-9a-zA-Z][a-z0-9A-Z_-]+$/'
#andy=$(( $new_name < 1 ? 23 : 98))

#sed -n "s/user_0/andychen/pg" /srv/svn/conf/passwd
#grep -q "user_0" /srv/svn/conf/passwd # && echo "yes" || echo 'no'
#andy= sed -n "s/user_0/andychen/g" /srv/svn/conf/passwd
#    arr=(1 7 3 6)
#    andy='0000'
#    for (( i=0; i<4; i++)); do
#      echo ${arr[$i]}
#      andy+=${arr[$i]}
#
#      if [ "$i" = 0 ]; then
#        andy+='--'
#      else
#        andy+=','
#      fi
#    done
#echo $andy

