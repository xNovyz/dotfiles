#!/bin/bash

# Exit on any error
set -e

# Color functions using tput
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)

echo "${yellow}${bold}///////////////////////////////////////////////////////"
echo "       Login screen setup script ver 1.0 by Novyz"
echo "///////////////////////////////////////////////////////${normal}"
echo

echo "${green}[1/7] Installing greetd and tuigreet...${normal}"
sudo pacman -S --noconfirm greetd
if ! command -v tuigreet &>/dev/null; then
  yay -S --noconfirm greetd-tuigreet-bin || true
fi

echo "${green}[2/7] Installing console font package...${normal}"
sudo pacman -S --noconfirm terminus-font

echo "${green}[3/7] Creating tuigreet wrapper script...${normal}"
sudo tee /etc/greetd/tuigreet-wrapper.sh >/dev/null <<'EOF'
#!/bin/bash

# Set console font (requires root)
setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psfu.gz

# Launch tuigreet
exec /usr/bin/tuigreet --user-menu --remember --remember-user-session --time \
  --cmd /etc/greetd/launch-session.sh \
  --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red
EOF

sudo tee /etc/greetd/launch-session.sh >/dev/null <<'EOF'
#!/bin/bash

# Launch Hyprland if available, fallback to TTY session
if command -v Hyprland &>/dev/null; then
  exec Hyprland
else
  echo "Hyprland not found. Launching TTY shell fallback..."
  exec /bin/bash
fi
EOF
sudo chmod +x /etc/greetd/launch-session.sh

echo "${green}[4/7] Setting permissions for wrapper...${normal}"
sudo chown root:greeter /etc/greetd/tuigreet-wrapper.sh
sudo chmod 750 /etc/greetd/tuigreet-wrapper.sh

echo "${green}[5/7] Writing greetd config.toml...${normal}"
sudo tee /etc/greetd/config.toml >/dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "/etc/greetd/tuigreet-wrapper.sh"
user = "greeter"
EOF

echo "${green}[6/7] Checking for existing display managers...${normal}"
dm_list=("sddm" "gdm" "lightdm" "ly" "lxdm")
enabled_dm=""

for dm in "${dm_list[@]}"; do
  if systemctl is-enabled "$dm" &>/dev/null; then
    enabled_dm="$dm"
    break
  fi
done

if [[ -n "$enabled_dm" ]]; then
  echo "${blue} Detected that '${enabled_dm}' is currently enabled as a display manager.${normal}"
  echo "${red}Only one display manager can run at a time.${normal}"

  read -rp "${magenta}Do you want to disable '${enabled_dm}' and enable 'greetd' instead? [y/N] ${normal}" choice
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo systemctl disable "$enabled_dm"
    sudo systemctl enable greetd
    echo "${green}'${enabled_dm}' disabled and 'greetd' enabled.${normal}"
  else
    echo "${red} Please make sure to disable '${enabled_dm}' before enabling 'greetd'.${normal}"
  fi
else
  echo "${green}[7/7] No other DMs found. Enabling greetd...${normal}"
  sudo systemctl enable greetd
fi

echo
echo "${cyan}Setup complete. Reboot to use greetd with tuigreet and the custom font.${normal}"
