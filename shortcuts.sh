#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/bPlanHQ/
elif [ $1 = "save" ];then
    cp -v ~/.bashrc ~/Notes/backups/bashrc.backup
    cp -v ~/.bash_profile ~/Notes/backups/bash_profile.backup
elif [ $1 = "restore" ];then
    cp -v ~/Notes/backups/bashrc.backup ~/.bashrc
    cp -v ~/Notes/backups/bash_profile.backup ~/.bash_profile
elif [ $1 = "stl" ];then
    elinks /usr/share/doc/stl-manual/html/stl_index.html
elif [ $1 = "dtp" ];then
    cd ~/Desktop/
elif [ $1 = "nts" ];then
    cd ~/Notes
elif [ $1 = "update" ];then
    nano ~/Notes/shortcuts.sh
elif [ $1 = "rc" ];then
    nano ~/.bashrc
elif [ $1 = "profile" ];then
    nano ~/.bash_profile
elif [ $1 = "," ];then
    cd ~
elif [ $1 = "dld" ];then
    cd ~/Downloads/
elif [ $1 = "doc" ];then
    cd ~/Documents/
elif [ $1 = "yelp" ];then
    chrome 'http://yelp.co.uk'
fi
