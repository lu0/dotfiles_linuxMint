#!/bin/bash

#
# Install my fave cinnamon spices:
# Applets and extensions
#

RUN_DIR="$(cd "$(dirname "$0")" && pwd)"

# Cinnamon and Mint icons for 34px panels 
sudo ln -srf $RUN_DIR/appearance/icons/linuxmint-logo-badge-symbolic.svg /usr/share/icons/hicolor/scalable/apps/
sudo ln -srf $RUN_DIR/appearance/icons/cinnamon-symbolic.svg /usr/share/icons/hicolor/scalable/apps/

ln -srf $RUN_DIR/spices-applets/ ~/.local/share/cinnamon/applets
ln -srf $RUN_DIR/spices-extensions ~/.local/share/cinnamon/extensions
ln -srf $RUN_DIR/spices-configs ~/.cinnamon/configs

sudo ln -srf appSwitcher.js /usr/share/cinnamon/js/ui/appSwitcher/