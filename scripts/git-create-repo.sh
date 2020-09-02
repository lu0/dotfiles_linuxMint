#!/bin/bash

# Create new Github repo and push from current directory
#
# github.com/lu0/.dotfiles_linuxMint/scripts
#
# Credits to bennedich:
# https://stackoverflow.com/a/10325316

if [ "$( git log --oneline -5 2>/dev/null | wc -l )" -eq 0 ]; then 
  # No commits yet
  # Prepare initial commit
  git init $PWD
  touch $PWD/README.md
  git -C $PWD add .
  git -C $PWD commit -a -m "Initial commit (from script)"
fi; 

REPONAME=${PWD##*/}
GITUSER=$(git config user.name)

echo -e "\nNAME OF REPOSITORY: ${REPONAME}"
read -p "ENTER DESCRIPTION: " DESCRIPTION
read -p "IS PRIVATE? [y/n]: " PRIVATE_ANS

if [ "$PRIVATE_ANS" == "y" ]; then
  PRIVACY=PRIVATE
  IS_PRIVATE=true
else
  PRIVACY=PUBLIC
  IS_PRIVATE=false
fi

echo -e "\nAfter this operation, { $REPONAME } will be pushed to Github as a { $PRIVACY } repository"
read -p "Do you want to continue? [y/n] " CONTINUE

if [ "$CONTINUE" != "y" ]; then
  echo "Operation cancelled"
  exit
fi

curl -u $GITUSER https://api.github.com/user/repos -d "{\"name\": \"$REPONAME\", \"description\": \"${DESCRIPTION}\", \"private\": $IS_PRIVATE}"

git remote add origin https://github.com/$GITUSER/$REPONAME.git
git push origin master

echo -e "\nDONE: { $REPONAME } has been push to Github"
