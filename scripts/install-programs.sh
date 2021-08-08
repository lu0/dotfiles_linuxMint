#!/bin/bash

# 
# Packages and programs I use
#
# github.com/lu0/dotfiles_linuxMint
# 

# GRAPHICS ///////////////////////////////////////////////////////////

# Krita (scketch w/stylus)
add-apt-repository ppa:kritalime/ppa -y
sudo apt update && sudo apt-get install krita -y

# playonlinux (then install illustrator)
sudo apt-get install playonlinux -y

sudo apt-get install inkscape -y

sudo apt-get install gimp -y


# GAMES //////////////////////////////////////////////////////////////

# Steam (ipv4) 
wget -4 https://repo.steampowered.com/steam/archive/precise/steam_latest.deb -O ~/loads/steam.deb
sudo gdebi --non-interactive ~/loads/steam.deb

# INTERNET /////////////////////////////////////////////////////////////////////

# Vivaldi Browser 
# (help.vivaldi.com/article/obtaining-official-builds/)
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
sudo apt update && sudo apt install vivaldi-stable -y
cd ../vivaldi-setup                                            # Setup
from submodule: github.com/lu0/vivaldi-setup
mkdir -p ~/.config/vivaldi
cp -r Default ~/.config/vivaldi
cd ..

# Team viewer
wget -4 https://download.teamviewer.com/download/linux/teamviewer_amd64.deb -O ~/loads/team-viewer.deb
sudo gdebi --non-interactive ~/loads/team-viewer.deb

# OFFICE /////////////////////////////////////////////////////////////

# Open source office suite compatible with msoffice
sudo apt purge --autoremove libreoffice-common -y           # bye
# wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb -O ~/loads/onlyOffice.deb
# sudo gdebi --non-interactive ~/loads/onlyOffice.deb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
sudo sh -c "echo 'deb https://download.onlyoffice.com/repo/debian squeeze main' >> /etc/apt/sources.list"
sudo apt-get update
sudo apt-get install onlyoffice-desktopeditors

# DEV TOOLS //////////////////////////////////////////////////////////

# VSCode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y
sudo apt-get update && sudo apt-get install code -y

#   Setup vscode:
cd vscode-settings
./setup-symlinks.sh                 # Symlinks to config files
./install_extensions.sh             # Extension list
cd ..

sudo apt-get install neovim -y
sudo apt-get install mycli -y       # mysql alt cli
sudo apt-get install pspg -y        # best pager in the world

sudo apt install virtualenv         # I use it for Python
# Anaconda
sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6


# SOUND & VIDEO //////////////////////////////////////////////////////

sudo apt-get install audacity -y
sudo apt-get install soundconverter -y
sudo apt-get install pavucontrol -y

# Spotify 
# (https://www.spotify.com/mx/download/linux/)
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

# Camera
sudo apt-get install cheese -y

# Droidcam
# https://randomblog.hu/using-your-android-phone-as-a-webcam-for-ubuntu-20-04-with-droidcam/
sudo apt-get install adb -y         
sudo apt-get install gcc make -y
mkdir tmp/ && cd tmp/
wget https://www.dev47apps.com/files/linux/droidcam_latest.zip
unzip droidcam_latest.zip -d droidcam && cd droidcam
sudo ./install
cd ../../
rm -rf tmp/

# Video editor
sudo add-apt-repository ppa:kdenlive/kdenlive-stable -y
sudo apt-get update && sudo apt-get install kdenlive -y

# ADMINISTRATION ////////////////////////////////////////////////////////////////////////////////////////

sudo apt-get install gparted -y
# sudo apt-get install dconf-editor -y # System configuration tool

# Virtual box (ubuntu > 19.04)
wget https://download.virtualbox.org/virtualbox/6.1.10/virtualbox-6.1_6.1.10-138449~Ubuntu~eoan_amd64.deb -O ~/loads/virtual-box_u19.deb
sudo gdebi --non-interactive ~/loads/virtual-box_u19.deb

# System profiler and benchmark
sudo apt-get install hardinfo -y
sudo apt-get install python3-pip
sudo pip3 install s-tui

# bluetooth manager
mkdir -p ~/loads/Bluetooth
sudo apt-get install blueman -y

