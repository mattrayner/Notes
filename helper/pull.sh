#!/bin/sh -x

CURRENTPATH=$(pwd)
echo "======================"
echo "== Pulling from git =="
echo "======================"
echo "= Change Directory   ="
. nts
echo "======================"
echo "= Pulling...         ="
PULLRESULT=$(git pull)
echo "======================"
if [ "$PULLRESULT" != "Already up-to-date." ]; then
    echo "= Overwriting files  ="
    echo ""
    . restore
    echo ""
    echo "======================"
else
    echo "= Up to date         ="
    echo "======================"
fi
cd $CURRENTPATH