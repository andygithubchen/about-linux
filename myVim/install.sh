#!/bin/bash


# auto install myVim shell script
# andy chen (bootoo@sina.cn)
# this myVim from github dot_vimrc item, and thank humiaozuzu.

echo ''
echo '================ bigen config ================'
echo ''

sudo apt-get update
sudo apt-get install vim-gtk
sudo apt-get install ack-grep ctags

echo ''
echo '========== delete old .vim files ============'
echo ''

# delete old .vim files =====================================
vim_old="~/.vim/"
vimrc_old="~/.vimrc"

if [-d "$vim_old"]; then
  rm -fr "$vim_old"
fi

if [-f "$vimrc_old"]; then
  rm "$vimrc_old"
fi

echo ''
echo '========= set up new .vim files ============'
echo ''
# set up new .vim files ===================================
mv ./.vim ~/
ln -s ~/.vim/vimrc ~/.vimrc

echo ''
echo 'succeed!!!!!!'
echo ''
