#!/bin/bash
echo "//////////////////////////////////////////////////"
echo "      Nautilus setup script ver 0.2 by Novyz"
echo "//////////////////////////////////////////////////"
echo
echo "[1/3] Installing nautilus..."
sudo pacman -S nautilus

echo "[2/3] Applying theme..."
gsettings set org.gnome.desktop.interface gtk-theme 'Rose-Pine'
gsettings set org.gnome.desktop.interface icon-theme 'Gradient-Light-Icons'

echo "[3/3] Apllying settings..."
gsettings set org.gnome.nautilus.preferences show-hidden-files true
