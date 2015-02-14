Bash Scripts
===========
[![Build Status](https://travis-ci.org/Gundars/bashscripts.png?branch=master)](https://travis-ci.org/Gundars/bashscripts)

####Installation and update
Execute the following line in bash shell:

Install for the first time: 
`git clone https://github.com/Gundars/bashscripts.git ~/.bashscripts && bash ~/.bashscripts/install.sh`

Update existing scripts: 
`bash ~/.bashscripts/install.sh`

###gcobranch
Git checkout branch - checks out and pulls specified git {branch} in all git repos found in each of specified directories {dir}

Syntax: `$ gcobranch {branch} {dir1} [{dir2} {dir3}...]`

###gitmerge
Git merge - merges current branch with {branch}, pushes changes to origin

If no {branch} is specified, current branch is merged with *development* branch

Syntax: `$ gitmerge [options] [branch]`

Options:
- `-p`  generate links to test/master pull requests

###guorigin
Git update origin - updates git remote origins format from o-auth and SSH to native https in all git repos found in each of specified directories {dir}

Syntax: `$ guorigin {dir1} [{dir2} {dir3}...]`

###gitpress
Git compress - compresses all commits in current local branch into single commit

Syntax: `$ gitpress [options]`

Options:
- `-f`  force compress on generic branch names (development, test, master)
- `-p`  force push to remote using "+branchname"

**Warning:** This will disable history, allign with master to fix pull requests

###buildenv
Changes {build number} for a {branch} on site environmnet {env}

**Warning:** Before using script, change line 21 - swap dummy string with https link to enriched github repository

Syntax: `$ buildenv {env} {branch} {build number}`
