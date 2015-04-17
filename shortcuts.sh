#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/nature/laserwolf/

    #Check to see if we are doing something with our project
    if (( $# >= 2 ))
    then
    	#Launch Server
    	if [ $2 = "." ]; then
    	    sudo nginx
          . . shunter
    	    foreman start
    	#Launch a rails server for foreman
      elif [ $2 = "s" ]; then
          be rails s -p 5000
      #Migrate the project database
    	elif [ $2 = "migrate" ]; then
    	    be rake db:migrate
    	#Remove and restart the database
    	elif [ $2 = "reset" ];then
    	    echo "Dropping Database...."
    	    be rake db:drop --trace
    	    echo "Done"
    	    echo "====================="
    	    echo "Creating Database..."
                be rake db:create --trace
    	    echo "Done"
                echo "====================="
    	    echo "Migrating for test..."
    	    be rake db:migrate RAILS_ENV=test --trace
    	    echo "Done"
                echo "====================="
    	    echo "Migrating development..."
    	    be rake db:migrate --trace
    	    echo "Done"
                echo "====================="
    	    echo "Seeding database..."
    	    be rake db:seed --trace
    	    echo "Done"
                echo "====================="
    	elif [ $2 = "production" ];then
    	    echo "Drop database"
    	    be RAILS_ENV=production rake db:drop
    	    echo "Done"
    	    echo "Create database"
    	    be RAILS_ENV=production rake db:create
    	    echo "Done"
    	    echo "Migrate database"
    	    be RAILS_ENV=production rake db:migrate
    	    echo "Done"
    	    echo "Seed database"
    	    be RAILS_ENV=production rake db:seed
    	    echo "Done"
    	    echo "Precompile Assets"
    	    be RAILS_ENV=production rake assets:precompile
    	    echo "Done"
    	    echo "Launcing server"
    	    be rails s -e production
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
      elif [ $2 = "shunter" ];then
        echo "Updating Shunter:"
        
        for dir in `ls -d ~/nature/shunter*`
        do
          echo "=================="
          echo "Updating:"
          echo $dir
          echo "------------------"
          echo
          cd $dir
          git checkout master
          git reset --hard origin/master
          git pull origin master
          npm install
          echo
          echo "Done $dir"
          echo
        done

        . .
      fi
    fi
elif [ $1 = "start" ];then
    osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' -e 'tell application "Terminal" to do script ". . ." in selected tab of front window'
    sleep 10
    chrome "http://local.nature.com/"
elif [ $1 = "rspec" ];then
    if (( $# >= 2 ))
    then
        be rspec $2
    else
        be rspec
    fi

    SHORTCUTRSPECSTATUS=$?

    red='\033[0;31m'
    green='\033[0;32m'
    cyan='\033[0;36m'
    NC='\033[0m' # No Color

    CURRENTDIR=$(pwd)

    echo
    echo
    echo "========================"
    echo "|| LAZY TEST RESULTS: ||"
    echo "||--------------------||"
    echo "||      DIRECTORY     ||"
    echo "------------------------"
    echo -e "${cyan}${CURRENTDIR}${NC}"
    echo "------------------------"
    echo "||       RESULTS      ||"
    echo "||--------------------||"
    
    # Write RSPEC status
    if [[ $SHORTCUTRSPECSTATUS = 0 ]];then
    	echo -e "|| RSPEC: ${green}PASSED${NC}      ||"
    else
    	echo -e "|| RSPEC: ${red}FAILED(${SHORTCUTRSPECSTATUS})${NC}   ||"
    fi
    echo "========================" 
elif [ $1 = "test" ];then
	# Wipe the teminal buffer
	k
	
    be rspec
    SHORTCUTRSPECSTATUS=$?
    be cucumber
    SHORTCUTCUCUMBERSTATUS=$?

    red='\033[0;31m'
    green='\033[0;32m'
    cyan='\033[0;36m'
    NC='\033[0m' # No Color

    CURRENTDIR=$(pwd)

    echo
    echo
    echo "========================"
    echo "|| LAZY TEST RESULTS: ||"
    echo "||--------------------||"
    echo "||      DIRECTORY     ||"
    echo "------------------------"
    echo -e "${cyan}${CURRENTDIR}${NC}"
    echo "------------------------"
    echo "||       RESULTS      ||"
    echo "||--------------------||"
    
    # Write RSPEC status
    if [[ $SHORTCUTRSPECSTATUS = 0 ]];then
    	echo -e "|| RSPEC: ${green}PASSED${NC}      ||"
    else
    	echo -e "|| RSPEC: ${red}FAILED(${SHORTCUTRSPECSTATUS})${NC}   ||"
    fi
    
    # Write CUCUMBER status
    if [[ $SHORTCUTCUCUMBERSTATUS = 0 ]];then
    	echo -e "|| CUCUMBER: ${green}PASSED${NC}   ||"
    else
    	echo -e "|| CUCUMBER: ${red}FAILED(${SHORTCUTCUCUMBERSTATUS})${NC}||"
    fi
    
    echo "========================" 
elif [ $1 = "save" ];then
    cp -v ~/.* ~/Notes/backups/
elif [ $1 = "restore" ];then
    cp -v ~/Notes/backups/.* ~/
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
    vim ~/Notes/shortcuts.sh
elif [ $1 = "rc" ];then
    vim ~/.bashrc
elif [ $1 = "profile" ];then
    vim ~/.bash_profile
elif [ $1 = "vimrc" ];then
    vim ~/.vimrc
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
elif [ $1 = "tapas" ];then
    CURRENTDIR=$(pwd)
    cd ~
    if (( $# >= 2 ))
    then
        if [ $2 = "config" ];then
            ruby-tapas-downloader configure -e "npddevelopmentteam@macmillan.co.uk" -p "wat.2012" -d ~/RubyTapas
        elif [ $2 = "setup" ]; then
            gem install ruby-tapas-downloader
            . tapas config
            . tapas
    	fi
    else
        ruby-tapas-downloader download
    fi
    cd $CURRENTDIR
fi
