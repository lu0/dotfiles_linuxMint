#!/bin/bash

# 
# Packages I use
# Same order as mint menu
#
# github.com/lu0/dotfiles_linuxMint
# 


# ACCESORIES /////////////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install font-manager -y

# GRAPHICS ///////////////////////////////////////////////////////////////////////////////////////////////////

# Krita (scketch w/stylus)
add-apt-repository ppa:kritalime/ppa -y
sudo apt update && sudo apt-get install krita -y

sudo apt-get install inkscape -y

sudo apt-get install gimp -y

# GAMES //////////////////////////////////////////////////////////////////////////////////////////////////////

# Steam (ipv4) 
wget -4 https://repo.steampowered.com/steam/archive/precise/steam_latest.deb -O ~/Downloads/steam.deb
sudo gdebi --non-interactive ~/Downloads/steam.deb


# INTERNET ////////////////////////////////////////////////////////////////////////////////////////////////

# Vivaldi Browser 
# (help.vivaldi.com/article/obtaining-official-builds/)
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
sudo apt update && sudo apt install vivaldi-stable -y
cd ../vivaldi-setup                                        # Setup from submodule: github.com/lu0/vivaldi-setup
mkdir -p ~/.config/vivaldi && cp -r Default "$_"
cd ../scripts

# OFFICE /////////////////////////////////////////////////////////////////////////////////////////////////

# Freeoffice Suite
sudo apt purge --autoremove libreoffice-common -y
wget https://www.softmaker.net/down/softmaker-freeoffice-2018_976-01_amd64.deb -O ~/Downloads/freeoffice.deb
sudo gdebi --non-interactive ~/Downloads/freeoffice.deb

# DEV TOOLS //////////////////////////////////////////////////////////////////////////////////////////////

# VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update && sudo apt-get install code -y

# Setup vscode:
cd ../vscode-settings
./setup-symlinks.sh                 # Symlinks to config files
./install_extensions.sh             # Extension list
cd ../scripts

# SOUND & VIDEO /////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install audacity -y
sudo apt-get install soundconverter -y

# Spotify 
# (https://www.spotify.com/mx/download/linux/)
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

# Camera
sudo apt-get install cheese -y

# Video editor
sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y
sudo apt-get update && sudo apt-get install kdenlive -y

# ADMINISTRATION ////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install gparted -y
sudo apt-get install dconf-editor -y # System configuration tool

# Virtual box (ubuntu > 19.04)
# wget https://download.virtualbox.org/virtualbox/6.1.10/virtualbox-6.1_6.1.10-138449~Ubuntu~eoan_amd64.deb -O ~/Downloads/virtual-box_u19.deb
# sudo gdebi --non-interactive ~/Downloads/virtual-box_u19.deb

# Virtual box (ubuntu 18.04)
wget https://download.virtualbox.org/virtualbox/6.1.10/virtualbox-6.1_6.1.10-138449~Ubuntu~bionic_amd64.deb -O ~/Downloads/virtual-box_u18.deb
sudo gdebi --non-interactive ~/Downloads/virtual-box_u18.deb

# System profiler and benchmark
sudo apt-get install hardinfo -y

# bluetooth manager
mkdir -p ~/Downloads/Bluetooth
sudo apt-get install blueman -y

# Other //////////////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install maximus -y         # Maximize and hide window decorations
sudo apt-get install wmctrl -y          # window managment
sudo apt-get install sox -y             # play sounds from terminal
sudo apt-get install rofi -y

# TLP battery managment
# (https://linrunner.de/tlp/settings/battery.html)
# check thresholds with 'sudo tlp-stat -b'
# use 'sudo tlp fullcharge' when need to temporarily charge battery up to 100%
sudo add-apt-repository ppa:linrunner/tlp
sudo apt update
sudo apt install tlp tlp-rdw -y
sudo apt-get install acpi-call-dkms -y
sudo tlp start
rm -rf /etc/tlp.conf
cp config/tlp-battery.conf /etc/tlp.conf
sudo tlp start
