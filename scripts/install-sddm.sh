#!/bin/bash

# Change display manager ---------------------------------------------------------------
sudo apt-get install sddm -y            			# Plasma-like login-screen
sudo ln -srf cinnamon/sddm-themes/sddm-chili/ /usr/share/sddm/themes/
sudo ln -srf cinnamon/sddm-themes/sddm.conf /etc/
sudo apt-get install qml-module-qtquick-layouts -y
sudo apt-get install qml-module-qtquick-controls -y

# sudo dpkg-reconfigure sddm
# sddm-greeter --test-mode --theme /usr/share/sddm/themes/sddm-chili
