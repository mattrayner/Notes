
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:~/bin
export PATH=$PATH:/usr/local/bin

export ANDROID_HOME=/usr/local/opt/android-sdk

#Quick cd up
alias ..='cd ..'

#Quick terminal clear
alias cls='clear'

#Kill the terminal's buffer
alias k="osascript -e 'tell application \"System Events\" to keystroke \"k\" using command down'"

alias p='cd ~/projects'

#Execute our shortcuts file with parameters passed
shortcut() {
    source ~/Notes/shortcuts.sh $1 $2
}
alias .=shortcut

#EasyTester
easy_tester() {
    source ~/Notes/scripts/easy_tester.sh
}
alias et=easy_tester

alias be='bundle exec'

function extract()      # Handy Extract Program
{
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function my_ip() # Get IP adress on WiFi.
{
    MY_IP=$(/sbin/ifconfig en0 | awk '/inet/ { print $2 } ' | 
	sed -e s/addr://)

    echo ${MY_IP:-"Not connected"}
}

function my_lan_ip() # Get IP address on Ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
        sed -e s/addr://)

    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

alias restart='sudo shutdown -r now'

#Launch a url in chrome using this helper function
function chrome() {
    if [ -z "$1" ]; then
        echo "chrome: Please supply a web address"
    else
        /usr/bin/open -a "/Applications/Google Chrome.app" "$@"
    fi
}

