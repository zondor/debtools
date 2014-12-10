Bash Scripts
===========
Collection of bash scripts

###Installation
Execute following line in bash shell as a user:
```
git clone https://github.com/Gundars/bashscripts.git ~/.bashscripts && bash ~/.bashscripts/install.sh
```
To update existing scripts run
```
bash ~/.bashscripts/install.sh
```

###gcobranch
Checks out and pulls specified git branch {branch} in all git repos found in each of specified directories {dir}

Syntax: `$ gcobranch {branch} {dir1} [{dir2} {dir3}...]`

###gitmerge
Merges current branch with branch {branch}, pushes changes to origin. If no {branch} is specified, "development" is used

Syntax: `$ gitmerge [options] [branch]`

Options:
- `-p`  generate links to test/master pull requests

###guorigin
Update git origins from o-auth and SSH to native https in all git repos found in each of specified directories {dir}

Syntax: `$ guorigin {dir1} [{dir2} {dir3}...]`
