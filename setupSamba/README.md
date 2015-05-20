samb是一个linux与windows实现文件共享的一个服务,安装脚本支持ubuntu，centos。

## install
```
  $ chmod +x install_samba.sh

  $ ./install_samba.sh
```
已经创建了后面个共享文件 /srv/shareFile

windows下打开我的电脑，在地址栏中输入\\\192.168.160.136 然后回车（这里的ip地址输你自己linux上的ip），
就可以把windows下的文件放入share这个文件中了，到linux下就可以在/srv/shareFile目录下看到刚刚放入的文
件，建议在windows下将这个共享"映射网络驱动器"（鼠标右键)。
