#!/bin/bash

#
# Install my fave cinnamon spices:
# Applets and extensions
#

RUN_DIR="$(cd "$(dirname "$0")" && pwd)"

# Cinnamon and Mint icons for 34px panels 
sudo rm /usr/share/icons/hicolor/scalable/apps/linuxmint-logo-badge-symbolic.svg
sudo rm /usr/share/icons/hicolor/scalable/apps/cinnamon-symbolic.svg
sudo ln -sr $RUN_DIR/appearance/icons/linuxmint-logo-badge-symbolic.svg /usr/share/icons/hicolor/scalable/apps/
sudo ln -sr $RUN_DIR/appearance/icons/cinnamon-symbolic.svg /usr/share/icons/hicolor/scalable/apps/

rm -rf ~/.local/share/cinnamon/applets
ln -sr $RUN_DIR/spices-applets/ ~/.local/share/cinnamon/applets

rm -rf ~/.local/share/cinnamon/extensions
ln -sr $RUN_DIR/spices-extensions ~/.local/share/cinnamon/extensions

rm -rf ~/.cinnamon/configs
ln -sr $RUN_DIR/spices-configs ~/.cinnamon/configs