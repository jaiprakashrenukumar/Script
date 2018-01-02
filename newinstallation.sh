#!/bin/bash

if [[ $EUID -ne 0 ]]; then
 echo "This script must be run as root" 
 exit 1
else
 #Update and Upgrade
echo "Updating and Upgrading"
apt-get update

sudo apt-get install dialog

 cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
 options=(1 "vim" off 
 2 "firefox" off
 3 "openssh" off
 4 "Google Chrome" off
 5 "NTP" off
 6 "vspace for Xubuntu 12" off)
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

echo "Install openssh server"
 apt-get install openssh-server -y
 ;;

4)

echo "Install Chrome"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
 sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
 apt-get update 
 apt-get install google-chrome-stable -y
 ;;

5)

echo "Install ntp"
apt-get install ntp -y
 ;;

6)

echo "Install vspace"
cd /opt/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64
chmod 755 -R /opt/vspace-l_4.0.20_qa_Ubuntu_14.04_amd64
./setup

esac
 done
fi
