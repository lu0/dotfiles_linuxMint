#!/usr/bin/env bash

#
# This script loads my custom keybinding configuration files into `dconf`
#

set -euo pipefail

script_abs_file_path=$(readlink -f "$(which "${BASH_SOURCE[0]}")")
script_dir=$(dirname "${script_abs_file_path}")
cd "$script_dir"

dconf reset -f /org/cinnamon/desktop/keybindings/

cd base-schema
dconf load /org/cinnamon/desktop/keybindings/ < base.conf
dconf load /org/cinnamon/desktop/keybindings/ < media-keys.conf
dconf load /org/cinnamon/desktop/keybindings/ < window-manager.conf

cd ../custom-list
dconf load /org/cinnamon/desktop/keybindings/custom-keybindings/ < programs.conf
dconf load /org/cinnamon/desktop/keybindings/custom-keybindings/ < window-control.conf
dconf load /org/cinnamon/desktop/keybindings/custom-keybindings/ < utilities.conf

dconf_path=$(head -1 base.conf)
key_value=$(tail -n +2 base.conf)
# shellcheck disable=SC2086
echo -e ${dconf_path}'\n'${key_value} | dconf load /org/cinnamon/desktop/keybindings/
