#!/bin/bash

set -e
echo "///////////////////////////////////////////////////////"
echo "       Login screen setup script ver 0.1 by Novyz"
echo "///////////////////////////////////////////////////////"
echo
echo "[1/7] Installing greetd and tuigreet..."
sudo pacman -S --noconfirm greetd
if ! command -v tuigreet &>/dev/null; then
  yay -S --noconfirm greetd-tuigreet-git || true
fi

echo "[2/7] Installing console font package..."
sudo pacman -S --noconfirm terminus-font

echo "[3/7] Creating tuigreet wrapper script..."
sudo tee /etc/greetd/tuigreet-wrapper.sh >/dev/null <<'EOF'
#!/bin/bash

# Set console font (requires root)
setfont /usr/share/kbd/consolefonts/Lat2-Terminus16.psf.gz

# Launch tuigreet
exec /usr/bin/tuigreet --user-menu --remember --remember-user-session --time \
  --cmd /etc/greetd/launch-session.sh \
  --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red
EOF

echo "[4/7] Setting permissions for wrapper..."
sudo chown root:greeter /etc/greetd/tuigreet-wrapper.sh
sudo chmod 750 /etc/greetd/tuigreet-wrapper.sh

echo "[5/7] Writing greetd config.toml..."
sudo tee /etc/greetd/config.toml >/dev/null <<EOF
[terminal]
vt = 1

[default_session]
command = "/etc/greetd/tuigreet-wrapper.sh"
user = "greeter"
EOF

echo "[6/7] Checking for existing display managers..."
dm_list=("sddm" "gdm" "lightdm" "ly" "lxdm")
enabled_dm=""

for dm in "${dm_list[@]}"; do
  if systemctl is-enabled "$dm" &>/dev/null; then
    enabled_dm="$dm"
    break
  fi
done

if [[ -n "$enabled_dm" ]]; then
  echo " Detected that '$enabled_dm' is currently enabled as a display manager."
  echo "Only one display manager can run at a time."

  read -rp "Do you want to disable '$enabled_dm' and enable 'greetd' instead? [y/N] " choice
  if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo systemctl disable "$enabled_dm"
    sudo systemctl enable greetd
    echo "'$enabled_dm' disabled and 'greetd' enabled."
  else
    echo " Please make sure to disable '$enabled_dm' before enabling 'greetd'."
  fi
else
  echo "[7/7] No other DMs found. Enabling greetd..."
  sudo systemctl enable greetd
fi

echo "Setup complete. Reboot to use greetd with tuigreet and the custom font."
