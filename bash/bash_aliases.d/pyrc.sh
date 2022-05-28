#!/usr/bin/env bash
# shellcheck disable=SC1091

alias py="python3"
alias pydoc="python3 -m pydoc"
alias pyenvdocs="xdg-open 2>/dev/null https://github.com/pyenv/pyenv#usage"

# For pyenv
export PYENV_ROOT=${HOME}/.pyenv
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# For pyenv-virtualenv plugin (https://github.com/pyenv/pyenv-virtualenv)
# NOTE: This must be evaluated after setting any custom prompts
eval "$(pyenv virtualenv-init -)"
