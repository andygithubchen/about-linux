#/bin/bash/

# Title : auto create new git repositories
# Date  : Sun Apr 19 21:22:38 CST 2015
# Author: andychen (bootoo@sina.cn)

# 参数赋值 ===========================================================
local_ip=127.0.0.1
item_name=new



# editor gitosis config
git clone git@${local_ip}:gitosis-admin.git


find=$(find ./ -name  "*.pub")
if [ ${find} ];then
  echo ""
  echo "+--------------------------------------+"
  echo "| not found public keys                |"
  echo "+--------------------------------------+"
  echo ""
  exit 0
fi

for file in `ls ./ | grep "*develop.pub"`; do
  file=${file/.pub/' '}
  dev_members=${file}
done

for file in `ls ./ | grep "*test.pub"`; do
  file=${file/.pub/' '}
  tes_members=${file}
done



mv ./*.pub ./gitosis-admin/keydir

cd gitosis-admin/

echo "
  [group ${item_name}_develop]
  writable = ${item_name}
  members  = ${dev_members} 

  [group ${item_name}_test]
  readonly = ${item_name}
  members  = ${tes_members} 



" > ./gitosis.conf




