#!/bin/bash

# Color setup
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

echo -e "${yellow}${bold}"
cat <<"EOF"
 ███╗   ██╗ ██████╗ ██╗   ██╗██╗   ██╗███████╗    ██████╗  ██████╗ ████████╗███████╗
 ████╗  ██║██╔═══██╗██║   ██║╚██╗ ██╔╝╚══███╔╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
 ██╔██╗ ██║██║   ██║██║   ██║ ╚████╔╝   ███╔╝     ██║  ██║██║   ██║   ██║   ███████╗
 ██║╚██╗██║██║   ██║╚██╗ ██╔╝  ╚██╔╝   ███╔╝      ██║  ██║██║   ██║   ██║   ╚════██║
 ██║ ╚████║╚██████╔╝ ╚████╔╝    ██║   ███████╗    ██████╔╝╚██████╔╝   ██║   ███████║
 ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝     ╚═╝   ╚══════╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
EOF
echo -e "${reset}"

# Print version info
echo -e "                       ${yellow}Novyz ${cyan}dotfiles install script ver 1.0${reset}"

# Step: Installing Ax-shell
echo -e "\n${green}[1/3] Installing Ax-shell...${reset}"
if ! curl -fsSL https://raw.githubusercontent.com/xNovyz/Ax-Shell/refs/heads/animated-wallpaper/install.sh | bash; then
  echo -e "${red}[ERROR] Failed to install Ax-shell. Aborting.${reset}"
  exit 1
fi

# Step: Running setup scripts
echo -e "\n${green}[2/3] Running setup scripts...${reset}"
for script in "${CHEZMOI_SOURCE_DIR}"/scripts/*.sh; do
  if [[ -x "$script" ]]; then
    echo -e "${blue}[+] Executing: $(basename "$script")${reset}"
    "$script"
  else
    echo -e "${red}[!] Skipping (not executable): $(basename "$script")${reset}"
  fi
done

# Step: Zsh Prompt
echo
read -rp "$(echo -e "${magenta}Do you want to install Zsh & Oh My Zsh? (y/n): ${reset}")" install_zsh
if [[ "$install_zsh" =~ ^[Yy]$ ]]; then
  echo -e "\n${green}[3/3] Installing Zsh & Oh My Zsh...${reset}"
  if ! sudo pacman -S zsh --noconfirm; then
    echo -e "${red}[ERROR] Failed to install Zsh.${reset}"
    exit 1
  fi
  if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    echo -e "${red}[ERROR] Oh My Zsh installation failed.${reset}"
    exit 1
  fi
else
  echo -e "${yellow}[-] Skipping Zsh & Oh My Zsh installation.${reset}"
fi
