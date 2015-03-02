# palse use "sudo" execution

#sudo apt-get update
#sudo apt-get install ntpdate

sudo rm /etc/localtime
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date
sudo reboot
