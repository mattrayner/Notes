#!/bin/sh -x

if [ $1 = "." ];then
    cd ~/bPlanHQ/
elif [ $1 = "stl" ];then
    elinks /usr/share/doc/stl-manual/html/stl_index.html
elif [ $1 = "dtp" ];then
    cd ~/Desktop/
elif [ $1 = "nts" ];then
    cd ~/Notes
elif [ $1 = "update" ];then
    nano ~/Notes/shortcuts.sh
fi
