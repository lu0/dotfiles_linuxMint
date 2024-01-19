#!/usr/bin/env bash

alias tree="\tree --dirsfirst -a" # Show hidden and list dirs. before files

alias cp="cp -riv"      # verbose
alias mkdir="mkdir -pv" # parent, verbose
alias rm="rm -i"

alias dusingle="sudo du -sh"            # size of directory
alias duall="sudo du -hd 1 . | sort -h" # size of subdirectories (1st level)
alias dfall="sudo df -h 1 .  | sort -h" # available space

alias chmodcode="stat --format '%a'"

# find symlinks in current pointing to given directory
function findln() {
    find . -type l -exec readlink -nf {} ';' -exec echo " -> {}" ';' | grep "$*"
}

# find broken symlinks in current directory
alias brokenln="find . -type l -exec test ! -e {} \; -print"
