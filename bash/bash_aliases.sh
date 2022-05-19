#!/usr/bin/env bash

# Source files from my aliases directory
aliases_dir=~/.bash_aliases.d
if [[ -d $aliases_dir && -r $aliases_dir && -x $aliases_dir ]]; then
    for i in "$aliases_dir"/*; do
        [[ -f $i && -r $i ]] && . "$i"
    done
fi
