#!/bin/sh -x

CURRENTPATH=$(pwd)
echo "======================"
echo "== Pulling from git =="
echo "======================"
echo "= Change Directory   ="
. nts
echo "======================"
echo "=  Pulling...        ="
echo ""
git pull
echo ""
echo "======================"
echo "= Overwriting files  ="
echo ""
. restore
echo ""
echo "======================"
cd $CURRENTPATH