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

# Inherit completion rules from other commands by overriding
# complete-alias' internal function `__compal__get_alias_body`
# (https://github.com/cykerway/complete-alias/pull/34)
__compal__get_alias_body() {
    local cmd="$1"
    local body; body="$(alias "$cmd")"

    # Overrides
    case "$cmd" in
        "git")
            # Complete alias 'git' defined in 'git_aliases.sh' as
            #   alias git="source git-worktree-wrapper"
            # with completion rules of original command 'git'
            body="git"
    esac

    echo "${body#*=}" | command xargs
}
