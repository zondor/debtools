#!/bin/bash 
# Merges current branch with {branch}, pushes changes to origin
# If no {branch} is specified, "development" is used
# Syntax: $ gitmerge [options] [branch]

CNORMAL='\e[00m'
CHIGHLIGHT="\e[01;36m"
CERROR='\033[31m'
CSUCCESS='\e[32m'
ERRMASCOT='            __\n           / _)\n    .-^^^-/ /\n __/       /\n<__.|_|-|_|'
ERRCOUNT=0
ALLOWEDARGS=1
OPTP=false
PRBRANCHES=(test master)

while getopts ":p" opt; do
  case $opt in
    p)
      OPTP=true
      ALLOWEDARGS=$[ALLOWEDARGS + 1]
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

if [ $# -gt $ALLOWEDARGS ]; then
    echo -e "${CERROR}${ERRMASCOT}ERROR: Received $# arguments, only ${ALLOWEDARGS} allowed! Syntax: gitmerge [options] [branch] ${CNORMAL}"
    exit 1
fi

currentBranch="$(b=$(git symbolic-ref -q HEAD); { [ -n "$b" ] && echo ${b##refs/heads/}; } || echo HEAD)"
mergeBranch="development"
if [[ $1 && "$OPTP" = false ]]; then 
    mergeBranch=$1
elif [[ $1 && "$OPTP" = true && $2 ]]; then 
    mergeBranch=$2
fi
echo -e "Merging ${CHIGHLIGHT}${currentBranch}${CNORMAL} with ${CHIGHLIGHT}${mergeBranch}${CNORMAL}"

git checkout $mergeBranch
git pull origin $mergeBranch
git merge --no-ff $currentBranch
git push origin $mergeBranch
git checkout $currentBranch

if [ "$OPTP" = true ] ; then
    currentOrigin=`git config --get remote.origin.url`;
    if [[ "${currentOrigin}" =~ "x-oauth-basic" ]]; then
      cleanedOrigin=(`echo $currentOrigin | tr '@' "\n"`)
      newOrigin="https://${cleanedOrigin[1]}"
      if [[ "${newOrigin}" =~ "https://github.com/".*".git" ]] ; then
         currentOrigin=$newOrigin
      fi
    elif [[ "${currentOrigin}" =~ "git@github.com:" ]]; then
      cleanedOrigin=(`echo $currentOrigin | tr ':' "\n"`)
      newOrigin="https://github.com/${cleanedOrigin[1]}"
      if [[ "${newOrigin}" =~ "https://github.com/".*".git" ]] ; then
         currentOrigin=$newOrigin
      fi
    fi
    for prBranch in ${PRBRANCHES[@]}; do
        echo -e "${CHIGHLIGHT}PR ${prBranch}:${CNORMAL} ${currentOrigin/%.git//compare/${prBranch}...${currentBranch}}"
    done
fi

exit 0
