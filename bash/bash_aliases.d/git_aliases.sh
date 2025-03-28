#!/usr/bin/env bash

# Git status of current repo, submodules and tree.
alias gstatus="git fetch && git status"
alias gstatus-sub="git submodule foreach 'git status'"
alias grepos="~/code/dotfiles_linuxMint/scripts/git-check-repos/git-status"

alias gadd="git add"
alias gapatch="git add --patch"
alias gcopatch="git checkout --patch"

# Generate and apply a patch from a SHA, handling whitespace and conflicts
gpatch () {
    git diff "$1"^ "$1" | git apply --reject --whitespace=fix
}

alias gdiff="git diff --color"
alias gdiffmax="git diff --color --no-prefix -U5000"
alias gdiffmin="git diff --color --no-prefix -U0"
alias gtree="git diff-tree -p" # diff of commit, gtree COMMITHASH
alias gstaged="git diff --no-ext-diff --staged"
alias gmerge="git merge --no-commit --no-ff" # gmerge BRANCH_NAME

# Inspect changes of a commit
ginspect() {
    local commit="${1}"
    git diff "${commit}"^ "${commit}"
}

# Display file-level change statistics for a specific commit sha
gstat () {
    local commit="${1}"
    git diff "${commit}"^ "${commit}" --numstat
}

# From https://mirrors.edge.kernel.org/pub/software/scm/git/docs/git-log.html
alias glog="git log --date=local --graph --pretty=format:'%C(yellow)%h %C(red)%cd %C(cyan)%an%C(green)%d %Creset%s'"
alias glogr="git log --graph --pretty=format:'%C(yellow)%h %C(red)%ar %C(cyan)%an%C(green)%d %Creset%s'"
alias gloga="git log --date=local --graph --all --pretty=format:'%C(yellow)%h %C(red)%cd %C(cyan)%an%C(green)%d %Creset%s'"
alias gfollow="git log --date=local --follow --graph --pretty=format:'%C(yellow)%h %C(red)%cd %C(cyan)%an%C(green)%d %Creset%s' -- " # gfollow file
alias guser="git config user.name; git config user.email"                                                               # user on current dir

glog-find() {
    git log --pickaxe-regex -p --color-words -S"$*" # $* regex or string to find
}

alias gcommit="git commit -m"
alias gamend="git commit --amend --no-edit"

grebase() {
    local number_of_commits=${1:-10}
    git rebase -i HEAD~"$number_of_commits"
}

# Tags HEAD
gtag() {
    local tag="${1}"
    local message="${2}"
    git tag -a "${tag}" -m "${message}"
}

# Deletes tag from remote
#   $1 Name of the tag to be deleted
#   $2 Name of the remote, defaults to origin
gtag-delete() {
    local tag="${1}"
    local remote="${2}"
    [ "${remote}" ] || remote=origin
    git push "${remote}" :refs/tags/"${tag}"
}

is_git_repo() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
}

alias glist-tracked="git ls-tree -r --abbrev=8 --name-only \$(is_git_repo && git branch --show-current)"
alias glist-untracked="git ls-files --others --exclude-standard"
alias gignoreall="git ls-files --others --exclude-standard >> .gitignore"   # ignore files currently untracked
alias gclean-untracked="git clean -i"                                       # delete files untracked files
alias gclean-ignored="git clean --exclude=.gitignore -xdi"                  # -x files in .gitignore, -d recursive, -i interactive

# Ignore and revert ignorance of changed files (temporary)
# https://stackoverflow.com/a/23259612
alias gignore="git update-index --assume-unchanged"   # gignore filename
alias gignored="git ls-files -v | grep ^[a-z]"        # list temporarily ignored files
alias gtrack="git update-index --no-assume-unchanged" # gtrack filename
alias guntrack="git rm -r --cached"

# Track (true) or ignore (false) file mode changes
alias gmode="git config core.fileMode"

# List stashes
alias gslist="git stash list"

# Creates stash from HEAD
# $1 Name of stash
gspush() {
    git stash push -m "$*" -p
}

# Applies a stash given its name
gsapply() {
    git stash apply "$(git stash list | grep -P " ${1}\$" | cut -d: -f1)"
}

# Delete a stash given its name
gsdelete() {
    local stash_id stash_line delete
    stash_id=$(git stash list | grep -P " ${1}\$" | cut -d: -f1)
    [ "${stash_id}" ] || { echo "No stash selected" && return 1 ;}
    stash_line=$(git stash list | grep -w "${stash_id}")
    read -rp "Delete '${stash_line}' [y/n]? " delete
    case ${delete:0:1} in
        y|Y) git stash drop "${stash_id}" ;;
        *) echo "Aborted" ;;
    esac
}

# Shows the diff of a stash, given its name
gsshow() {
    git stash show -p "$(git stash list | grep -P " ${1}\$" | cut -d: -f1)"
}

# Completes stash aliases with the list of stash names
_gstash_completion () {
    local cur stashes
    _init_completion -s || return
    stashes=$(git stash list --format='%s' | cut -d: -f2- | tr -d ' ')
    mapfile -t COMPREPLY < <(compgen -W "${stashes}" -- "${cur}")
}
complete -F _gstash_completion gspush gsapply gsdelete gsshow
# Shows diff between files after sorting their lines
gdiff-reorder() {
    trap '' INT # catch ctrl+c to successfully delete temp files
    sort "${1}" > tmp-a
    sort "${2}" > tmp-b
    gdiff --no-index tmp-a tmp-b
    /bin/rm tmp-a tmp-b
}

gpull() {
    status_str=$(git status)
    substring="Your branch is"
    if [[ "${status_str}" == *"${substring}"* ]]; then
        echo "${status_str} contains: ${substring}"
        git pull
    else
        echo "No upstream branch is set."
    fi
}

# Patch with the contents of a commit
gpatch() {
    git diff "$1"^ "$1" | git apply --reject --whitespace=fix
}

# Show files modified by a specific commit
gpatch() {
    git diff "$1"^ "$1" --numstat
}

alias gfetch="git config --local remote.origin.fetch +refs/heads/*:refs/remotes/origin/* && git fetch"

GITLAB_TOKEN=$(cat ~/.gitlab-token 2> /dev/null)
export GITLAB_TOKEN

GITHUB_TOKEN=$(cat ~/.github-token 2> /dev/null)
export GITHUB_TOKEN

# I manage bare repositories using git-worktree-wrapper
# https://github.com/lu0/git-worktree-wrapper
alias git="source git-worktree-wrapper"
