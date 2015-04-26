脚本自动化安装GIT服务和创建GIT仓库

这两个脚本都要在root用户下执行

----------

## config
1). setup.sh 文件
```Bash
  # 找到这三处,按自己的情况做修改。

  git_user_name=andychen         #git用户名，使用git仓库时，你所有的操作都会用这个名字来记录。
  git_user_email=bootoo@sina.cn  #git用户名对应的邮箱地址。
  local_ip=192.168.73.128        #你将要搭建git仓库的此Linux IP地址。

```

2). create.sh 文件
```Bash
  # 找到这此行,按自己的情况做修改。

  server_ip=192.168.73.128       #同上， 你将要搭建git仓库的此Linux IP地址。

```

## install
安装GIT服务,GIT仓库的基础配置和搭建
```Bash
  $ chmod +x setup.sh
  $ su root          #如果当前是root用户就不用这行了
  $ ./setup.sh
```
## create new git repository
1. 将小伙伴的公钥拿来（建议你的小伙伴使用“ssk-keygen -t rsa -P '' ”来生成公钥）
2. 分别按小伙伴在团队中的角色重命名他们的公钥，如：       
   atom ----- 开发人员 ------- 就将他的id_rsa.pub 重命名为 atom@develop.pub       
   andy ----- 开发人员 ------- 就将他的id_rsa.pub 重命名为 andy@develop.pub        
   mali ----- 测试人员 ------- 就将她的id_rsa.pub 重命名为 mali@test.pub        
   遵循这样的重命名规范后,对应的开发人员就有读写权限，而测试人员就只有读的权限。         

3. 接着就把上一步的公钥全部放到和create.sh文件同级的目录下,如：     
   ../setupGit/atom@develop.pub      
   ../setupGit/andy@develop.pub      
   ../setupGit/create.sh      
   ../setupGit/mali@test.pub       

4. 最后就是执行create.sh文件,如要创建一个名叫time的仓库：
```Bash
  $ chmod +x create.sh
  $ su root          #如果当前是root用户就不用这行了
  $ ./create.sh time

  # 执行结束后，如果顺利就会有克隆地址输出，直接复制去克隆就是了！
```
