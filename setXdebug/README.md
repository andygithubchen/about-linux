给php安装xdebug扩展

## install
  安装前请对应自己的php安装目录，将install_xdebug.sh中的所有“/alidata/server/”修改为你自己的php安装目录
```
  $ chmod +x install_xdebug.sh

  $ ./install_xdebug.sh
```
最后修改php.ini文件中的下列值：
error_reporting = E_ALL
display_error = On
html_error = On
