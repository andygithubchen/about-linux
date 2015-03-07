脚本自动化安装SVN服务和仓库的配置,目前只支持ubuntu系统，centos待开发。

## install
在安装SVN服务的同时已经默认创建了10个空仓库 null_0,null_2,null_3 .... null_9
```
  $ chmod +x install.sh

  $ ./install.sh
```
## create svn repository
启用你所选择的空仓库，为这个这个空仓库重命名和配置用户及用户密码用户权限。就生成了一个你想要的SVN仓库了
```
  $ chmod +x create.sh

  $ ./create.sh

  按提示操作即可
```
