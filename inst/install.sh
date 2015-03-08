set -e

if [ ! -n "$ZDEBTOOLS" ]; then
  ZDEBTOOLS=~/.zo-debtools
fi

if [ -d "$ZDEBTOOLS" ]; then
  echo "\033[0;33mYou already have Zorge debian tools.\033[0m You'll need to remove $ZDEBTOOLS if you want to reinstall it"
  exit
fi

echo "\033[0;34mCloning Deb-tools...\033[0m"
hash git >/dev/null 2>&1 && env git clone --depth=1 https://github.com/zondor/debtools.git $ZDEBTOOLS || {
  echo "git not installed"
  exit
}

bash ${ZDEBTOOLS}/inst/setup.sh

echo "\033[0;32m"'    _______  _______  _______  _______  _______    '"\033[0m"
echo "\033[0;32m"'   / ___   )(  ___  )(  ____ )(  ____ \(  ____ \   '"\033[0m"
echo "\033[0;32m"'   \/   )  || (   ) || (    )|| (    \/| (    \/   '"\033[0m"
echo "\033[0;32m"'       /   )| |   | || (____)|| |      | (__       '"\033[0m"
echo "\033[0;32m"'      /   / | |   | ||     __)| | ____ |  __)      '"\033[0m"
echo "\033[0;32m"'     /   /  | |   | || (\ (   | | \_  )| (         '"\033[0m"
echo "\033[0;32m"'    /   (_/\| (___) || ) \ \__| (___) || (____/\   '"\033[0m"
echo "\033[0;32m"'   (_______/(_______)|/   \__/(_______)(_______/   '"\033[0m"
echo "\033[0;32m"'                                                   '"\033[0m"
