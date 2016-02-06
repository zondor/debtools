export ZSH=~/.oh-my-zsh

ZSH_THEME="fino"
# steeef avit clean frisk
#
# https://github.com/robbyrussell/oh-my-zsh/wiki/themes

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

plugins=(git wd)

# User configuration
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
  
# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8

export EDITOR='vim'

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Directory 
export LS_OPTIONS='--color=auto'

alias zshconfig="edit ~/.zshrc"
alias l="ls -la"
alias ll=""ls -laLH""

# Developer
alias msql="mysql -u root -proot"


# Composer
alias cmp="composer"

# Laravel
alias art="php ./artisan"
alias update-debtools="cd ~/.zo-debtools && gl origin master && bash ./inst/setup.sh"

alias phpcs="/usr/bin/phpcs -np --standard=PSR2 --extensions=php "
alias phpcs-fx="php ~/bin/phpcbf.phar -n --standard=PSR2 --extensions=php "

alias terror="tail -f ~/sites/log/fusion_global_error.log"

alias hcomposer="hhvm -v Eval.Jit=false -v ResourceLimit.SocketDefaultTimeout=300 -v Http.SlowQueryThreshold=300000 /usr/local/bin/composer update --prefer-source -vvvv"
alias phpunit-coverage="phpunit --color --coverage-text"
alias phpunit-report="sh ~/bin/phpunit-report.sh"
alias cmp-test="COMPOSER=test-composer.json composer update --prefer-source -vvv"
alias cmp-dev="COMPOSER=development-composer.json composer update --prefer-source -vvv"
alias cmp-master="composer update --prefer-source -vvv"

alias glo="git pull origin"
alias gpo="git push origin"
alias glm="git pull origin master"
alias glt="git pull origin test"
alias gld="git pull origin development"
alias gfa="git fetch --all"
alias gitall='function _blah(){ wd fusion;echo "### Checking out $1 to all"; gitco $1 ./docs/wp-content/plugins/; gitco $1 ./vendor/fusion; gitco $1 ./docs/wp-content/themes/ };_blah'
alias gitpull-theirs="git pull -s recursive -X theirs"

alias cls="clear"
alias art="./artisan"
alias fix-github="rm -rf /tmp/git@github.com:22 && ssh git@github.com"

