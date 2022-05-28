#!/usr/bin/env bash
# shellcheck disable=2155

# open any file with the default program
alias open="xdg-open 2>/dev/null"

alias calculator="gcalccmd"

# Pipe to convert strings to [lower/upper]case
alias lowercase="tr '[:upper:]' '[:lower:]'"
alias uppercase="tr '[:lower:]' '[:upper:]'"

# Copy to / paste from clipboard
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
