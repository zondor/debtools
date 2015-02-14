#!/bin/bash
# Update git origins from o-auth and SSH to native https in all git repos found in each of specified directories {dir}
# Syntax: $ guorigin.sh {dir1} [{dir2} {dir3}...]

CNORMAL='\e[00m'
CHIGHLIGHT="\e[01;36m"
CERROR='\033[31m'
CSUCCESS='\e[32m'
ERRMASCOT='            __\n           / _)\n    .-^^^-/ /\n __/       /\n<__.|_|-|_|';
ERRCOUNT=0

if [ $# -lt 1 ]
  then
    echo -e "\n${CERROR}${ERRMASCOT}\nERROR: Incorrect arguments specified${CNORMAL}"
    echo "Usage: guorigin {dir1} [{dir2} {dir3}...]"   
    exit 0
fi

directories="${@:1}";

for dir in $directories
do
    if [ -d "$dir" ]; then    
        cd $dir>/dev/null;
        echo -e "\nScanning ${PWD}";
        cd ->/dev/null

        for d in `find $dir -name .git -type d`; do
            cd $d/.. > /dev/null
            echo -e "\n${CHIGHLIGHT}Updating `pwd`${CNORMAL}"
            CURRENT=`git config --get remote.origin.url`;
            echo -e "Current Origin: ${CURRENT}"
            FILTERBY="x-oauth-basic"
            FILTERBYSSH="git@github.com:"
            if [[ "${CURRENT}" =~ "${FILTERBY}" ]]; then
                STR_ARRAY=(`echo $CURRENT | tr '@'  "\n"`)
                NEW="https://${STR_ARRAY[1]}"
                if [[ "${NEW}" =~ "https://github.com/".*".git" ]] ; then
                    `git remote set-url origin "${NEW}"`
                    NEWCHANGED=`git config --get remote.origin.url`;
                    if [[ "${NEW}" =~ ${NEWCHANGED} ]] ; then
                        echo -e "${CSUCCESS}Origin changed to ${NEWCHANGED}${CNORMAL}"
                    else
                        ERRCOUNT=$[ERRCOUNT + 1]
                        echo -e "${CERROR}ERROR: could not change origin${CNORMAL}"
                    fi
                else
                    ERRCOUNT=$[ERRCOUNT + 1]
                    echo -e "${CERROR}ERROR: ${NEW} is not a valid repository${CNORMAL}"
                fi
            elif [[ "${CURRENT}" =~ "${FILTERBYSSH}" ]]; then
                STR_ARRAY=(`echo $CURRENT | tr ':'  "\n"`)
                NEW="https://github.com/${STR_ARRAY[1]}"
                if [[ "${NEW}" =~ "https://github.com/".*".git" ]] ; then
                    `git remote set-url origin "${NEW}"`
                    NEWCHANGED=`git config --get remote.origin.url`;
                    if [[ "${NEW}" =~ ${NEWCHANGED} ]] ; then
                        echo -e "${CSUCCESS}Origin changed to ${NEWCHANGED}${CNORMAL}"
                    else
                        ERRCOUNT=$[ERRCOUNT + 1]
                        echo -e "${CERROR}ERROR: could not change origin${CNORMAL}"
                    fi
                else
                    ERRCOUNT=$[ERRCOUNT + 1]
                    echo -e "${CERROR}ERROR: ${NEW} is not a valid repository${CNORMAL}"
                fi
            else
                echo -e "Origin OK"
            fi
            cd - > /dev/null
        done
    else
        echo -e "\n${CERROR}${ERRMASCOT}\nERROR: Directory $dir does not exist ${CNORMAL}"
    fi
done

if [[ "${ERRCOUNT}" == "0" ]] ; then
    finalcol=${CSUCCESS}
else
    finalcol=${CERROR}
fi

echo -e "\n${finalcol}Completed with ${ERRCOUNT} errors${CNORMAL}"
