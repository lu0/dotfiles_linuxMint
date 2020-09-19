#!/bin/bash

# I use a separate partition / external drive for my files

# I don't like uppercase first letter on directories
# They can be renamed globally with the user-dirs.dirs file
ln -srf ~/.dotfiles_linuxMint/config/xdg-user-dirs ~/.config/user-dirs.dirs

# Then fix their links on nemo's sidebar with the bookmarks file
ln -srf ~/.dotfiles_linuxMint/config/bookmarks ~/.config/gtk-3.0/

# Default folders
rm -rf ~/Desktop && ln -sf /mnt/Data/HomeDir/desktop ~/desktop
rm -rf ~/Documents && ln -sf /mnt/Data/HomeDir/documents ~/documents
rm -rf ~/Music && ln -sf /mnt/Data/HomeDir/music ~/music
rm -rf ~/Pictures && ln -sf /mnt/Data/HomeDir/pictures ~/pictures
rm -rf ~/Videos && ln -sf /mnt/Data/HomeDir/videos ~/videos
rm -rf ~/Downloads && ln -sf /mnt/Data/HomeDir/loads ~/loads
rm -rf ~/Templates && ln -sf /mnt/Data/HomeDir/templates ~/templates
rm -rf ~/Public && ln -sf /mnt/Data/HomeDir/public ~/public

# My folders
rm -rf /mnt/Data/HomeDir/code/ && ln -sf ~/code /mnt/Data/HomeDir/code
rm -rf ~/artwork && ln -sf /mnt/Data/HomeDir/artwork ~/artwork
rm -rf ~/mobile && ln -sf /mnt/Data/HomeDir/mobile ~/mobile
rm -rf ~/momi && ln -sf /mnt/Data/HomeDir/momi ~/momi
rm -rf ~/.dotfiles_linuxMint && ln -sf ~/code/dotfiles_linuxMint ~/.dotfiles_linuxMint

# Icons for my folders
gio set code/ -t string metadata::custom-icon-name folder-code
gio set artwork/ -t string metadata::custom-icon-name folder-applications
gio set mobile/ -t string metadata::custom-icon-name folder-android
gio set momi/ -t string metadata::custom-icon-name folder-image-people
gio set public/ -t string metadata::custom-icon-name folder-network
gio set .dotfiles_linuxMint/ -t string metadata::custom-icon-name folder-activities
