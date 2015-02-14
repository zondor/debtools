#!/bin/bash
# Install other scripts from this directory to system
# Usage: git clone https://github.com/Gundars/bashscripts.git ~/.bashscripts && sudo bash install.sh

STARTDIR=${PWD}
INSTDIR=~/.bashscripts
SYMLINKDIR=/usr/local/bin
cd $INSTDIR
git pull origin master
SCRIPTS=(gcobranch gitmerge guorigin buildenv gitpress)
for SCRIPT in ${SCRIPTS[@]}
do
	if [ ! -f ${SYMLINKDIR}/${SCRIPT} ]; then
		echo "Installing $SCRIPT"
	    sudo ln -s $INSTDIR/${SCRIPT}.sh ${SYMLINKDIR}/${SCRIPT}
	else
		SYMLINK=$(readlink -f ${SYMLINKDIR}/${SCRIPT})
		if [[ $SYMLINK != $INSTDIR/${SCRIPT}.sh ]]; then
			echo "Relinking existing $SCRIPT"
			sudo rm ${SYMLINKDIR}/${SCRIPT}
			sudo ln -s $INSTDIR/${SCRIPT}.sh ${SYMLINKDIR}/${SCRIPT}
		else
			echo "$SCRIPT already installed"
		fi
	fi
done
cd $STARTDIR
