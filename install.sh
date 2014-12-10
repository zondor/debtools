#!/bin/bash
# Install other scripts from this directory to system
# Usage: git clone https://github.com/Gundars/bashscripts.git ~/.bashscripts && sudo bash install.sh

git pull origin master
SCRIPTS=( gcobranch gitmerge guorigin )
for SCRIPT in ${SCRIPTS[@]}
do
	if [ ! -f /usr/local/bin/${SCRIPT} ]; then
		echo "Installing $SCRIPT"
	    sudo ln -s ~/.bashscripts/${SCRIPT}.sh /usr/local/bin/${SCRIPT}
	else
		SYMLINK=$(readlink -f /usr/local/bin/${SCRIPT})
		if [[ $SYMLINK != ~/.bashscripts/${SCRIPT}.sh ]]; then
			echo "Relinking existing $SCRIPT"
			sudo rm /usr/local/bin/${SCRIPT}
			sudo ln -s ~/.bashscripts/${SCRIPT}.sh /usr/local/bin/${SCRIPT}
		else
			echo "$SCRIPT already installed"
		fi
	fi
done
