#!/bin/bash

# 
# Packages I use
# Same order as mint menu
#
# github.com/lu0/dotfiles_linuxMint
# 


# ACCESORIES /////////////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install font-manager

# GRAPHICS ///////////////////////////////////////////////////////////////////////////////////////////////////

# Krita (scketch w/stylus)
add-apt-repository ppa:kritalime/ppa -y
sudo apt-update && sudo apt install krita -y

sudo apt-get install inkscape

sudo apt-get install gimp -y

# GAMES //////////////////////////////////////////////////////////////////////////////////////////////////////

# Steam (ipv4) 
wget -4 https://repo.steampowered.com/steam/archive/precise/steam_latest.deb -O ~/Downloads/steam.deb
sudo gdebi --non-interactive ~/Downloads/steam.deb


# INTERNET ////////////////////////////////////////////////////////////////////////////////////////////////

# Vivaldi Browser 
# (help.vivaldi.com/article/obtaining-official-builds/)
wget https://repo.vivaldi.com/stable/linux_signing_key.pub
gpg --import linux_signing_key.pub
sudo apt-get install vivaldi-stable -y
cd vivaldi-setup                                        # Setup from submodule: github.com/lu0/vivaldi-setup
mkdir -p ~/.config/vivaldi && cp -r Default "$_"

# OFFICE /////////////////////////////////////////////////////////////////////////////////////////////////

# Freeoffice Suite
sudo apt purge --autoremove libreoffice-common -y
wget https://www.softmaker.net/down/softmaker-freeoffice-2018_976-01_amd64.deb -O ~/Downloads/freeoffice.deb
sudo gdebi ~/Downloads/freeoffice.deb

# DEV TOOLS //////////////////////////////////////////////////////////////////////////////////////////////

# VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update && sudo apt-get install code -y

# Setup vscode:
cd vscode-settings
chmod +x setup-symlinks.sh
./setup-symlinks.sh                 # Symlinks to config files
chmod +x install_extensions.sh
./install_extensions.sh             # Extension list

cd 

# SOUND & VIDEO /////////////////////////////////////////////////////////////////////////////////////////
VSCo
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

# System configuration tool
sudo apt-get install dconf-editor -y

# Virtual box (ubuntu > 19.04)
# wget https://download.virtualbox.org/virtualbox/6.1.10/virtualbox-6.1_6.1.10-138449~Ubuntu~eoan_amd64.deb -O ~/Downloads/virtual-box_u19.deb
# sudo gdebi --non-interactive ~/Downloads/virtual-box_u19.deb

# Virtual box (ubuntu 18.04)
wget https://download.virtualbox.org/virtualbox/6.1.10/virtualbox-6.1_6.1.10-138449~Ubuntu~bionic_amd64.deb -O ~/Downloads/virtual-box_u18.deb
sudo gdebi --non-interactive ~/Downloads/virtual-box_u18.deb

# System profiler and benchmark
sudo apt-get install hardinfo -y

# bluetooth manager
sudo apt-get install blueman -y