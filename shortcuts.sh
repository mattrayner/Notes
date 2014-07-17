#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/bPlanHQ/

    #Check to see if we are doing something with our project
    if (( $# >= 2 ))
    then
	#Launch Server
	if [ $2 = "." ]; then
	    rails s
	#Migrate the project database
	elif [ $2 = "migrate" ]; then
	    rake db:migrate
	#Remove and restart the database
	elif [ $2 = "reset" ];then
	    rake db:drop && rake db:create && rake db:migrate RAILS_ENV=test && rake db:migrate & rake db:seed
	elif [ $2 = "pull" ];then
	    echo "==== PULL 'bPanHQ' ===="
	    echo "LOCAL GIT STATUS:"
	    echo
            git status
	    echo
	    read -p "Continue pull? (Yy): " -n 1 -r
	    echo    # (optional) move to a new line
	    if [[ $REPLY =~ ^[Yy]$ ]];then
                git pull
		BPULLRESULT=TRUE
            else
                echo "NO PULL"
		BPULLRESULT=FALSE
            fi
	    echo
	elif [ $2 = "push" ];then
	    echo "==== PUSH 'bPlanHQ' ===="
	    echo "PULL FIRST:"
            echo
	    . . pull

	    echo
	    if [[ $BPULLRESULT = TRUE ]];then
		echo "ADDING:"
		git add . -A
		read -p "COMMIT WITH MESSAGE: " COMMITMESSAGE
		echo
		git commit -m "$COMMITMESSAGE"
		echo "PUSHING:"
		echo
		git push
		echo
		echo "DONE"
		echo
	    fi
        elif [ $2 = "deploy" ];then
	    git push live
	    cap deploy
        elif [ $2 = "deploy:migrate" ];then
	    cap deploy:stop
	    cap deploy:migrate
	    cap deploy:start
	fi
    fi
elif [ $1 = "plan" ];then
    osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' -e 'tell application "Terminal" to do script ". . ." in selected tab of front window'
    sleep 5s
    chrome "http://0.0.0.0:3344/"
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
elif [ $1 = "showdown" ];then
    sudo shutdown -h now
fi
