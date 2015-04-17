#!/bin/sh

red='\033[0;31m'
green='\033[0;32m'
cyan='\033[0;36m'
NC='\033[0m'

RSPECSTATUS="*"
CUCUMBERSTATUS="*"

echo
echo
echo "/======================\\"
echo "||     EASY TESTER    ||"
echo "||--------------------||"
echo "|| TESTING DIRECTORY: ||"
echo "------------------------"
CURRENTDIR=$(pwd)
echo -e "${cyan}${CURRENTDIR}${NC}"
echo "------------------------"
echo "||      PREPARING     ||"
echo "||      DATABASE      ||"
echo "------------------------"
echo
bundle exec rake db:test:prepare
echo
echo "------------------------"
echo "||       TESTING      ||"
echo "||        RSPEC       ||"
echo "------------------------"
echo
bundle exec rspec
RSPECSTATUS=$?
echo 
if [[ $RSPECSTATUS = 0 ]];then
    echo "------------------------"
    echo "||       TESTING      ||"
    echo "||       CUCUMBER     ||"
    echo "------------------------"
    echo
    bundle exec cucumber
    CUCUMBERSTATUS=$?
    echo 
fi
echo "------------------------"
echo "||       RESULTS      ||"
echo "||--------------------||"

# Write RSPEC status
if [[ $RSPECSTATUS = 0 ]];then
  echo -e "|| RSPEC: ${green}PASSED${NC}      ||"
else
  echo -e "|| RSPEC: ${red}FAILED(${RSPECSTATUS})${NC}   ||"
fi

# Write CUCUMBER status
if [[ $CUCUMBERSTATUS = 0 ]];then
  echo -e "|| CUCUMBER: ${green}PASSED${NC}   ||"
elif [[ $CUCUMBERSTATUS = "*" ]];then
  echo -e "|| CUCUMBER: ${red}NOT RUN${NC}  ||"
else
  echo -e "|| CUCUMBER: ${red}FAILED(${CUCUMBERSTATUS})${NC}||"
fi

echo "||--------------------||"
echo "||       SUMMARY      ||"
echo "||--------------------||"
if [ $RSPECSTATUS = 0 ] && [ $CUCUMBERSTATUS = 0 ]
then
  echo -e "||     ${green}ALL GREEN!${NC}     ||"
else
  echo -e "||        ${red}HAULT!${NC}      ||"
fi
echo "\\======================/" 