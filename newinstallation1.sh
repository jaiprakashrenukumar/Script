#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else

#a=`hostname -I | cut -d " " -f "1"`
#echo $a
echo "Updating and Upgrading"
apt-get update
apt-get install sshpass -y
apt-get install wget -y
#sshpass -p "Bbc#NIT@$VR" ssh -o StrictHostKeyChecking=no root@192.168.3.204 scp -r pkg/ root@192.168.5.245:/opt
echo "coping the package"
#sshpass -p 'Bbc#NIT@$VR' ssh -o StrictHostKeyChecking=no root@192.168.3.204 " scp -r /opt/pkg root@$a:/opt"
mkdir -p /opt/pkg
mkdir -p /opt/pkg/vspace_x12
mkdir -p /opt/pkg/vspace_x14

cd /opt/pkg

wget http://192.168.5.245/pkg/firefox-46.0.tar.bz2
#http://192.168.5.245/pkg/vspace-l_3.2.2.27.24515.241.sh
wget http://192.168.5.245/pkg/wps-office_10.1.0.5672-a21_amd64.deb

cd /opt/pkg/vspace_x12

wget http://192.168.5.245/pkg/vspace-l_3.2.2.27.24515.241.sh

cd /opt/pkg/vspace_x14

wget http://192.168.5.245/pkg/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64/setup
wget http://192.168.5.245/pkg/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64/uninstall
wget http://192.168.5.245/pkg/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64.deb

sudo apt-get install dialog

 cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
 options=(1 "vim" off 
 2 "firefox" off
 3 "openssh for xubuntu 12" off
 4 "openssh for xubuntu 14" off
 5 "Google Chrome" off
 6 "NTP" off
 7 "vspace for Xubuntu 12" off
 8 "vspace for Xubuntu 14" off)
 choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

clear
 for choice in $choices
 do
 case $choice in

1)
 echo " install vim"
 apt-get install vim -y
 ;;

2)
echo "Install firefox"
 apt-get install firefox -y
 ;;

3)
echo "Install openssh server for xubuntu 12"
apt-get install openssh-server -y
echo "change root passwd"
passwd root
 ;;

4)
echo "Install openssh server for xubuntu 14"
apt-get install openssh-server -y
cd /etc/ssh
wget http://192.168.5.245/pkg/sshd_config
service ssh restart
echo "change root passwd"
passwd root
;;


5)
echo "Install Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
 sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
 apt-get update 
 apt-get install google-chrome-stable -y
 ;;

6)

echo "Install ntp"
apt-get install ntp -y
 ;;

7)

echo "Install vspace Xubuntu 12"
cd /opt/pkg/vspace_x12
chmod 755 -R /opt/pkg/vspace_x12
./vspace-l_3.2.2.27.24515.241.sh
;;

8)

echo "Install vspace Xubuntu 14"
cd /opt/pkg/vspace_x14
chmod 755 -R /opt//opt/pkg/vspace_x14
./setup
;;

esac
 done
fi
