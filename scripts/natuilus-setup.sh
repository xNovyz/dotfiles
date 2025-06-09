#!/bin/bash

# Color setup
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
cyan=$(tput setaf 6)

echo "${yellow}${bold}//////////////////////////////////////////////////"
echo "      Nautilus setup script ver 1.0 by Novyz"
echo "//////////////////////////////////////////////////${normal}"
echo

echo "${green}[1/3] Installing nautilus...${normal}"
sudo pacman -S nautilus

echo "${green}[2/3] Applying theme...${normal}"
gsettings set org.gnome.desktop.interface gtk-theme 'Rose-Pine'
gsettings set org.gnome.desktop.interface icon-theme 'Gradient-Light-Icons'

echo "${green}[3/3] Applying settings...${normal}"
gsettings set org.gnome.nautilus.preferences show-hidden-files true

echo
echo "${cyan}Setup complete. Nautilus is now themed and configured.${normal}"
