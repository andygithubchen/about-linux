#/bin/bash/

# Title : auto create new git repositories
# Date  : Sun Apr 19 21:22:38 CST 2015
# Author: andychen (bootoo@sina.cn)


# 基本检查 =================================================
# 要求用root用户执行
if [ `whoami` != 'root' ];then
  echo "+----------------------------+"
  echo "|  plase use root user       |"
  echo "+----------------------------+"
  exit 0
fi
if [ -z ${1} ];then
  echo "+------------------------------------+"
  echo "|  plase input your repositoy name   |"
  echo "+------------------------------------+"
  exit 0
fi

# 参数赋值 ===========================================================
user=git     #一定要是git
group=git    #一定要是git ，同上。尚不明原因
item_name=${1}
repository=${item_name}.git
server_ip=192.168.73.128
rep_path=/home/${user}/repositories/

# 收集仓库用户的公钥 ================================================
find=`find ./ -name "*.pub"`
if [ ${#find[@]} -eq 0 ];then
  echo ""
  echo "+--------------------------------------+"
  echo "| not found public keys                |"
  echo "+--------------------------------------+"
  echo ""
  exit 0
fi

# 不做递归find
for file in `find -maxdepth 1 -name "*@develop.pub"`; do
  file=${file/.pub/}
  file=${file/.\//}
  dev_members="${dev_members} ${file}"
done

for file in `find -maxdepth 1 -name "*@test.pub"`; do
  file=${file/.pub/}
  file=${file/.\//}
  tes_members="${tes_members} ${file}"
done




# 将仓库用户配置到gitosis-admin.git ==================================
git clone git@${server_ip}:gitosis-admin.git

cp ./*.pub ./gitosis-admin/keydir
cd gitosis-admin/

# 取得仓库创建者在gitosis-admin里的用户名(超级用户名)
obj=`cat ./gitosis.conf | grep "^members = "`
admin_name=${obj/members = /}
dev_members="${dev_members} ${admin_name}"

chmod a+w ./gitosis.conf
echo "
# =================================== ${item_name} =================================== #
[group ${item_name}_develop]
writable = ${item_name}
members  =${dev_members}

[group ${item_name}_test]
readonly = ${item_name}
members  =${tes_members}
" >> ./gitosis.conf

git add .
git commit -am "add ${item_name} project and users"
git push

cd - > /dev/null
rm -fr ./gitosis-admin


# 创建${item_name}仓库 ==============================================
# 创建仓库
mkdir -p ${rep_path}${repository}
cd ${rep_path}${repository}
git init --bare
chown -R ${group}:${user} ${rep_path}${repository}
cd - > /dev/null

# 初始化此仓库
tmp_file=`date +%Y_%m_%d`_${item_name}
mkdir ${tmp_file}
cd ${tmp_file}
git init
echo `date` > README.md
git add .
git commit -am "initial version"
git remote add origin git@${server_ip}:${repository}
git push origin master

cd - > /dev/null
rm -fr ${tmp_file}


echo '+---------------------------------------------------------------+';
echo '|  succeed !';
echo '|  ';
echo '|  use:';
echo '|  git clone git@'${server_ip}':'${repository};
echo '|  or';
echo '|  git clone git@'${server_ip}':'${rep_path}${repository};
echo '+---------------------------------------------------------------+';



