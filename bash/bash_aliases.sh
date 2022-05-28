#!/usr/bin/env bash
# shellcheck disable=1090,1091

# Source files from my aliases directory
aliases_dir=~/.bash_aliases.d
if [[ -d $aliases_dir && -r $aliases_dir && -x $aliases_dir ]]; then
    for i in "$aliases_dir"/*; do
        [[ -f $i && -r $i ]] && . "$i"
    done
fi

# Complete all aliases using cykerway's script
# (https://github.com/cykerway/complete-alias)
complete -F _complete_alias "${!BASH_ALIASES[@]}"

# Inherit completion rules of other commands, available in lu0's fork
# (https://github.com/lu0/complete-alias)
_complete_alias_overrides() {
    # Complete alias 'git' defined in 'git_aliases.sh' as
    #   alias git="source git-worktree-wrapper"
    # with completion rules of original command 'git'
    echo git git
}
