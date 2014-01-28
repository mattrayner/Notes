#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/bPlanHQ/
elif [ $1 = "save" ];then
    cp -v ~/.bashrc ~/Notes/backups/bashrc.backup
    cp -v ~/.bash_profile ~/Notes/backups/bash_profile.backup
elif [ $1 = "restore" ];then
    cp -v ~/Notes/backups/bashrc.backup ~/.bashrc
    cp -v ~/Notes/backups/bash_profile.backup ~/.bash_profile
elif [ $1 = "dtp" ];then
    cd ~/Desktop/
elif [ $1 = "nts" ];then
    cd ~/Notes
elif [ $1 = "update" ];then
    emacs ~/Notes/shortcuts.sh
elif [ $1 = "rc" ];then
    emacs ~/.bashrc
elif [ $1 = "profile" ];then
<<<<<<< HEAD
    nano ~/.bash_profile
elif [ $1 = "," ];then
    cd ~
=======
    emacs ~/.bash_profile
>>>>>>> 884175e12f44c02823e698e515424eb0a9e99850
elif [ $1 = "dld" ];then
    cd ~/Downloads/
elif [ $1 = "doc" ];then
    cd ~/Documents/
elif [ $1 = "yelp" ];then
    chrome 'http://yelp.co.uk'
fi
