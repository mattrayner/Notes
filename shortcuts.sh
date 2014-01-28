#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/bPlanHQ/

    #Check to see if we are doing something with our project
    if (( $# >= 2 ))
    then
	#Launch Server
	if [ $2 = "." ]; then
	    rails s
	#Remove and restart the database
	elif [ $2 = "reset" ];then
	    rake db:drop
	    rake db:create
	    rake db:migrate
	    rake db:seed
	fi
    fi
elif [ $1 = "save" ];then
    cp -v ~/.bashrc ~/Notes/backups/bashrc.backup
    cp -v ~/.bash_profile ~/Notes/backups/bash_profile.backup
elif [ $1 = "restore" ];then
    cp -v ~/Notes/backups/bashrc.backup ~/.bashrc
    cp -v ~/Notes/backups/bash_profile.backup ~/.bash_profile
elif [ $1 = "pull" ];then
    source ~/Notes/helper/pull.sh
elif [ $1 = "push" ];then
    source ~/Notes/helper/push.sh
elif [ $1 = "status" ];then
    CURRENTDIR=$(pwd)
    . nts
    git status
    cd $CURRENTDIR
elif [ $1 = "dtp" ];then
    cd ~/Desktop/
elif [ $1 = "nts" ];then
    cd ~/Notes
elif [ $1 = "update" ];then
    emacs ~/Notes/shortcuts.sh
elif [ $1 = "rc" ];then
    emacs ~/.bashrc
elif [ $1 = "profile" ];then
    emacs ~/.bash_profile
elif [ $1 = "," ];then
    cd ~
elif [ $1 = "dld" ];then
    cd ~/Downloads/
elif [ $1 = "doc" ];then
    cd ~/Documents/
elif [ $1 = "yelp" ];then
    chrome 'http://yelp.co.uk'
elif [ $1 = "facebook" ];then
    chrome 'http://facebook.com'
fi
