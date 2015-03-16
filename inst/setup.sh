#!/bin/bash

if [ ! -n "$ZDEBTOOLS" ]; then
  ZDEBTOOLS=~/.zo-debtools
fi

#◉ ┏ ┛ ┗ ┓ ┗ ┛ ┏ ┓ ═ ╬ ═ ►   	▂▃▅▇█▓▒░۩۞۩ ۩۞۩░▒▓█▇▅▃▂   	═╬════════► 
# 30 black		31 red		32 green 		
# 33 yellow		34 blue		35 violet
# 36 magenta

# 40 white on black		41 white on red
# 42 white on green 	43 white on yellow
# 44 white on blue 		45 white on violet

show_all_colors() {
	for i in {16..21} {21..16} ; do echo -en "\e[38;5;${i}m#\e[0m" ; done ; echo
}

show_error() {
   echo -e "\033[41m"╬►"\033[41m" Error : $1 "\033[0m"
}

show_head() {
	echo ""
	echo -e "\033[42m"▂▃▅▇█▓▒░"\033[0m""\033[45m"  $1  "\033[0m""\033[42m"░▒▓█▇▅▃▂"\033[0m"
	echo ""
}

show_succes() {
   echo -e "\033[92m"◉ $1"\033[0m"  
}
show_color() {
   echo -e "\033[$1m" $2 "\033[0m"  
}


show_head "Install extra packets"
sudo apt-get install htop curl wget git -y 

show_head "Install powerline fonts"
if [ -d ~/.powerline-fonts ]; then
	show_succes "Already installed"
else
	git clone https://github.com/powerline/fonts.git ~/.powerline-fonts && bash ~/.powerline-fonts/./install.sh
	
	
fi
show_succes "== done"

show_head "Install zsh"
if [ ! -d ~/.oh-my-zsh ]; then
	sudo apt-get install zsh -y
	curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
	which zsh
	chsh -s /bin/zsh
fi	
show_succes "== done"

show_head "Copy some configs"
cp $ZDEBTOOLS/zsh/themes/agn.zsh-theme ~/.oh-my-zsh/themes/ -vv
cp $ZDEBTOOLS/zsh/conf/.zshrc ~/   -vv


show_head "Install Gundras bash git tools"
#git clone https://github.com/zondor/bashscripts.git ~/.bashscripts && bash ~/.bashscripts/install.sh
git clone https://github.com/Gundars/bashscripts.git ~/.bashscripts && bash ~/.bashscripts/install.sh
show_succes "== done"

show_head "All Finished"
cd ~
