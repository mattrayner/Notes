#!/bin/sh -x

CURRENTPATH=$(pwd)
echo "======================"
echo "== Pushing to git   =="
echo "======================"
echo "= Commit message:    ="
read -e MESSAGE
echo "====================="
echo "= Saving files...   ="
echo ""
. save
echo ""
echo "====================="
echo "= Changing dir...   ="
. nts
echo "====================="
echo "= Adding files...   ="
git add .
echo "====================="
echo "= Commiting files.. ="
echo ""
git commit -m "$MESSAGE"
echo ""
echo "====================="
echo "= Pushing commit... ="
echo ""
git push
echo ""
echo "====================="
cd $CURRENTPATH