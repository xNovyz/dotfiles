#!/bin/bash
set -e
# Define colors
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored ASCII art (red)
echo -e "${RED}"
cat <<"EOF"
  ███╗   ██╗ ██████╗ ██╗   ██╗██╗   ██╗███████╗    ██████╗  ██████╗ ████████╗███████╗
  ████╗  ██║██╔═══██╗██║   ██║╚██╗ ██╔╝╚══███╔╝    ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝
  ██╔██╗ ██║██║   ██║██║   ██║ ╚████╔╝   ███╔╝     ██║  ██║██║   ██║   ██║   ███████╗
  ██║╚██╗██║██║   ██║╚██╗ ██╔╝  ╚██╔╝   ███╔╝      ██║  ██║██║   ██║   ██║   ╚════██║
  ██║ ╚████║╚██████╔╝ ╚████╔╝    ██║   ███████╗    ██████╔╝╚██████╔╝   ██║   ███████║
  ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝     ╚═╝   ╚══════╝    ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝
EOF
echo -e "${NC}"

# Print version line in yellow and cyan
echo -e "                       ${YELLOW}Novyz${CYAN} dotfiles install script ver 1.0${NC}"

echo -e "\n[] Installing Ax-shel..."
curl -fsSL https://raw.githubusercontent.com/xNovyz/Ax-Shell/refs/heads/animated-wallpaper/install.sh | bash

echo -e "\n[] Running setup scritps..."

for script in "${CHEZMOI_SOURCE_DIR}"/scripts/*.sh; do
  if [[ -x "$script" ]]; then
    echo "[+] Executing: $(basename "$script")"
    "$script"
  else
    echo "[!] Skipping (not executable): $(basename "$script")"
  fi
done

echo
# Prompt user about Zsh installation
read -rp "Do you want to install Zsh & Oh My Zsh? (y/n): " install_zsh
if [[ "$install_zsh" =~ ^[Yy]$ ]]; then
  echo -e "\n[] Installing Zsh & Oh My Zsh..."
  sudo pacman -S zsh --noconfirm || {
    echo "Failed to install zsh"
    exit 1
  }
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
    echo "Oh-My-Zsh install failed"
    exit 1
  }
else
  echo "Skipping Zsh & Oh My Zsh installation."
fi
