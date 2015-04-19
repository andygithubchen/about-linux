#/bin/bash/

# Title : auto setup git repositories
# Date  : Sun Apr 19 21:22:38 CST 2015
# Author: andychen (bootoo@sina.cn)

# 参数赋值 ===========================================================
group=gitrep
user=gitrep
git_user_name=andychen
git_user_email=bootoo@sina.cn
path=/srv/git
rep_path=${path}/repositories
gitosis_path=https://github.com/res0nat0r/gitosis.git
local_ip=127.0.0.1




# 基础安装 ===========================================================
sudo apt-get update
sudo apt-get install git-core
sudo apt-get install gitosis
sudo apt-get install openssh-server 
sudo apt-get install openssh-client 
sudo apt-get install openssh-client 
sudo apt-get install python-setuptools


# 创建个人公钥和私钥 =================================================


# 开始 ===============================================================
# add group and user
sudo groupadd ${group}
sudo useradd -g ${group} -M -d ${path}  -s /sbin/nologin ${user} $> /dev/null 

# build git repositories
sudo mkdir -p ${rep_path} 
sudo chown ${group}:${user} ${rep_path} 
sudo chmod 755 ${rep_path} 

# config git user info
sudo git config --global user.name "${git_user_name}"
sudo git config --global user.email "${git_user_email}"

# install gitosis
cd /tmp
git clone ${gitosis_path}
cd ./gitosis
sudo python setup.py install
cd -

# config gitosis
cd ~
ssh-keygen -t rsa
cp ~/.ssh/id_rsa.pub /tmp
sudo -H -u ${user} gitosis-init < /tmp/id_rsa.pub
sudo chmod 755 ${rep_path}/gitosis-admin.git/hooks/post-update

# editor gitosis config
git clone git@${local_ip}:gitosis-admin.git
cd gitosis-admin/

echo "
  [gitosis]


  [group gitosis-admin]
  writable = gitosis-admin
  members  = admin@admin



  [group item2_develop]
  writable = item2
  members  = e@develop f@develop

  [group item2_test]
  readonly = item2
  members  = g@test h@test



" > ./gitosis.conf




