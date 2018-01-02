#!/bin/bash
# Program name: to check userlogin 
#Author : Jaiprakash
#Date : 16-08-2017
mypath=/home/userlogin/$(date +"%Y%m")
userdetail=/home/userlogin
mkdir $userdetail/$(date +"%Y%m")
cat /etc/passwd | grep home | grep /bin/bash > $userdetail/userdetails.txt
cat $userdetail/userdetails.txt | cut -d ':' -f 1 > $userdetail/Userlist.txt
date >> $mypath/usercheck.txt
date >> $mypath/notloggedin_user.txt
cd $mypath
cat $userdetail/Userlist.txt |  while read Names
do
    date >> $mypath/login.txt
    netstat -n | grep "$Names" >> $mypath/login.txt
    if [ $? -eq 0 ]; then
    echo "user $Names is loggedin" >> $mypath/usercheck.txt
    else
    echo "user $Names not loggedin" >> $mypath/usercheck.txt && echo "user $Names not loggedin" >> $mypath/notloggedin_user.txt
    fi

done
     echo "           " >> $mypath/usercheck.txt
     echo "           " >> $mypath/usercheck.txt
     echo "           " >> $mypath/notloggedin_user.txt

