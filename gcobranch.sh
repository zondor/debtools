#!/bin/bash
# Checks out and pulls specified {branch} in all git repos found in each of specified {dir}
# Syntax: $ gcobranch.sh {branch} {dir1} [{dir2} {dir3}...]

CNORMAL='\e[00m'
CHIGHLIGHT="\e[01;36m"
CERROR='\033[31m'
CSUCCESS='\e[32m'
ERRMASCOT='            __\n           / _)\n    .-^^^-/ /\n __/       /\n<__.|_|-|_|';
ERRCOUNT=0

if [ $# -lt 2 ]
  then
    echo -e "\n${CERROR}${ERRMASCOT}\nERROR: Incorrect arguments specified${CNORMAL}"
    echo "Usage: gcobranch [branch] [dir] [dir]..."   
    exit 0
fi

branch=$1
directories="${@:2}";

for dir in $directories
do
    if [ -d "$dir" ]; then    
        cd $dir>/dev/null;
        echo -e "Scanning ${PWD}";
        cd ->/dev/null

        for d in `find $dir -name .git -type d`; do
          cd $d/.. > /dev/null
          echo -e "\n${CHIGHLIGHT}Repo: `pwd`$CNORMAL"
          CURRENT=`git rev-parse --abbrev-ref HEAD`;
          echo -e "Current branch$CNORMAL: ${CURRENT}"
          TXTCHECKOUT="No need to checkout"

          if [[ "${CURRENT}" != "${branch}" ]]; then
            TXTCHECKOUT=$((git checkout $branch) 2>&1);
            if [[ "${TXTCHECKOUT}" =~ 'did not match any file' ]]; then
                echo "Creating new branch $branch";
                TXTCHECKOUT=$((git checkout -b $branch) 2>&1);
            fi
          else
            lcommit=`git log -n 1 --pretty=format:"%H, %cn : %s"`;
            echo -e "Already on ${branch}"
            echo -e "Last commit: ${lcommit}"
          fi

          TXTPULL=$((git pull origin $branch) 2>&1);
          NEWCHANGED=`git rev-parse --abbrev-ref HEAD`;
          if [[ "${branch}" == ${NEWCHANGED} ]] ; then
              echo -e "${CSUCCESS}${NEWCHANGED} checked out & pulled"
          else
              ERRCOUNT=$[ERRCOUNT + 1]
              echo -e "\n${CERROR}${ERRMASCOT}\nERROR: could not check out ${branch}"
              echo -e "${CHIGHLIGHT}Checkout output:${CNORMAL}\n ${TXTCHECKOUT} \n${CHIGHLIGHT}Pull output:${CNORMAL} ${TXTPULL}"
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

echo -e "\n${finalcol}Done with ${ERRCOUNT} errors${CNORMAL}"


