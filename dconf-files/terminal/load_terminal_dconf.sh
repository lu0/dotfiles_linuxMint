#!/usr/bin/env bash

#
# This script loads my custom Terminal (Tilix) configuration files into `dconf`
#

set -euo pipefail

script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_dir=$(dirname "${script_abs_file_path}")
cd "$script_dir"

dconf reset -f /com/gexperts/Tilix/

dconf load /com/gexperts/Tilix/ < tilix-base.conf
dconf load /com/gexperts/Tilix/ < tilix-keybindings.conf
dconf load /com/gexperts/Tilix/ < tilix-profile.conf
