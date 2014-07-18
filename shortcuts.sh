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
	    echo "Dropping Database...."
	    rake db:drop
	    echo "Done"
	    echo "====================="
	    echo "Creating Database..."
            rake db:create
	    echo "Done"
            echo "====================="
	    echo "Migrating for test..."
	    rake db:migrate RAILS_ENV=test
	    echo "Done"
            echo "====================="
	    echo "Migrating development..."
	    rake db:migrate
	    echo "Done"
            echo "====================="
	    echo "Seeding database..."
	    rake db:seed
	    echo "Done"
            echo "====================="
	elif [ $2 = "production" ];then
	    echo "Drop database"
	    RAILS_ENV=production rake db:drop
	    echo "Done"
	    echo "Create database"
	    RAILS_ENV=production rake db:create
	    echo "Done"
	    echo "Migrate database"
	    RAILS_ENV=production rake db:migrate
	    echo "Done"
	    echo "Seed database"
	    RAILS_ENV=production rake db:seed
	    echo "Done"
	    echo "Launcinh server"
	    rails s -e production
	    echo "Done"
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
elif [ $1 = "nuke" ];then
    if [ $2 = "mysql" ]; then
	echo "Nuking MySQL..."
	brew uninstall mysql
	sudo rm /usr/local/mysql
	sudo rm -rf /usr/local/mysql*
	sudo rm -rf /usr/local/var/mysql
	sudo rm -rf /usr/local/var/mysql*
	sudo rm -rf /Library/StartupItems/MySQLCOM
	sudo rm -rf /Library/PreferencePanes/My*
	sudo rm -rf /Library/Receipts/mysql*
	sudo rm -rf /Library/Receipts/MySQL*
	sudo rm -rf /var/db/receipts/com.mysql.*
	echo "Done"
        echo "====================="
	echo "Re-building"
	brew update
	brew install mysql
	unset TMPDIR
	mkdir /usr/local/var/
	mkdir /usr/local/var/mysql
	mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
	mysql.server start
	mysqladmin -u root password ''
	echo "Done"
        echo "====================="
    fi
fi
