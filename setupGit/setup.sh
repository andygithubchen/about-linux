#/bin/bash/

# Title : auto setup git repositories
# Date  : Sun Apr 19 21:22:38 CST 2015
# Author: andychen (bootoo@sina.cn)


# 要求用root用户执行 =================================================
if [ `whoami` != 'root' ];then
  echo "+----------------------------+"
  echo "|  plase use root user       |"
  echo "+----------------------------+"
  exit 0
fi


# 参数赋值 ===========================================================
group=git   #一定要是git
user=git    #一定要是git ，同上。尚不明原因
git_user_name=andychen
git_user_email=bootoo@sina.cn
rep_path=/home/${user}/repositories
gitosis_path=https://github.com/res0nat0r/gitosis.git
local_ip=192.168.73.128




# 基础安装 ===========================================================
#apt-get update
#apt-get install git-core
#apt-get install gitosis
#apt-get install openssh-server
#apt-get install openssh-client
#apt-get install openssh-client
#apt-get install python-setuptools


# 开始 ===============================================================
# add group and user
groupdel ${group}
userdel ${user}

useradd -m ${user}
passwd ${user}
groupadd ${group}

# build git repositories
mkdir -p ${rep_path}
chown ${group}:${user} ${rep_path}
chmod 755 ${rep_path}

# config git user info
git config --global user.name "${git_user_name}"
git config --global user.email "${git_user_email}"

# install gitosis
cd /tmp
git clone ${gitosis_path}
cd ./gitosis
python setup.py install
cd -


# 配置gitosis ========================================================

# create pravite key
cd ~
ssh-keygen -t rsa -P ''
cp ~/.ssh/id_rsa.pub /tmp
chmod 777 /tmp/id_rsa.pub
sudo -H -u ${user} gitosis-init < /tmp/id_rsa.pub
chmod 755 ${rep_path}/gitosis-admin.git/hooks/post-update
echo "#-----------请不要移动以上内容----------#" >> ${rep_path}/gitosis-admin.git/gitosis.conf

# show repositories dir
echo "+-----------------------------------------------------------------------+"
echo "+ use: "
echo "+ git clone git@${local_ip}:gitosis-admin.git"
echo "+ * the really passwd is "`whoami`"'s passwd "
echo "+-----------------------------------------------------------------------+"



