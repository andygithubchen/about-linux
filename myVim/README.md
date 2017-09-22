


我正在使用的vim ,自己加入了多个主题供候选。

## install
```
  $ chmod +x install.sh

  $ ./install.sh
```

## 使用
### 插件管理
1. :BundleClean (清理未使用的插件)

2. :BundleInstall (安装新增的插件)

3. :BundleInstall! (升级所有插件)


### 一些快捷键
1. Ctrl + p (快速模糊搜索文件)

2. H，L切换标签页；Delete关闭当前标签页

3. Ctrl + h/j/k/l （拆分窗口之间移动）

4. :Ack or <leader> + a (切换Ack搜索)

5. viw 选中一个单词，然后按S" ，就给这个单词加上了双引号

6. vim里符号对齐，语法为:'<,'>Tab /= (这是等号对齐)，[这是一个视频教程](http://vimcasts.org/episodes/aligning-text-with-tabular-vim/)

7. F3 查看修改记录
8. F4 查看对齐情况
9. F5 列出方法列表
10. F6 打开树状目录结构
11. F12 -> Toggle Mouse

如果是在iTerm2中使用，那上面7、8、9是用不了的，要配置iTerm2的Preferences->Profiles->keys
里选择Send Text with "vim" Special Characters分别配置为 [1;GundoToggle\r ，[1;IndentGuidesToggle\r ，[1;TagbarToggle\r ，[1;NERDTreeToggle\r
才可以使用。


源码来自 https://github.com/humiaozuzu/dot-vimrc
