#!/usr/bin/env bash

#
# This file loads all my dconf configuration files
#

set -euo pipefail

script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_dir=$(dirname "${script_abs_file_path}")
cd "$script_dir"

# dconf load / < theme.conf
# dconf load /org/gnome/terminal/ < gnome-terminal.conf
# dconf load / < miscellaneous.conf
# dconf load /org/nemo/ < nemo-fileman.conf
# dconf load /org/cinnamon/ < panel.conf
# dconf load /org/cinnamon/ < system-sounds.conf

./keybindings/dconf_load_keybindings.sh
