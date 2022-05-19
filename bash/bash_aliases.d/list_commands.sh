#!/usr/bin/env bash

# -A almost all, -o list without group ingo, -F classify,
# -h human readable
# https://unix.stackexchange.com/questions/205158/how-to-show-only-the-last-k-columns-in-ls-l

list_message() {
    GREEN='\033[0;32m' # ANSI code
    NC='\033[0m'       # ANSI No Color
    MESSAGE=$1
    printf "${GREEN}${MESSAGE}${NC}\n"
}

l() { # arg1: path, arg2: s (sort by size)
    list_message "LISTING NO HIDDEN, NO SYMLINKS"
    ls -lgoLFh${2^^} --group-directories-first --color=always "${1:-.}" | sed 's/^[^ ][^ ]*  *[^ ][^ ]* //'
}

ll() {
    list_message "LISTING HIDDEN, NO SYMLINKS"
    ls -AlgoLFh${2^^} --group-directories-first --color=always "${1:-.}" | sed 's/^[^ ][^ ]*  *[^ ][^ ]* //'
}

L() {
    list_message "LISTING NO HIDDEN, SYMLINKS"
    ls -lgoFh${2^^} --group-directories-first --color=always "${1:-.}" | sed 's/^[^ ][^ ]*  *[^ ][^ ]* //'
}

LL() {
    list_message "LISTING HIDDEN, SYMLINKS"
    ls -AlgoFh${2^^} --group-directories-first --color=always "${1:-.}" | sed 's/^[^ ][^ ]*  *[^ ][^ ]* //'
}
